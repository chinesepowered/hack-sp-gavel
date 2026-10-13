import 'dart:async';
import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gavel_client/gavel_client.dart';

import '../client.dart';
import '../theme.dart';
import 'common.dart';

const _seriesColors = [
  G.brass,
  G.mint,
  G.sky,
  Color(0xFFFF8FA3),
  Color(0xFFB39DFF),
  Color(0xFFFFC48C),
];

/// How the ranking converges, and whether every table gets enough eyes.
class InsightsView extends StatefulWidget {
  const InsightsView({
    super.key,
    required this.eventId,
    required this.snapshot,
  });

  final int eventId;
  final LiveSnapshot snapshot;

  @override
  State<InsightsView> createState() => _InsightsViewState();
}

class _InsightsViewState extends State<InsightsView> {
  List<ConvergenceSeries> _series = [];
  int _loadedAtVotes = -1;
  Timer? _throttle;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant InsightsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.snapshot.totalVotes != _loadedAtVotes && _throttle == null) {
      _throttle = Timer(const Duration(milliseconds: 1500), () {
        _throttle = null;
        _load();
      });
    }
  }

  @override
  void dispose() {
    _throttle?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    final votes = widget.snapshot.totalVotes;
    try {
      final series = await client.organizer.convergence(widget.eventId);
      if (mounted) {
        setState(() {
          _series = series;
          _loadedAtVotes = votes;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final snap = widget.snapshot;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CONVERGENCE', style: G.eyebrow()),
              const SizedBox(height: 6),
              Text(
                'Estimated quality of the current top 6, vote by vote',
                style: G.sans(color: G.muted, size: 13.5),
              ),
              const SizedBox(height: 18),
              SizedBox(height: 260, child: _chart()),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 6,
                children: [
                  for (var i = 0; i < _series.length; i++)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: _seriesColors[i % _seriesColors.length],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(_series[i].name, style: G.sans(size: 12.5)),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('COVERAGE', style: G.eyebrow()),
              const SizedBox(height: 6),
              Text(
                'Views per project. Gavel makes sure nobody is left unseen '
                'before it optimizes for information gain.',
                style: G.sans(color: G.muted, size: 13.5),
              ),
              const SizedBox(height: 18),
              SizedBox(height: 120, child: _coverage(snap)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chart() {
    if (_series.isEmpty || _series.every((s) => s.voteNumbers.length < 2)) {
      return Center(
        child: Text(
          'The chart fills in as votes arrive.',
          style: G.sans(color: G.muted),
        ),
      );
    }
    final maxX = _series
        .map((s) => s.voteNumbers.last)
        .reduce(math.max)
        .toDouble();
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: math.max(maxX, 1),
        lineTouchData: const LineTouchData(enabled: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) =>
              const FlLine(color: G.line, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 34,
              getTitlesWidget: (value, meta) => Text(
                value.toStringAsFixed(1),
                style: G.mono(size: 10.5, color: G.faint),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: G.mono(size: 10.5, color: G.faint),
              ),
            ),
          ),
        ),
        lineBarsData: [
          for (var i = 0; i < _series.length; i++)
            LineChartBarData(
              spots: [
                for (var k = 0; k < _series[i].voteNumbers.length; k++)
                  FlSpot(
                    _series[i].voteNumbers[k].toDouble(),
                    _series[i].mus[k],
                  ),
              ],
              isCurved: true,
              curveSmoothness: 0.2,
              color: _seriesColors[i % _seriesColors.length],
              barWidth: 2.4,
              dotData: const FlDotData(show: false),
            ),
        ],
      ),
      duration: const Duration(milliseconds: 400),
    );
  }

  Widget _coverage(LiveSnapshot snap) {
    final entries = [...snap.leaderboard.where((e) => e.active)]
      ..sort((a, b) => a.projectId.compareTo(b.projectId));
    if (entries.isEmpty) return const SizedBox();
    final maxSeen = math.max(
      entries.map((e) => e.timesSeen).reduce(math.max),
      1,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final e in entries)
          Expanded(
            child: Tooltip(
              message: '${e.name}: ${e.timesSeen} views',
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(end: e.timesSeen / maxSeen),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, v, _) => FractionallySizedBox(
                    heightFactor: math.max(v, 0.04),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: e.timesSeen >= 2
                            ? G.brass
                            : G.signal.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
