import 'dart:async';
import 'dart:math' as math;

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../ranking/bradley_terry.dart';
import '../ranking/crowd_bt.dart';
import '../ranking/podium.dart';

/// Real-time plumbing: server events, the activity feed and the snapshots
/// streamed to organizer dashboards.
class LiveService {
  LiveService._();

  /// Channel pinged whenever anything changes in an event.
  static String eventChannel(int eventId) => 'gavel-event-$eventId';

  /// Channel pinged when one judge's assignment changed out of band
  /// (organizer paused the project they were walking to, event closed...).
  static String judgeChannel(int judgeId) => 'gavel-judge-$judgeId';

  static const _snapshotInterval = Duration(milliseconds: 350);

  /// Tells every open dashboard of [eventId] that something changed.
  static Future<void> notify(Session session, int eventId) async {
    await session.messages.postMessage(
      eventChannel(eventId),
      LivePing(eventId: eventId),
    );
  }

  /// Tells one judge's phone to refresh its state.
  static Future<void> notifyJudge(Session session, Judge judge) async {
    await session.messages.postMessage(
      judgeChannel(judge.id!),
      LivePing(eventId: judge.eventId),
    );
  }

  /// Appends to the activity feed and notifies dashboards.
  static Future<void> log(
    Session session,
    int eventId,
    ActivityKind kind,
    String message,
  ) async {
    await ActivityLog.db.insertRow(
      session,
      ActivityLog(
        eventId: eventId,
        kind: kind,
        message: message,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    await notify(session, eventId);
  }

  /// A throttled stream of full snapshots: one immediately, then at most one
  /// every [_snapshotInterval] while changes keep coming in.
  static Stream<LiveSnapshot> watch(Session session, int eventId) {
    late final StreamController<LiveSnapshot> controller;
    StreamSubscription<LivePing>? pings;
    Timer? timer;
    var dirty = true;
    var building = false;

    Future<void> flush() async {
      if (!dirty || building || controller.isClosed) return;
      dirty = false;
      building = true;
      try {
        final snap = await snapshot(session, eventId);
        if (!controller.isClosed) controller.add(snap);
      } catch (e, stackTrace) {
        session.log(
          'Failed to build live snapshot',
          level: LogLevel.warning,
          exception: e,
          stackTrace: stackTrace,
        );
      } finally {
        building = false;
      }
    }

    controller = StreamController<LiveSnapshot>(
      onListen: () {
        pings = session.messages
            .createStream<LivePing>(eventChannel(eventId))
            .listen((_) => dirty = true);
        timer = Timer.periodic(_snapshotInterval, (_) => flush());
        unawaited(flush());
      },
      onCancel: () async {
        timer?.cancel();
        await pings?.cancel();
      },
    );
    return controller.stream;
  }

  /// Builds the full live state of an event.
  static Future<LiveSnapshot> snapshot(Session session, int eventId) async {
    final event = await Event.db.findById(session, eventId);
    if (event == null) throw GavelException(message: 'Event not found.');

    final projects = await Project.db.find(
      session,
      where: (t) => t.eventId.equals(eventId),
    );
    final judges = await Judge.db.find(
      session,
      where: (t) => t.eventId.equals(eventId),
      orderBy: (t) => t.createdAt,
    );
    final votes = await Vote.db.find(
      session,
      where: (t) => t.eventId.equals(eventId),
    );
    final activity = await ActivityLog.db.find(
      session,
      where: (t) => t.eventId.equals(eventId),
      orderBy: (t) => t.createdAt.desc(),
      limit: 40,
    );

    final leaderboard = buildLeaderboard(projects, votes);
    final projectById = {for (final p in projects) p.id!: p};

    final agreement = leaveOneOutAgreement(projectById.keys, [
      for (final v in votes)
        (judge: v.judgeId, winner: v.winnerId, loser: v.loserId),
    ]);
    final judgeSummaries = [
      for (final judge in judges)
        _judgeSummary(judge, agreement[judge.id] ?? 1, projectById),
    ];

    final active = projects.where((p) => p.active).toList();
    final averageViews = active.isEmpty
        ? 0.0
        : active.map((p) => p.timesSeen).reduce((a, b) => a + b) /
              active.length;
    final coverage = active.isEmpty
        ? 0.0
        : active.where((p) => p.timesSeen >= event.minViews).length /
              active.length;

    final podium = estimatePodium(
      [
        for (final p in active) (id: p.id!, mu: p.mu, sigmaSq: p.sigmaSq),
      ],
      seed: votes.length,
    );

    return LiveSnapshot(
      eventId: eventId,
      status: event.status,
      simulationRunning: event.simulationRunning,
      resultsPublished: event.resultsPublished,
      leaderboard: leaderboard,
      judges: judgeSummaries,
      activity: [
        for (final a in activity)
          ActivityItem(kind: a.kind, message: a.message, at: a.createdAt),
      ],
      totalVotes: votes.length,
      activeJudges: judges
          .where((j) => j.active && j.currentProjectId != null)
          .length,
      podiumCertainty: votes.isEmpty ? 0 : podium.certainty,
      averageViews: averageViews,
      coverage: coverage,
      closesAt: event.closesAt,
      serverTime: DateTime.now().toUtc(),
    );
  }

  /// Ranks projects by posterior mean (ties broken by lower uncertainty).
  static List<LeaderboardEntry> buildLeaderboard(
    List<Project> projects,
    List<Vote> votes, {
    bool activeOnly = false,
  }) {
    final wins = <int, int>{};
    final losses = <int, int>{};
    for (final vote in votes) {
      wins[vote.winnerId] = (wins[vote.winnerId] ?? 0) + 1;
      losses[vote.loserId] = (losses[vote.loserId] ?? 0) + 1;
    }

    final ranked = projects.where((p) => !activeOnly || p.active).toList()
      ..sort((a, b) {
        if (a.active != b.active) return a.active ? -1 : 1;
        final byMu = b.mu.compareTo(a.mu);
        return byMu != 0 ? byMu : a.sigmaSq.compareTo(b.sigmaSq);
      });

    final active = ranked.where((p) => p.active).toList();
    final podium = estimatePodium(
      [
        for (final p in active) (id: p.id!, mu: p.mu, sigmaSq: p.sigmaSq),
      ],
      seed: votes.length,
    );

    return [
      for (var i = 0; i < ranked.length; i++)
        LeaderboardEntry(
          projectId: ranked[i].id!,
          rank: i + 1,
          name: ranked[i].name,
          location: ranked[i].location,
          team: ranked[i].team,
          mu: ranked[i].mu,
          sigma: math.sqrt(ranked[i].sigmaSq),
          timesSeen: ranked[i].timesSeen,
          active: ranked[i].active,
          prioritized: ranked[i].prioritized,
          absentReports: ranked[i].absentReports,
          podiumProbability: votes.isEmpty
              ? 0
              : podium.podiumProbability[ranked[i].id!] ?? 0,
          wins: wins[ranked[i].id!] ?? 0,
          losses: losses[ranked[i].id!] ?? 0,
        ),
    ];
  }

  static JudgeSummary _judgeSummary(
    Judge judge,
    double agreement,
    Map<int, Project> projectById,
  ) {
    final current = judge.currentProjectId == null
        ? null
        : projectById[judge.currentProjectId!];
    return JudgeSummary(
      id: judge.id!,
      name: judge.name,
      alpha: judge.alpha,
      beta: judge.beta,
      reliability: CrowdBT.reliability(judge.alpha, judge.beta),
      agreement: agreement,
      votesCast: judge.votesCast,
      skips: judge.skips,
      active: judge.active,
      isSimulated: judge.isSimulated,
      currentProjectName: current?.name,
      currentLocation: current?.location,
      lastActiveAt: judge.lastActiveAt,
    );
  }

  /// How each of the current top projects' scores evolved, vote by vote.
  static Future<List<ConvergenceSeries>> convergence(
    Session session,
    int eventId, {
    int top = 6,
  }) async {
    final projects = await Project.db.find(
      session,
      where: (t) => t.eventId.equals(eventId) & t.active.equals(true),
      orderBy: (t) => t.mu.desc(),
      limit: top,
    );
    if (projects.isEmpty) return [];
    final ids = projects.map((p) => p.id!).toSet();
    final snapshots = await ScoreSnapshot.db.find(
      session,
      where: (t) => t.eventId.equals(eventId) & t.projectId.inSet(ids),
      orderBy: (t) => t.voteNumber,
    );
    return [
      for (final project in projects)
        () {
          final own = snapshots.where((s) => s.projectId == project.id);
          return ConvergenceSeries(
            projectId: project.id!,
            name: project.name,
            voteNumbers: [0, ...own.map((s) => s.voteNumber)],
            mus: [CrowdBT.muPrior, ...own.map((s) => s.mu)],
          );
        }(),
    ];
  }
}
