import 'package:serverpod/serverpod.dart';

import '../../cache_busting.dart';
import '../../generated/protocol.dart';

/// The public landing page, rendered on the server with live numbers from
/// the database.
class LandingRoute extends WidgetRoute {
  LandingRoute() : super(cacheBustingConfig: cacheBustingConfig);

  @override
  Future<WebWidget> build(Session session, Request request) async {
    final stats = await session.caches.local.get<LandingStats>(
      'landing-stats',
      CacheMissHandler(
        () async => LandingStats(
          events: await Event.db.count(session),
          projects: await Project.db.count(session),
          votes: await Vote.db.count(session),
        ),
        lifetime: const Duration(seconds: 30),
      ),
    );
    return TemplateWidget(
      name: 'landing',
      values: {
        'events': stats?.events ?? 0,
        'projects': stats?.projects ?? 0,
        'votes': stats?.votes ?? 0,
        'year': DateTime.now().year,
      },
    );
  }
}
