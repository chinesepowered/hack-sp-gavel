import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gavel_client/gavel_client.dart';

import '../theme.dart';

/// Live leaderboard: rows glide to their new rank as votes stream in.
class LeaderboardView extends StatelessWidget {
  const LeaderboardView({
    super.key,
    required this.entries,
    this.onTap,
    this.rowHeight = 66,
    this.limit,
    this.big = false,
  });

  final List<LeaderboardEntry> entries;
  final ValueChanged<LeaderboardEntry>? onTap;
  final double rowHeight;
  final int? limit;
  final bool big;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          'No projects yet. Add some in the Projects tab.',
          style: G.sans(color: G.muted),
        ),
      );
    }
    final visible = limit == null ? entries : entries.take(limit!).toList();
    final visibleIds = visible.map((e) => e.projectId).toSet();
    // Stable order of widgets (by id) so AnimatedPositioned can animate.
    final byId = [...entries]
      ..sort((a, b) => a.projectId.compareTo(b.projectId));

    final maxMu = entries.map((e) => e.mu + e.sigma).reduce(math.max);
    final minMu = entries.map((e) => e.mu - e.sigma).reduce(math.min);
    final span = math.max(maxMu - minMu, 0.5);

    return SizedBox(
      height: visible.length * rowHeight,
      child: Stack(
        children: [
          for (final entry in byId)
            AnimatedPositioned(
              key: ValueKey(entry.projectId),
              duration: const Duration(milliseconds: 650),
              curve: Curves.easeInOutCubic,
              top: (entry.rank - 1) * rowHeight,
              left: 0,
              right: 0,
              height: rowHeight,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: visibleIds.contains(entry.projectId) ? 1 : 0,
                child: _Row(
                  entry: entry,
                  minMu: minMu,
                  span: span,
                  big: big,
                  onTap: onTap == null ? null : () => onTap!(entry),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.entry,
    required this.minMu,
    required this.span,
    required this.big,
    this.onTap,
  });

  final LeaderboardEntry entry;
  final double minMu;
  final double span;
  final bool big;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final podium = entry.rank <= 3 && entry.active;
    final medal = switch (entry.rank) {
      1 => G.brass,
      2 => const Color(0xFFC9CED8),
      3 => const Color(0xFFC98A52),
      _ => G.ink3,
    };
    return Opacity(
      opacity: entry.active ? 1 : 0.45,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: podium ? G.ink3 : G.ink2,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: podium ? medal.withValues(alpha: 0.35) : G.line,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: big ? 46 : 38,
                height: big ? 46 : 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: podium ? medal : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${entry.rank}',
                  style: G.mono(
                    size: big ? 20 : 16,
                    weight: FontWeight.w700,
                    color: podium ? G.ink : G.muted,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            entry.name,
                            overflow: TextOverflow.ellipsis,
                            style: G.serif(size: big ? 24 : 19),
                          ),
                        ),
                        if (entry.prioritized) ...[
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: G.brass,
                          ),
                        ],
                        if (!entry.active) ...[
                          const SizedBox(width: 8),
                          Text('PAUSED', style: G.eyebrow(color: G.signal)),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      [
                        entry.location,
                        if (entry.team != null) entry.team!,
                      ].join(' · '),
                      overflow: TextOverflow.ellipsis,
                      style: G.sans(size: 12.5, color: G.muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 4,
                child: _ScoreBar(entry: entry, minMu: minMu, span: span),
              ),
              const SizedBox(width: 14),
              SizedBox(
                width: big ? 92 : 78,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${(entry.podiumProbability * 100).round()}%',
                      style: G.mono(
                        size: big ? 18 : 15,
                        weight: FontWeight.w700,
                        color: entry.podiumProbability > 0.5 ? G.mint : G.paper,
                      ),
                    ),
                    Text('podium', style: G.sans(size: 11, color: G.faint)),
                  ],
                ),
              ),
              if (!big) ...[
                const SizedBox(width: 10),
                SizedBox(
                  width: 54,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${entry.timesSeen}×',
                        style: G.mono(size: 14, color: G.paper),
                      ),
                      Text('seen', style: G.sans(size: 11, color: G.faint)),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Posterior mean with a ±1σ band, on a shared scale across the board.
class _ScoreBar extends StatelessWidget {
  const _ScoreBar({
    required this.entry,
    required this.minMu,
    required this.span,
  });

  final LeaderboardEntry entry;
  final double minMu;
  final double span;

  @override
  Widget build(BuildContext context) {
    double x(double v) => ((v - minMu) / span).clamp(0.0, 1.0);
    return TweenAnimationBuilder<double>(
      tween: Tween(end: entry.mu),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, mu, _) => LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final lo = x(mu - entry.sigma) * w;
          final hi = x(mu + entry.sigma) * w;
          final mid = x(mu) * w;
          return SizedBox(
            height: 18,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: G.ink3,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Positioned(
                  left: lo,
                  width: math.max(hi - lo, 2),
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: G.brass.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Positioned(
                  left: math.max(mid - 6, 0),
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: G.brass,
                      shape: BoxShape.circle,
                      border: Border.all(color: G.ink, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
