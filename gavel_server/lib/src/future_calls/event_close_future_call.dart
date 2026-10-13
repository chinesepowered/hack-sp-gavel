import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/event_service.dart';

/// Closes judging at the time the organizer scheduled. Persisted in the
/// database, so it fires even if the server restarts in between.
class EventCloseFutureCall extends FutureCall {
  static String identifier(int eventId) => 'gavel-close-$eventId';

  Future<void> closeJudging(Session session, int eventId) async {
    final event = await Event.db.findById(session, eventId);
    if (event == null || event.status == EventStatus.closed) return;
    final closesAt = event.closesAt;
    // Ignore runs made stale by a later reschedule.
    if (closesAt == null ||
        closesAt.isAfter(
          DateTime.now().toUtc().add(const Duration(seconds: 5)),
        )) {
      return;
    }
    await EventService.setStatus(
      session,
      event,
      EventStatus.closed,
      reason: 'Judging closed automatically at the scheduled time',
    );
  }
}
