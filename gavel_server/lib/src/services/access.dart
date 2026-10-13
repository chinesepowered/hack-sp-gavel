import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Authorization helpers for organizer-only operations.
class Access {
  Access._();

  /// The signed-in user (organizer endpoints all use `requireLogin`).
  static UuidValue userId(Session session) {
    final auth = session.authenticated;
    if (auth == null) {
      throw GavelException(message: 'Please sign in to manage events.');
    }
    return auth.authUserId;
  }

  /// Loads [eventId] and verifies the caller organizes it.
  static Future<Event> organizerEvent(Session session, int eventId) async {
    final event = await Event.db.findById(session, eventId);
    if (event == null) throw GavelException(message: 'Event not found.');
    await ensureOrganizer(session, event);
    return event;
  }

  /// Loads the event a project belongs to and verifies the caller organizes it.
  static Future<(Event, Project)> organizerProject(
    Session session,
    int projectId,
  ) async {
    final project = await Project.db.findById(session, projectId);
    if (project == null) throw GavelException(message: 'Project not found.');
    final event = await organizerEvent(session, project.eventId);
    return (event, project);
  }

  static Future<void> ensureOrganizer(Session session, Event event) async {
    final user = userId(session);
    if (event.ownerId == user) return;
    final membership = await EventOrganizer.db.findFirstRow(
      session,
      where: (t) => t.eventId.equals(event.id!) & t.userId.equals(user),
    );
    if (membership == null) {
      throw GavelException(message: 'You are not an organizer of this event.');
    }
  }

  static Future<bool> isOwner(Session session, Event event) async =>
      event.ownerId == userId(session);
}
