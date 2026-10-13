import 'package:serverpod/serverpod.dart';

import '../services/simulation_service.dart';

/// Drives demo simulations: each run lets due simulated judges act, then
/// reschedules itself until every simulated judge is done.
class SimulationFutureCall extends FutureCall {
  Future<void> tick(Session session, int eventId) =>
      SimulationService.tick(session, eventId);
}
