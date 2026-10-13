import 'dart:math' as math;

/// A pairwise comparison: [winner] was preferred over [loser] by [judge].
typedef Comparison = ({int judge, int winner, int loser});

/// Plain Bradley–Terry strengths fitted with Hunter's MM algorithm.
///
/// Each item gets one virtual win and one virtual loss against an average
/// opponent, which keeps strengths finite for items that never won (or never
/// lost) and gently shrinks sparse estimates toward the middle.
Map<int, double> fitBradleyTerry(
  Iterable<int> items,
  Iterable<Comparison> comparisons, {
  int iterations = 60,
}) {
  final ids = items.toList();
  final strength = {for (final id in ids) id: 1.0};
  final wins = {for (final id in ids) id: 1.0}; // virtual win
  final pairs = <int, Map<int, int>>{for (final id in ids) id: {}};
  for (final c in comparisons) {
    if (!strength.containsKey(c.winner) || !strength.containsKey(c.loser)) {
      continue;
    }
    wins[c.winner] = wins[c.winner]! + 1;
    pairs[c.winner]![c.loser] = (pairs[c.winner]![c.loser] ?? 0) + 1;
    pairs[c.loser]![c.winner] = (pairs[c.loser]![c.winner] ?? 0) + 1;
  }

  for (var it = 0; it < iterations; it++) {
    final next = <int, double>{};
    for (final i in ids) {
      // Two virtual games against an opponent of strength 1.
      var denominator = 2 / (strength[i]! + 1);
      pairs[i]!.forEach((j, n) {
        denominator += n / (strength[i]! + strength[j]!);
      });
      next[i] = wins[i]! / denominator;
    }
    // Normalize to a geometric mean of 1.
    var logSum = 0.0;
    for (final v in next.values) {
      logSum += math.log(v);
    }
    final scale = math.exp(-logSum / next.length);
    for (final i in ids) {
      strength[i] = next[i]! * scale;
    }
  }
  return strength;
}

/// For every judge: the fraction of their votes that agree with a ranking
/// fitted on everyone else's votes. Leaving the judge out matters: each vote
/// pulls the two projects it compares, so a judge always looks consistent
/// with a consensus they helped shape.
Map<int, double> leaveOneOutAgreement(
  Iterable<int> items,
  List<Comparison> comparisons,
) {
  final itemList = items.toList();
  final judges = comparisons.map((c) => c.judge).toSet();
  final result = <int, double>{};
  for (final judge in judges) {
    final own = comparisons.where((c) => c.judge == judge).toList();
    final others = comparisons.where((c) => c.judge != judge);
    final strength = fitBradleyTerry(itemList, others);
    var agree = 0.0;
    for (final c in own) {
      final w = strength[c.winner] ?? 1;
      final l = strength[c.loser] ?? 1;
      if ((w - l).abs() < 1e-9) {
        agree += 0.5;
      } else if (w > l) {
        agree += 1;
      }
    }
    result[judge] = own.isEmpty ? 1 : agree / own.length;
  }
  return result;
}
