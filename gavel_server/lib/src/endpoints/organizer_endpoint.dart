import 'dart:math' as math;

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/access.dart';
import '../services/announcement_service.dart';
import '../services/codes.dart';
import '../services/event_service.dart';
import '../services/judging_service.dart';
import '../services/live_service.dart';
import '../services/scheduler.dart';
import '../services/simulation_service.dart';

/// Everything an organizer does: events, projects, judges, live dashboard.
///
/// Requires a signed-in user (email or anonymous account).
class OrganizerEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // ---------------------------------------------------------------- events

  Future<OrganizerEvent> createEvent(
    Session session,
    String name,
    String? tagline,
  ) async {
    final event = await EventService.create(
      session,
      name: name,
      tagline: tagline,
      ownerId: Access.userId(session),
    );
    await LiveService.log(
      session,
      event.id!,
      ActivityKind.status,
      'Event created',
    );
    return _view(session, event);
  }

  /// Creates a sandbox event with 24 sample projects, ready to simulate.
  Future<OrganizerEvent> createDemoEvent(Session session) async {
    final event = await EventService.createDemo(
      session,
      Access.userId(session),
    );
    return _view(session, event);
  }

  Future<List<EventSummary>> myEvents(Session session) async {
    final user = Access.userId(session);
    final memberships = await EventOrganizer.db.find(
      session,
      where: (t) => t.userId.equals(user),
    );
    final memberIds = memberships.map((m) => m.eventId).toSet();
    final events = await Event.db.find(
      session,
      where: (t) =>
          t.ownerId.equals(user) |
          (memberIds.isEmpty ? t.id.equals(-1) : t.id.inSet(memberIds)),
      orderBy: (t) => t.createdAt.desc(),
    );
    return [
      for (final e in events)
        EventSummary(
          id: e.id!,
          name: e.name,
          slug: e.slug,
          status: e.status,
          isDemo: e.isDemo,
          projectCount: await Project.db.count(
            session,
            where: (t) => t.eventId.equals(e.id!),
          ),
          judgeCount: await Judge.db.count(
            session,
            where: (t) => t.eventId.equals(e.id!),
          ),
          voteCount: await Vote.db.count(
            session,
            where: (t) => t.eventId.equals(e.id!),
          ),
          createdAt: e.createdAt,
        ),
    ];
  }

  Future<OrganizerEvent> getEvent(Session session, int eventId) async {
    final event = await Access.organizerEvent(session, eventId);
    return _view(session, event);
  }

  /// Joins an event as co-organizer using its admin link.
  Future<OrganizerEvent> claimEvent(Session session, String adminKey) async {
    final event = await Event.db.findFirstRow(
      session,
      where: (t) => t.adminKey.equals(adminKey),
    );
    if (event == null) {
      throw GavelException(message: 'That admin link is not valid.');
    }
    final user = Access.userId(session);
    if (event.ownerId != user) {
      final existing = await EventOrganizer.db.findFirstRow(
        session,
        where: (t) => t.eventId.equals(event.id!) & t.userId.equals(user),
      );
      if (existing == null) {
        await EventOrganizer.db.insertRow(
          session,
          EventOrganizer(
            eventId: event.id!,
            userId: user,
            createdAt: DateTime.now().toUtc(),
          ),
        );
        await LiveService.log(
          session,
          event.id!,
          ActivityKind.status,
          'A co-organizer joined',
        );
      }
    }
    return _view(session, event);
  }

  Future<OrganizerEvent> updateEvent(
    Session session,
    int eventId,
    String name,
    String? tagline,
    int minViews,
  ) async {
    final event = await Access.organizerEvent(session, eventId);
    if (name.trim().isEmpty) {
      throw GavelException(message: 'Give your event a name.');
    }
    event
      ..name = name.trim()
      ..tagline = (tagline?.trim().isEmpty ?? true) ? null : tagline!.trim()
      ..minViews = minViews.clamp(1, 10);
    final updated = await Event.db.updateRow(session, event);
    await LiveService.notify(session, eventId);
    return _view(session, updated);
  }

  Future<OrganizerEvent> setStatus(
    Session session,
    int eventId,
    EventStatus status,
  ) async {
    final event = await Access.organizerEvent(session, eventId);
    if (status == EventStatus.live) {
      final projectCount = await Project.db.count(
        session,
        where: (t) => t.eventId.equals(eventId) & t.active.equals(true),
      );
      if (projectCount < 2) {
        throw GavelException(
          message: 'Add at least two projects before opening judging.',
        );
      }
    }
    if (status != EventStatus.live) {
      await Scheduler.cancelSimulation(session, eventId);
    }
    final updated = await EventService.setStatus(session, event, status);
    return _view(session, updated);
  }

  /// Schedules judging to close automatically (a persisted future call).
  /// Pass `null` to cancel.
  Future<OrganizerEvent> scheduleClose(
    Session session,
    int eventId,
    DateTime? closesAt,
  ) async {
    final event = await Access.organizerEvent(session, eventId);
    if (closesAt == null) {
      await Scheduler.cancelClose(session, eventId);
    } else {
      final at = closesAt.toUtc();
      if (at.isBefore(DateTime.now().toUtc())) {
        throw GavelException(message: 'Pick a time in the future.');
      }
      await Scheduler.scheduleClose(session, eventId, at);
    }
    event.closesAt = closesAt?.toUtc();
    final updated = await Event.db.updateRow(session, event);
    await LiveService.log(
      session,
      eventId,
      ActivityKind.status,
      closesAt == null
          ? 'Automatic close cancelled'
          : 'Judging will close automatically at ${_hhmm(closesAt.toUtc())} UTC',
    );
    return _view(session, updated);
  }

  Future<OrganizerEvent> publishResults(
    Session session,
    int eventId,
    bool published,
  ) async {
    final event = await Access.organizerEvent(session, eventId);
    event.resultsPublished = published;
    final updated = await Event.db.updateRow(session, event);
    await LiveService.log(
      session,
      eventId,
      ActivityKind.status,
      published ? 'Results page published' : 'Results page hidden',
    );
    return _view(session, updated);
  }

  Future<void> deleteEvent(Session session, int eventId) async {
    final event = await Access.organizerEvent(session, eventId);
    if (!await Access.isOwner(session, event)) {
      throw GavelException(message: 'Only the event owner can delete it.');
    }
    await Scheduler.cancelSimulation(session, eventId);
    await Scheduler.cancelClose(session, eventId);
    await Event.db.deleteRow(session, event);
  }

  // -------------------------------------------------------------- projects

  Future<List<Project>> projects(Session session, int eventId) async {
    await Access.organizerEvent(session, eventId);
    return Project.db.find(
      session,
      where: (t) => t.eventId.equals(eventId),
      orderBy: (t) => t.id,
    );
  }

  Future<Project> addProject(
    Session session,
    int eventId,
    ProjectInput input,
  ) async {
    await Access.organizerEvent(session, eventId);
    final project = await Project.db.insertRow(
      session,
      _projectFromInput(eventId, input),
    );
    await LiveService.log(
      session,
      eventId,
      ActivityKind.project,
      'Project added: ${project.name}',
    );
    return project;
  }

  /// Imports projects from CSV text (`name, location, team, description,
  /// link`). Returns the number of projects created.
  Future<int> importProjects(Session session, int eventId, String csv) async {
    await Access.organizerEvent(session, eventId);
    final inputs = EventService.parseProjectsCsv(csv);
    if (inputs.isEmpty) {
      throw GavelException(message: 'No projects found in that text.');
    }
    await Project.db.insert(session, [
      for (final input in inputs) _projectFromInput(eventId, input),
    ]);
    await LiveService.log(
      session,
      eventId,
      ActivityKind.project,
      'Imported ${inputs.length} projects',
    );
    return inputs.length;
  }

  Future<Project> updateProject(
    Session session,
    int projectId,
    ProjectInput input,
  ) async {
    final (event, project) = await Access.organizerProject(session, projectId);
    project
      ..name = input.name.trim()
      ..location = input.location.trim()
      ..description = input.description.trim()
      ..team = input.team?.trim()
      ..link = input.link?.trim();
    final updated = await Project.db.updateRow(session, project);
    await LiveService.notify(session, event.id!);
    return updated;
  }

  /// Pauses or resumes a project. Judges walking to a paused project are
  /// re-routed instantly over their live connection.
  Future<Project> setProjectActive(
    Session session,
    int projectId,
    bool active,
  ) async {
    final (event, project) = await Access.organizerProject(session, projectId);
    project.active = active;
    if (active) project.absentReports = 0;
    final updated = await Project.db.updateRow(session, project);
    if (!active) {
      await JudgingService.rerouteJudgesAt(session, event, projectId);
    }
    await LiveService.log(
      session,
      event.id!,
      ActivityKind.project,
      '${project.name} ${active ? 'resumed' : 'paused'} by an organizer',
    );
    return updated;
  }

  Future<Project> setProjectPrioritized(
    Session session,
    int projectId,
    bool prioritized,
  ) async {
    final (event, project) = await Access.organizerProject(session, projectId);
    project.prioritized = prioritized;
    final updated = await Project.db.updateRow(session, project);
    await LiveService.log(
      session,
      event.id!,
      ActivityKind.project,
      prioritized
          ? '${project.name} prioritized: judges will be sent there first'
          : '${project.name} is no longer prioritized',
    );
    return updated;
  }

  Future<void> deleteProject(Session session, int projectId) async {
    final (event, project) = await Access.organizerProject(session, projectId);
    await JudgingService.rerouteJudgesAt(session, event, projectId);
    await Project.db.deleteRow(session, project);
    await LiveService.log(
      session,
      event.id!,
      ActivityKind.project,
      'Project removed: ${project.name}',
    );
  }

  Future<ProjectDetail> projectDetail(Session session, int projectId) async {
    final (event, project) = await Access.organizerProject(session, projectId);
    final ranked = await Project.db.find(
      session,
      where: (t) => t.eventId.equals(event.id!) & t.active.equals(true),
      orderBy: (t) => t.mu.desc(),
    );
    final rank = ranked.indexWhere((p) => p.id == projectId) + 1;
    final wins = await Vote.db.count(
      session,
      where: (t) => t.winnerId.equals(projectId),
    );
    final losses = await Vote.db.count(
      session,
      where: (t) => t.loserId.equals(projectId),
    );
    final notes = await JudgeNote.db.find(
      session,
      where: (t) => t.projectId.equals(projectId),
      orderBy: (t) => t.createdAt.desc(),
    );
    final judgeNames = {
      for (final j in await Judge.db.find(
        session,
        where: (t) => t.eventId.equals(event.id!),
      ))
        j.id!: j.name,
    };
    return ProjectDetail(
      project: project,
      rank: rank,
      sigma: math.sqrt(project.sigmaSq),
      wins: wins,
      losses: losses,
      notes: [
        for (final n in notes)
          NoteView(
            judgeName: judgeNames[n.judgeId] ?? 'Judge',
            text: n.text,
            source: n.source,
            createdAt: n.createdAt,
          ),
      ],
    );
  }

  // ---------------------------------------------------------------- judges

  /// Pre-registers a judge and returns the secret token for their magic link.
  Future<String> addJudge(Session session, int eventId, String name) async {
    await Access.organizerEvent(session, eventId);
    if (name.trim().isEmpty) {
      throw GavelException(message: 'Judges need a name.');
    }
    final judge = await Judge.db.insertRow(
      session,
      Judge(
        eventId: eventId,
        name: name.trim(),
        token: newSecret(),
        createdAt: DateTime.now().toUtc(),
      ),
    );
    await LiveService.log(
      session,
      eventId,
      ActivityKind.join,
      'Judge added: ${judge.name}',
    );
    return judge.token!;
  }

  /// The magic-link token of an existing judge (to re-share it).
  Future<String> judgeLink(Session session, int judgeId) async {
    final judge = await Judge.db.findById(session, judgeId);
    if (judge == null) throw GavelException(message: 'Judge not found.');
    await Access.organizerEvent(session, judge.eventId);
    return judge.token!;
  }

  Future<void> setJudgeActive(Session session, int judgeId, bool active) async {
    final judge = await Judge.db.findById(session, judgeId);
    if (judge == null) throw GavelException(message: 'Judge not found.');
    await Access.organizerEvent(session, judge.eventId);
    judge.active = active;
    if (!active) judge.currentProjectId = null;
    await Judge.db.updateRow(session, judge);
    await LiveService.notifyJudge(session, judge);
    await LiveService.log(
      session,
      judge.eventId,
      ActivityKind.join,
      '${judge.name} ${active ? 'reactivated' : 'paused'} by an organizer',
    );
  }

  // ------------------------------------------------------------ simulation

  Future<OrganizerEvent> startSimulation(
    Session session,
    int eventId,
    int judgeCount,
  ) async {
    final event = await Access.organizerEvent(session, eventId);
    final updated = await SimulationService.start(session, event, judgeCount);
    return _view(session, updated);
  }

  Future<OrganizerEvent> stopSimulation(Session session, int eventId) async {
    final event = await Access.organizerEvent(session, eventId);
    final updated = await SimulationService.stop(session, event);
    return _view(session, updated);
  }

  // ------------------------------------------------------------------ live

  /// Live dashboard: a full snapshot now, then a fresh one whenever votes,
  /// skips, joins or organizer actions happen (server events + streaming).
  Stream<LiveSnapshot> watch(Session session, int eventId) async* {
    await Access.organizerEvent(session, eventId);
    yield* LiveService.watch(session, eventId);
  }

  Future<LiveSnapshot> snapshot(Session session, int eventId) async {
    await Access.organizerEvent(session, eventId);
    return LiveService.snapshot(session, eventId);
  }

  Future<List<ConvergenceSeries>> convergence(
    Session session,
    int eventId,
  ) async {
    await Access.organizerEvent(session, eventId);
    return LiveService.convergence(session, eventId);
  }

  /// Builds the awards ceremony: podium + script narrated by ElevenLabs.
  Future<Announcement> announceWinners(Session session, int eventId) async {
    final event = await Access.organizerEvent(session, eventId);
    return AnnouncementService.announce(session, event);
  }

  Future<String> exportCsv(Session session, int eventId) async {
    final event = await Access.organizerEvent(session, eventId);
    final projects = await Project.db.find(
      session,
      where: (t) => t.eventId.equals(eventId),
    );
    final votes = await Vote.db.find(
      session,
      where: (t) => t.eventId.equals(eventId),
    );
    return EventService.exportCsv(
      event,
      LiveService.buildLeaderboard(projects, votes),
    );
  }

  // --------------------------------------------------------------- helpers

  Future<OrganizerEvent> _view(Session session, Event event) async {
    return OrganizerEvent(
      event: event,
      adminKey: event.adminKey ?? '',
      isOwner: event.ownerId == Access.userId(session),
    );
  }

  Project _projectFromInput(int eventId, ProjectInput input) {
    if (input.name.trim().isEmpty) {
      throw GavelException(message: 'Projects need a name.');
    }
    return Project(
      eventId: eventId,
      name: input.name.trim(),
      location: input.location.trim().isEmpty ? 'TBD' : input.location.trim(),
      description: input.description.trim(),
      team: input.team?.trim().isEmpty ?? true ? null : input.team!.trim(),
      link: input.link?.trim().isEmpty ?? true ? null : input.link!.trim(),
      createdAt: DateTime.now().toUtc(),
    );
  }

  static String _hhmm(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}
