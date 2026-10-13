import 'package:serverpod/serverpod.dart';

import '../future_calls/event_close_future_call.dart';
import '../generated/future_calls.dart';
import 'simulation_service.dart';

/// Thin wrapper around the generated, type-safe future call API.
class Scheduler {
  Scheduler._();

  static Future<void> scheduleClose(
    Session session,
    int eventId,
    DateTime at,
  ) async {
    await cancelClose(session, eventId);
    await session.serverpod.futureCalls
        .callAtTime(at, identifier: EventCloseFutureCall.identifier(eventId))
        .eventClose
        .closeJudging(eventId);
  }

  static Future<void> cancelClose(Session session, int eventId) =>
      session.serverpod.futureCalls.cancel(
        EventCloseFutureCall.identifier(eventId),
      );

  static Future<void> cancelSimulation(Session session, int eventId) =>
      session.serverpod.futureCalls.cancel(
        SimulationService.identifier(eventId),
      );
}
