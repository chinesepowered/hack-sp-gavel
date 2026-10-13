import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/codes.dart';
import '../services/judging_service.dart';
import '../services/live_service.dart';

/// The judge's phone. Judges never create an account: every call carries the
/// secret token from their personal magic link.
class JudgeEndpoint extends Endpoint {
  /// Public info for the join screen.
  Future<EventPublicInfo> lookup(Session session, String judgeCode) async {
    final event = await _eventForCode(session, judgeCode);
    return EventPublicInfo(
      name: event.name,
      tagline: event.tagline,
      status: event.status,
      projectCount: await Project.db.count(
        session,
        where: (t) => t.eventId.equals(event.id!) & t.active.equals(true),
      ),
      judgeCount: await Judge.db.count(
        session,
        where: (t) => t.eventId.equals(event.id!),
      ),
    );
  }

  /// Self-service join from the event QR code / judge code.
  Future<JoinResult> join(
    Session session,
    String judgeCode,
    String name,
  ) async {
    final event = await _eventForCode(session, judgeCode);
    final trimmed = name.trim();
    if (trimmed.isEmpty) throw GavelException(message: 'Tell us your name.');
    if (event.status == EventStatus.closed) {
      throw GavelException(message: 'Judging for ${event.name} has closed.');
    }
    final judge = await Judge.db.insertRow(
      session,
      Judge(
        eventId: event.id!,
        name: trimmed.length > 40 ? trimmed.substring(0, 40) : trimmed,
        token: newSecret(),
        createdAt: DateTime.now().toUtc(),
        lastActiveAt: DateTime.now().toUtc(),
      ),
    );
    await LiveService.log(
      session,
      event.id!,
      ActivityKind.join,
      '${judge.name} joined as a judge',
    );
    return JoinResult(
      token: judge.token!,
      state: await JudgingService.buildState(session, judge, event),
    );
  }

  Future<JudgeState> state(Session session, String token) async {
    final judge = await JudgingService.judgeForToken(session, token);
    final event = await JudgingService.eventFor(session, judge);
    return JudgingService.buildState(session, judge, event);
  }

  /// Starts judging (or checks for newly available projects).
  Future<JudgeState> begin(Session session, String token) =>
      JudgingService.begin(session, token);

  /// Done with the first project: there is nothing to compare it with yet.
  Future<JudgeState> finishFirstVisit(Session session, String token) =>
      JudgingService.finishFirstVisit(session, token);

  /// Was the current project better than the previous one?
  Future<JudgeState> vote(Session session, String token, VoteChoice choice) =>
      JudgingService.vote(session, token, choice);

  Future<JudgeState> skip(Session session, String token, SkipReason reason) =>
      JudgingService.skip(session, token, reason);

  /// A typed note about a project the judge has seen or is visiting.
  Future<NoteView> addNote(
    Session session,
    String token,
    int projectId,
    String text,
  ) async {
    final judge = await JudgingService.judgeForToken(session, token);
    final trimmed = text.trim();
    if (trimmed.isEmpty) throw GavelException(message: 'The note is empty.');
    final note = await saveNote(
      session,
      judge,
      projectId,
      trimmed,
      NoteSource.typed,
    );
    return note;
  }

  /// Pushes a fresh state whenever the server re-routes this judge (project
  /// paused, event opened or closed, seat paused by an organizer).
  Stream<JudgeState> watch(Session session, String token) async* {
    var judge = await JudgingService.judgeForToken(session, token);
    final pings = session.messages.createStream<LivePing>(
      LiveService.judgeChannel(judge.id!),
    );
    await for (final _ in pings) {
      judge = await JudgingService.judgeForToken(session, token);
      final event = await JudgingService.eventFor(session, judge);
      yield await JudgingService.buildState(
        session,
        judge,
        event,
        notice: 'Your assignment was updated by the organizers.',
      );
    }
  }

  static Future<NoteView> saveNote(
    Session session,
    Judge judge,
    int projectId,
    String text,
    NoteSource source,
  ) async {
    final project = await Project.db.findById(session, projectId);
    if (project == null || project.eventId != judge.eventId) {
      throw GavelException(message: 'Project not found.');
    }
    final note = await JudgeNote.db.insertRow(
      session,
      JudgeNote(
        eventId: judge.eventId,
        judgeId: judge.id!,
        projectId: projectId,
        text: text.length > 2000 ? text.substring(0, 2000) : text,
        source: source,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    await LiveService.log(
      session,
      judge.eventId,
      ActivityKind.note,
      '${judge.name} left a ${source == NoteSource.voice ? 'voice' : ''} '
              'note on ${project.name}'
          .replaceAll('  ', ' '),
    );
    return NoteView(
      judgeName: judge.name,
      text: note.text,
      source: note.source,
      createdAt: note.createdAt,
    );
  }

  static Future<Event> _eventForCode(Session session, String code) async {
    final normalized = code.trim().toUpperCase();
    final event = await Event.db.findFirstRow(
      session,
      where: (t) => t.judgeCode.equals(normalized),
    );
    if (event == null) {
      throw GavelException(message: 'No event found for code "$normalized".');
    }
    return event;
  }
}
