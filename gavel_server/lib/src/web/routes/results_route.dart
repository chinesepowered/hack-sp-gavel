import 'package:serverpod/serverpod.dart';

import '../../cache_busting.dart';
import '../../endpoints/results_endpoint.dart';

/// Server-rendered public results page: `/results/<slug>`.
class ResultsRoute extends WidgetRoute {
  ResultsRoute() : super(cacheBustingConfig: cacheBustingConfig);

  @override
  Future<WebWidget?> build(Session session, Request request) async {
    final slug = request.pathParameters.raw[#slug];
    if (slug == null) return null;
    final results = await ResultsEndpoint.load(session, slug);
    if (results == null) return null;

    final entries = results.entries;
    final maxMu = entries.isEmpty ? 1.0 : entries.first.mu;
    final minMu = entries.isEmpty ? 0.0 : entries.last.mu;
    final span = (maxMu - minMu).abs() < 1e-9 ? 1.0 : maxMu - minMu;
    return TemplateWidget(
      name: 'results',
      values: {
        'eventName': results.eventName,
        'tagline': results.tagline ?? '',
        'hasTagline': results.tagline != null,
        'totalVotes': results.totalVotes,
        'judgeCount': results.judgeCount,
        'isClosed': results.status.name == 'closed',
        'entries': [
          for (final e in entries)
            {
              'rank': e.rank,
              'name': e.name,
              'team': e.team ?? '',
              'location': e.location,
              'podium': e.rank <= 3,
              'medal': switch (e.rank) {
                1 => 'gold',
                2 => 'silver',
                3 => 'bronze',
                _ => '',
              },
              'width': (8 + 92 * (e.mu - minMu) / span).toStringAsFixed(1),
              'score': e.mu.toStringAsFixed(2),
            },
        ],
      },
    );
  }
}
