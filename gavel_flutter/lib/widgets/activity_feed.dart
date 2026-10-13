import 'package:flutter/material.dart';
import 'package:gavel_client/gavel_client.dart';

import '../theme.dart';

/// Live feed of what is happening on the expo floor.
class ActivityFeed extends StatelessWidget {
  const ActivityFeed({super.key, required this.items, required this.now});
  final List<ActivityItem> items;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Text('Nothing yet.', style: G.sans(color: G.muted));
    }
    return Column(
      children: [
        for (final item in items.take(18))
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Padding(
              key: ValueKey('${item.at.microsecondsSinceEpoch}${item.message}'),
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(_icon(item.kind), size: 16, color: _color(item.kind)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.message,
                      style: G.sans(size: 13, height: 1.35),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(_ago(item.at), style: G.mono(size: 11, color: G.faint)),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String _ago(DateTime at) {
    final d = now.difference(at);
    if (d.inSeconds < 5) return 'now';
    if (d.inMinutes < 1) return '${d.inSeconds}s';
    if (d.inHours < 1) return '${d.inMinutes}m';
    return '${d.inHours}h';
  }

  static IconData _icon(ActivityKind kind) => switch (kind) {
    ActivityKind.vote => Icons.compare_arrows_rounded,
    ActivityKind.skip => Icons.skip_next_rounded,
    ActivityKind.join => Icons.person_add_alt_rounded,
    ActivityKind.note => Icons.mic_rounded,
    ActivityKind.project => Icons.table_restaurant_rounded,
    ActivityKind.status => Icons.gavel_rounded,
    ActivityKind.simulation => Icons.smart_toy_outlined,
  };

  static Color _color(ActivityKind kind) => switch (kind) {
    ActivityKind.vote => G.brass,
    ActivityKind.skip => G.signal,
    ActivityKind.join => G.mint,
    ActivityKind.note => G.sky,
    ActivityKind.project => G.muted,
    ActivityKind.status => G.paper,
    ActivityKind.simulation => G.sky,
  };
}
