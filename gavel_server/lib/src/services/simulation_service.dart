import 'dart:math' as math;

import 'package:serverpod/serverpod.dart';

import '../generated/future_calls.dart';
import '../generated/protocol.dart';
import 'codes.dart';
import 'event_service.dart';
import 'judging_service.dart';
import 'live_service.dart';

/// Simulated judges for demo events, driven by a self-rescheduling future
/// call. They walk the same code path as real judges (same endpoints logic,
/// same transactions), so the demo exercises the real system.
class SimulationService {
  SimulationService._();

  static final _random = math.Random();
  static const tickInterval = Duration(milliseconds: 1200);

  static const _personas = <(String, String)>[
    ('Ada', 'careful'),
    ('Grace', 'careful'),
    ('Linus', 'noisy'),
    ('Margaret', 'careful'),
    ('Chaos Carl', 'contrarian'),
    ('Alan', 'noisy'),
    ('Barbara', 'careful'),
    ('Dennis', 'careful'),
    ('Radia', 'noisy'),
    ('Ken', 'careful'),
    ('Frances', 'careful'),
    ('Guido', 'noisy'),
    ('Hedy', 'careful'),
    ('Edsger', 'careful'),
    ('Katherine', 'noisy'),
    ('Tim', 'careful'),
  ];

  static int get maxJudges => _personas.length;

  static String identifier(int eventId) => 'gavel-sim-$eventId';

  static Future<Event> start(
    Session session,
    Event event,
    int judgeCount,
  ) async {
    if (!event.isDemo) {
      throw GavelException(
        message: 'Simulations only run in demo events, never on real data.',
      );
    }
    final count = judgeCount.clamp(1, maxJudges);
    final existing = await Judge.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!) & t.isSimulated.equals(true),
    );
    final now = DateTime.now().toUtc();
    final toCreate = [
      for (var i = existing.length; i < count; i++)
        Judge(
          eventId: event.id!,
          name: '${_personas[i].$1} (sim)',
          token: newSecret(),
          isSimulated: true,
          simKind: _personas[i].$2,
          simNextActionAt: now.add(
            Duration(milliseconds: _random.nextInt(2500)),
          ),
          createdAt: now,
        ),
    ];
    if (toCreate.isNotEmpty) await Judge.db.insert(session, toCreate);

    var updated = event;
    if (updated.status != EventStatus.live) {
      updated = await EventService.setStatus(
        session,
        updated,
        EventStatus.live,
      );
    }
    updated.simulationRunning = true;
    updated = await Event.db.updateRow(session, updated);

    await session.serverpod.futureCalls.cancel(identifier(event.id!));
    await session.serverpod.futureCalls
        .callWithDelay(tickInterval, identifier: identifier(event.id!))
        .simulation
        .tick(event.id!);

    await LiveService.log(
      session,
      event.id!,
      ActivityKind.simulation,
      'Simulation started with $count judges (one of them is a contrarian)',
    );
    return updated;
  }

  static Future<Event> stop(Session session, Event event) async {
    await session.serverpod.futureCalls.cancel(identifier(event.id!));
    if (!event.simulationRunning) return event;
    event.simulationRunning = false;
    final updated = await Event.db.updateRow(session, event);
    await LiveService.log(
      session,
      event.id!,
      ActivityKind.simulation,
      'Simulation stopped',
    );
    return updated;
  }

  /// One step: every simulated judge whose "walking time" elapsed acts.
  static Future<void> tick(Session session, int eventId) async {
    final event = await Event.db.findById(session, eventId);
    if (event == null ||
        !event.simulationRunning ||
        event.status != EventStatus.live) {
      return;
    }
    final judges = await Judge.db.find(
      session,
      where: (t) =>
          t.eventId.equals(eventId) &
          t.isSimulated.equals(true) &
          t.active.equals(true),
    );

    final now = DateTime.now().toUtc();
    var stillJudging = 0;
    for (final judge in judges) {
      final due =
          judge.simNextActionAt == null || !judge.simNextActionAt!.isAfter(now);
      if (!due) {
        stillJudging++;
        continue;
      }
      try {
        final state = await _act(session, judge);
        if (state.phase != JudgePhase.finished) stillJudging++;
      } on GavelException catch (e) {
        session.log('Simulated judge ${judge.name}: ${e.message}');
      }
    }

    if (stillJudging == 0) {
      final fresh = await Event.db.findById(session, eventId);
      if (fresh != null && fresh.simulationRunning) {
        fresh.simulationRunning = false;
        await Event.db.updateRow(session, fresh);
        await LiveService.log(
          session,
          eventId,
          ActivityKind.simulation,
          'Simulation finished: every simulated judge has seen every project',
        );
      }
      return;
    }

    await session.serverpod.futureCalls
        .callWithDelay(tickInterval, identifier: identifier(eventId))
        .simulation
        .tick(eventId);
  }

  static Future<JudgeState> _act(Session session, Judge judge) async {
    final token = judge.token!;
    final JudgeState state;
    if (judge.currentProjectId == null) {
      state = await JudgingService.begin(session, token);
    } else if (judge.previousProjectId == null) {
      state = await JudgingService.finishFirstVisit(session, token);
    } else {
      final choice = await _decide(session, judge);
      state = await JudgingService.vote(session, token, choice);
    }

    // Time spent walking to and looking at the next table.
    final (minMs, maxMs) = switch (judge.simKind) {
      'noisy' => (2000, 4500),
      'contrarian' => (2500, 5000),
      _ => (3000, 6500),
    };
    final fresh = await Judge.db.findById(session, judge.id!);
    if (fresh != null) {
      fresh.simNextActionAt = DateTime.now().toUtc().add(
        Duration(milliseconds: minMs + _random.nextInt(maxMs - minMs)),
      );
      await Judge.db.updateRow(session, fresh);
    }
    return state;
  }

  /// Simulated judgement based on the hidden ground truth plus noise.
  static Future<VoteChoice> _decide(Session session, Judge judge) async {
    final current = await Project.db.findById(session, judge.currentProjectId!);
    final previous = await Project.db.findById(
      session,
      judge.previousProjectId!,
    );
    final diff = (current?.simTrueScore ?? 0) - (previous?.simTrueScore ?? 0);
    final sharpness = judge.simKind == 'noisy' ? 1.0 : 3.0;
    final pCurrent = 1 / (1 + math.exp(-diff * sharpness));
    var pickCurrent = _random.nextDouble() < pCurrent;
    if (judge.simKind == 'contrarian') {
      // Mostly votes against the truth: exactly what Crowd-BT should catch.
      pickCurrent = _random.nextDouble() < 0.85 ? diff < 0 : diff >= 0;
    }
    return pickCurrent ? VoteChoice.current : VoteChoice.previous;
  }
}
