import 'package:gavel_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _organizerId = '0199c3a4-7b1e-7cc0-9d2a-4f1f6c0e8a11';
const _strangerId = '0199c3a4-7b1e-7cc0-9d2a-4f1f6c0e8a22';

const _csv = '''name,location,team,description
Ripple,Table 1,Tidewater,Flood early warning
Sign Speak,Table 2,Hands Up,ASL captions
Plant Pal,Table 3,Green Thumbs,Talking plants
"Sous, the chef",Table 4,Mise en Place,Recipes from your fridge''';

void main() {
  withServerpod('Given an organizer running an event', (
    sessionBuilder,
    endpoints,
  ) {
    final organizer = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        _organizerId,
        {},
      ),
    );
    final stranger = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        _strangerId,
        {},
      ),
    );

    Future<OrganizerEvent> liveEvent() async {
      final created = await endpoints.organizer.createEvent(
        organizer,
        'Test Hack',
        'A tagline',
      );
      final imported = await endpoints.organizer.importProjects(
        organizer,
        created.event.id!,
        _csv,
      );
      expect(imported, 4);
      return endpoints.organizer.setStatus(
        organizer,
        created.event.id!,
        EventStatus.live,
      );
    }

    test('when importing CSV then quoted names with commas survive', () async {
      final event = await liveEvent();
      final projects = await endpoints.organizer.projects(
        organizer,
        event.event.id!,
      );
      expect(projects.map((p) => p.name), contains('Sous, the chef'));
    });

    test('when a stranger opens the event then access is denied', () async {
      final event = await liveEvent();
      await expectLater(
        endpoints.organizer.getEvent(stranger, event.event.id!),
        throwsA(isA<GavelException>()),
      );
    });

    test(
      'when a judge joins and votes then the leaderboard reflects it',
      () async {
        final event = await liveEvent();
        final code = event.event.judgeCode;

        final join = await endpoints.judge.join(sessionBuilder, code, 'Ada');
        expect(join.state.phase, JudgePhase.ready);

        var state = await endpoints.judge.begin(sessionBuilder, join.token);
        expect(state.phase, JudgePhase.visit);
        final first = state.current!;

        state = await endpoints.judge.finishFirstVisit(
          sessionBuilder,
          join.token,
        );
        expect(state.phase, JudgePhase.compare);
        expect(state.previous!.id, first.id);
        final second = state.current!;

        // The judge prefers the current project.
        state = await endpoints.judge.vote(
          sessionBuilder,
          join.token,
          VoteChoice.current,
        );
        expect(state.votesCast, 1);
        expect(state.previous!.id, second.id);

        final snapshot = await endpoints.organizer.snapshot(
          organizer,
          event.event.id!,
        );
        expect(snapshot.totalVotes, 1);
        final winner = snapshot.leaderboard.firstWhere(
          (e) => e.projectId == second.id,
        );
        final loser = snapshot.leaderboard.firstWhere(
          (e) => e.projectId == first.id,
        );
        expect(winner.mu, greaterThan(loser.mu));
        expect(winner.wins, 1);
        expect(snapshot.activity.first.message, contains('Ada preferred'));
      },
    );

    test('when a judge finishes every project then they are told so', () async {
      final event = await liveEvent();
      final join = await endpoints.judge.join(
        sessionBuilder,
        event.event.judgeCode,
        'Grace',
      );
      var state = await endpoints.judge.begin(sessionBuilder, join.token);
      state = await endpoints.judge.finishFirstVisit(
        sessionBuilder,
        join.token,
      );
      while (state.phase == JudgePhase.compare) {
        state = await endpoints.judge.vote(
          sessionBuilder,
          join.token,
          VoteChoice.previous,
        );
      }
      expect(state.phase, JudgePhase.finished);
      expect(state.votesCast, 3);
      expect(state.projectsSeen, 4);
    });

    test(
      'when two judges report a team absent then the project is paused',
      () async {
        final event = await liveEvent();
        final code = event.event.judgeCode;
        final a = await endpoints.judge.join(sessionBuilder, code, 'A');
        final stateA = await endpoints.judge.begin(sessionBuilder, a.token);
        final target = stateA.current!.id;
        await endpoints.judge.skip(sessionBuilder, a.token, SkipReason.absent);

        // Point a second judge at the same table and report it again.
        final b = await endpoints.judge.join(sessionBuilder, code, 'B');
        var stateB = await endpoints.judge.begin(sessionBuilder, b.token);
        while (stateB.current!.id != target) {
          stateB = await endpoints.judge.skip(
            sessionBuilder,
            b.token,
            SkipReason.conflict,
          );
        }
        await endpoints.judge.skip(sessionBuilder, b.token, SkipReason.absent);

        final projects = await endpoints.organizer.projects(
          organizer,
          event.event.id!,
        );
        final paused = projects.firstWhere((p) => p.id == target);
        expect(paused.active, isFalse);
        expect(paused.absentReports, 2);
      },
    );

    test(
      'when an organizer pauses a table then judges heading there are re-routed',
      () async {
        final event = await liveEvent();
        final join = await endpoints.judge.join(
          sessionBuilder,
          event.event.judgeCode,
          'Margaret',
        );
        final before = await endpoints.judge.begin(sessionBuilder, join.token);
        final target = before.current!.id;

        await endpoints.organizer.setProjectActive(organizer, target, false);

        final after = await endpoints.judge.state(sessionBuilder, join.token);
        expect(after.current, isNotNull);
        expect(after.current!.id, isNot(target));
      },
    );

    test('when judging is closed then judges cannot vote', () async {
      final event = await liveEvent();
      final join = await endpoints.judge.join(
        sessionBuilder,
        event.event.judgeCode,
        'Linus',
      );
      await endpoints.judge.begin(sessionBuilder, join.token);
      await endpoints.organizer.setStatus(
        organizer,
        event.event.id!,
        EventStatus.closed,
      );
      final state = await endpoints.judge.state(sessionBuilder, join.token);
      expect(state.phase, JudgePhase.closed);
      await expectLater(
        endpoints.judge.finishFirstVisit(sessionBuilder, join.token),
        throwsA(isA<GavelException>()),
      );
    });

    test(
      'when results are unpublished then the public endpoint refuses',
      () async {
        final event = await liveEvent();
        await expectLater(
          endpoints.results.get(sessionBuilder, event.event.slug),
          throwsA(isA<GavelException>()),
        );
        await endpoints.organizer.publishResults(
          organizer,
          event.event.id!,
          true,
        );
        final results = await endpoints.results.get(
          sessionBuilder,
          event.event.slug,
        );
        expect(results.entries, hasLength(4));
      },
    );

    test(
      'when a co-organizer uses the admin link then they get access',
      () async {
        final event = await liveEvent();
        final claimed = await endpoints.organizer.claimEvent(
          stranger,
          event.adminKey,
        );
        expect(claimed.isOwner, isFalse);
        final view = await endpoints.organizer.getEvent(
          stranger,
          event.event.id!,
        );
        expect(view.event.id, event.event.id);
      },
    );

    test('when creating a demo event then 24 projects are ready', () async {
      final demo = await endpoints.organizer.createDemoEvent(organizer);
      expect(demo.event.isDemo, isTrue);
      final projects = await endpoints.organizer.projects(
        organizer,
        demo.event.id!,
      );
      expect(projects, hasLength(24));
    });
  });
}
