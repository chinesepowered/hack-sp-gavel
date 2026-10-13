import 'dart:math' as math;

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../ranking/crowd_bt.dart';
import 'live_service.dart';

/// The judging flow: who goes where next, and what happens when a judge
/// votes or skips.
class JudgingService {
  JudgingService._();

  static final _random = math.Random();

  /// Absent reports after which a project is paused automatically.
  static const autoPauseAbsentReports = 2;

  static Future<Judge> judgeForToken(
    Session session,
    String token, {
    Transaction? transaction,
    LockMode? lockMode,
  }) async {
    final judge = await Judge.db.findFirstRow(
      session,
      where: (t) => t.token.equals(token),
      transaction: transaction,
      lockMode: lockMode,
    );
    if (judge == null) {
      throw GavelException(message: 'This judging link is not valid.');
    }
    return judge;
  }

  static Future<Event> eventFor(
    Session session,
    Judge judge, {
    Transaction? transaction,
  }) async {
    final event = await Event.db.findById(
      session,
      judge.eventId,
      transaction: transaction,
    );
    if (event == null) throw GavelException(message: 'Event not found.');
    return event;
  }

  /// Picks the most useful project for [judge] to visit next.
  ///
  /// Mirrors the classic expo-judging policy: prefer prioritized projects,
  /// avoid tables another judge is already at, make sure every project gets
  /// a minimum number of views, then maximize expected information gain
  /// (with epsilon-greedy exploration).
  static Future<Project?> chooseNext(
    Session session,
    Event event,
    Judge judge, {
    Transaction? transaction,
  }) async {
    final projects = await Project.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!) & t.active.equals(true),
      transaction: transaction,
    );
    final visits = await Visit.db.find(
      session,
      where: (t) => t.judgeId.equals(judge.id!),
      transaction: transaction,
    );
    final visited = visits.map((v) => v.projectId).toSet();

    final available = projects
        .where(
          (p) =>
              !visited.contains(p.id) &&
              p.id != judge.currentProjectId &&
              p.id != judge.previousProjectId,
        )
        .toList();
    if (available.isEmpty) return null;

    final prioritized = available.where((p) => p.prioritized).toList();
    final items = prioritized.isNotEmpty ? prioritized : available;

    final busyCutoff = DateTime.now().toUtc().subtract(
      Duration(minutes: event.assignmentTimeoutMinutes),
    );
    final otherJudges = await Judge.db.find(
      session,
      where: (t) =>
          t.eventId.equals(event.id!) &
          t.active.equals(true) &
          t.id.notEquals(judge.id!) &
          t.currentProjectId.notEquals(null) &
          (t.assignedAt > busyCutoff),
      transaction: transaction,
    );
    final busy = otherJudges.map((j) => j.currentProjectId).toSet();
    final notBusy = items.where((p) => !busy.contains(p.id)).toList();
    final preferred = notBusy.isNotEmpty ? notBusy : items;

    final lessSeen = preferred
        .where((p) => p.timesSeen < event.minViews)
        .toList();
    final candidates = (lessSeen.isNotEmpty ? lessSeen : preferred)
      ..shuffle(_random);

    final previous = judge.previousProjectId == null
        ? null
        : await Project.db.findById(
            session,
            judge.previousProjectId!,
            transaction: transaction,
          );
    if (previous == null || _random.nextDouble() < CrowdBT.epsilon) {
      return candidates.first;
    }

    Project? best;
    var bestGain = double.negativeInfinity;
    for (final candidate in candidates) {
      final gain = CrowdBT.expectedInformationGain(
        alpha: judge.alpha,
        beta: judge.beta,
        muA: previous.mu,
        sigmaSqA: previous.sigmaSq,
        muB: candidate.mu,
        sigmaSqB: candidate.sigmaSq,
      );
      if (gain > bestGain) {
        bestGain = gain;
        best = candidate;
      }
    }
    return best;
  }

  /// Sends [judge] to their next project (or marks them finished).
  static Future<Judge> assignNext(
    Session session,
    Event event,
    Judge judge, {
    Transaction? transaction,
  }) async {
    final next = await chooseNext(
      session,
      event,
      judge,
      transaction: transaction,
    );
    judge.currentProjectId = next?.id;
    judge.assignedAt = next == null ? null : DateTime.now().toUtc();
    return Judge.db.updateRow(session, judge, transaction: transaction);
  }

  /// Starts (or resumes) judging.
  static Future<JudgeState> begin(Session session, String token) async {
    var judge = await judgeForToken(session, token);
    final event = await eventFor(session, judge);
    if (event.status == EventStatus.live &&
        judge.active &&
        judge.currentProjectId == null) {
      judge = await assignNext(session, event, judge);
      await LiveService.notify(session, event.id!);
    }
    return buildState(session, judge, event);
  }

  /// The judge finished looking at their very first project.
  static Future<JudgeState> finishFirstVisit(
    Session session,
    String token,
  ) async {
    late Judge judge;
    late Event event;
    String? message;
    await session.db.transaction((tx) async {
      judge = await judgeForToken(
        session,
        token,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      event = await eventFor(session, judge, transaction: tx);
      _ensureCanAct(event, judge);
      final currentId = judge.currentProjectId;
      if (currentId == null || judge.previousProjectId != null) return;

      final current = await Project.db.findById(
        session,
        currentId,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      if (current == null) return;
      current.timesSeen++;
      await Project.db.updateRow(session, current, transaction: tx);
      await _recordVisit(session, judge, currentId, VisitOutcome.judged, tx);

      judge
        ..previousProjectId = currentId
        ..currentProjectId = null
        ..lastActiveAt = DateTime.now().toUtc();
      judge = await assignNext(session, event, judge, transaction: tx);
      message = '${judge.name} saw their first project: ${current.name}';
    });
    if (message != null) {
      await LiveService.log(session, event.id!, ActivityKind.vote, message!);
    }
    return buildState(session, judge, event);
  }

  /// Records a pairwise comparison and updates every posterior involved.
  static Future<JudgeState> vote(
    Session session,
    String token,
    VoteChoice choice,
  ) async {
    late Judge judge;
    late Event event;
    String? message;
    await session.db.transaction((tx) async {
      judge = await judgeForToken(
        session,
        token,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      event = await eventFor(session, judge, transaction: tx);
      _ensureCanAct(event, judge);
      final currentId = judge.currentProjectId;
      final previousId = judge.previousProjectId;
      if (currentId == null || previousId == null) return;

      // Lock both projects in a stable order so concurrent votes on the same
      // pair can never deadlock.
      final locked = await Project.db.find(
        session,
        where: (t) => t.id.inSet(<int>{currentId, previousId}),
        orderBy: (t) => t.id,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      final current = locked.firstWhere((p) => p.id == currentId);
      final previous = locked.firstWhere((p) => p.id == previousId);

      final winner = choice == VoteChoice.current ? current : previous;
      final loser = choice == VoteChoice.current ? previous : current;
      final update = CrowdBT.update(
        alpha: judge.alpha,
        beta: judge.beta,
        muWinner: winner.mu,
        sigmaSqWinner: winner.sigmaSq,
        muLoser: loser.mu,
        sigmaSqLoser: loser.sigmaSq,
      );
      winner
        ..mu = update.muWinner
        ..sigmaSq = update.sigmaSqWinner;
      loser
        ..mu = update.muLoser
        ..sigmaSq = update.sigmaSqLoser;
      current.timesSeen++;
      await Project.db.update(session, [winner, loser], transaction: tx);

      await Vote.db.insertRow(
        session,
        Vote(
          eventId: event.id!,
          judgeId: judge.id!,
          winnerId: winner.id!,
          loserId: loser.id!,
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: tx,
      );
      final voteNumber = await Vote.db.count(
        session,
        where: (t) => t.eventId.equals(event.id!),
        transaction: tx,
      );
      await ScoreSnapshot.db.insert(session, [
        for (final p in [winner, loser])
          ScoreSnapshot(
            eventId: event.id!,
            projectId: p.id!,
            mu: p.mu,
            sigmaSq: p.sigmaSq,
            voteNumber: voteNumber,
            createdAt: DateTime.now().toUtc(),
          ),
      ], transaction: tx);
      await _recordVisit(session, judge, currentId, VisitOutcome.judged, tx);

      judge
        ..alpha = update.alpha
        ..beta = update.beta
        ..votesCast = judge.votesCast + 1
        ..previousProjectId = currentId
        ..currentProjectId = null
        ..lastActiveAt = DateTime.now().toUtc();
      judge = await assignNext(session, event, judge, transaction: tx);
      message = '${judge.name} preferred ${winner.name} over ${loser.name}';
    });
    if (message != null) {
      await LiveService.log(session, event.id!, ActivityKind.vote, message!);
    }
    return buildState(session, judge, event);
  }

  /// The judge could not judge the project they were sent to.
  static Future<JudgeState> skip(
    Session session,
    String token,
    SkipReason reason,
  ) async {
    late Judge judge;
    late Event event;
    final messages = <(ActivityKind, String)>[];
    await session.db.transaction((tx) async {
      judge = await judgeForToken(
        session,
        token,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      event = await eventFor(session, judge, transaction: tx);
      _ensureCanAct(event, judge);
      final currentId = judge.currentProjectId;
      if (currentId == null) return;

      final project = await Project.db.findById(
        session,
        currentId,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      await _recordVisit(
        session,
        judge,
        currentId,
        VisitOutcome.skipped,
        tx,
        reason: reason,
      );
      if (project != null) {
        messages.add((
          ActivityKind.skip,
          '${judge.name} skipped ${project.name} (${reason.name})',
        ));
        if (reason == SkipReason.absent) {
          project.absentReports++;
          if (project.active &&
              project.absentReports >= autoPauseAbsentReports) {
            project.active = false;
            messages.add((
              ActivityKind.project,
              '${project.name} was paused after '
                  '${project.absentReports} absent reports',
            ));
          }
          await Project.db.updateRow(session, project, transaction: tx);
        }
      }
      judge
        ..skips = judge.skips + 1
        ..currentProjectId = null
        ..lastActiveAt = DateTime.now().toUtc();
      judge = await assignNext(session, event, judge, transaction: tx);
    });
    for (final (kind, message) in messages) {
      await LiveService.log(session, event.id!, kind, message);
    }
    return buildState(session, judge, event);
  }

  /// Re-routes every judge currently heading to [projectId] (used when an
  /// organizer pauses a project).
  static Future<void> rerouteJudgesAt(
    Session session,
    Event event,
    int projectId,
  ) async {
    final judges = await Judge.db.find(
      session,
      where: (t) => t.currentProjectId.equals(projectId),
    );
    for (final judge in judges) {
      await session.db.transaction((tx) async {
        final fresh = await Judge.db.findById(
          session,
          judge.id!,
          transaction: tx,
          lockMode: LockMode.forUpdate,
        );
        if (fresh == null || fresh.currentProjectId != projectId) return;
        fresh.currentProjectId = null;
        await assignNext(session, event, fresh, transaction: tx);
      });
      await LiveService.notifyJudge(session, judge);
    }
  }

  static void _ensureCanAct(Event event, Judge judge) {
    if (event.status != EventStatus.live) {
      throw GavelException(message: 'Judging is not open right now.');
    }
    if (!judge.active) {
      throw GavelException(message: 'An organizer paused your judging seat.');
    }
  }

  static Future<void> _recordVisit(
    Session session,
    Judge judge,
    int projectId,
    VisitOutcome outcome,
    Transaction tx, {
    SkipReason? reason,
  }) async {
    final existing = await Visit.db.findFirstRow(
      session,
      where: (t) => t.judgeId.equals(judge.id!) & t.projectId.equals(projectId),
      transaction: tx,
    );
    if (existing != null) return;
    await Visit.db.insertRow(
      session,
      Visit(
        eventId: judge.eventId,
        judgeId: judge.id!,
        projectId: projectId,
        outcome: outcome,
        skipReason: reason,
        createdAt: DateTime.now().toUtc(),
      ),
      transaction: tx,
    );
  }

  /// What the judge's phone should show.
  static Future<JudgeState> buildState(
    Session session,
    Judge judge,
    Event event, {
    String? notice,
  }) async {
    final current = judge.currentProjectId == null
        ? null
        : await Project.db.findById(session, judge.currentProjectId!);
    final previous = judge.previousProjectId == null
        ? null
        : await Project.db.findById(session, judge.previousProjectId!);
    final projectsSeen = await Visit.db.count(
      session,
      where: (t) => t.judgeId.equals(judge.id!),
    );
    final projectsTotal = await Project.db.count(
      session,
      where: (t) => t.eventId.equals(event.id!) & t.active.equals(true),
    );

    final JudgePhase phase;
    if (!judge.active) {
      phase = JudgePhase.inactive;
    } else if (event.status != EventStatus.live) {
      phase = JudgePhase.closed;
    } else if (current != null) {
      phase = previous == null ? JudgePhase.visit : JudgePhase.compare;
    } else if (projectsSeen == 0) {
      phase = JudgePhase.ready;
    } else {
      phase = JudgePhase.finished;
    }

    return JudgeState(
      judgeId: judge.id!,
      judgeName: judge.name,
      eventName: event.name,
      eventStatus: event.status,
      phase: phase,
      current: current == null ? null : card(current),
      previous: previous == null ? null : card(previous),
      votesCast: judge.votesCast,
      projectsSeen: projectsSeen,
      projectsTotal: projectsTotal,
      notice: notice,
      voiceNotesEnabled:
          (session.passwords['elevenLabsApiKey'] ?? '').isNotEmpty,
    );
  }

  static ProjectCard card(Project p) => ProjectCard(
    id: p.id!,
    name: p.name,
    location: p.location,
    description: p.description,
    team: p.team,
    link: p.link,
  );
}
