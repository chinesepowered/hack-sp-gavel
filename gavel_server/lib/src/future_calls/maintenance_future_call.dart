import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Recurring housekeeping (scheduled with `callRecurring` in server.dart).
class MaintenanceFutureCall extends FutureCall {
  static const identifier = 'gavel-maintenance';
  static const demoLifetime = Duration(hours: 24);

  Future<void> sweep(Session session) async {
    final cutoff = DateTime.now().toUtc().subtract(demoLifetime);
    final expired = await Event.db.deleteWhere(
      session,
      where: (t) => t.isDemo.equals(true) & (t.createdAt < cutoff),
    );
    if (expired.isNotEmpty) {
      session.log('Maintenance: deleted ${expired.length} expired demo events');
    }
  }
}
