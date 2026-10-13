import 'dart:math' as math;

/// A project's posterior, as seen by the podium estimator.
typedef PosteriorItem = ({int id, double mu, double sigmaSq});

/// How settled the top of the leaderboard is.
class PodiumEstimate {
  /// Probability that each project belongs in the true top [k].
  final Map<int, double> podiumProbability;

  /// Probability that the current top [k] (by posterior mean) is exactly the
  /// true top [k], ignoring order.
  final double certainty;

  const PodiumEstimate(this.podiumProbability, this.certainty);
}

/// Monte Carlo over the Crowd-BT posteriors: draw a plausible "true" quality
/// for every project, see who lands on the podium, repeat.
///
/// Gives organizers an honest answer to "can we stop judging yet?".
PodiumEstimate estimatePodium(
  List<PosteriorItem> items, {
  int k = 3,
  int samples = 2000,
  int seed = 7,
}) {
  if (items.isEmpty) return const PodiumEstimate({}, 0);
  final podiumSize = math.min(k, items.length);
  final random = math.Random(seed);

  final byMean = [...items]..sort((a, b) => b.mu.compareTo(a.mu));
  final currentPodium = byMean.take(podiumSize).map((e) => e.id).toSet();

  final counts = List<int>.filled(items.length, 0);
  final sigmas = [for (final item in items) math.sqrt(item.sigmaSq)];
  final draws = List<double>.filled(items.length, 0);
  final top = List<int>.filled(podiumSize, -1);
  var exactMatches = 0;

  for (var s = 0; s < samples; s++) {
    for (var i = 0; i < items.length; i++) {
      draws[i] = items[i].mu + sigmas[i] * _gaussian(random);
    }
    // Partial selection of the top-k indices (k is tiny).
    for (var t = 0; t < podiumSize; t++) {
      var best = -1;
      for (var i = 0; i < items.length; i++) {
        if (_contains(top, t, i)) continue;
        if (best == -1 || draws[i] > draws[best]) best = i;
      }
      top[t] = best;
    }
    var matches = true;
    for (var t = 0; t < podiumSize; t++) {
      counts[top[t]]++;
      if (!currentPodium.contains(items[top[t]].id)) matches = false;
    }
    if (matches) exactMatches++;
  }

  return PodiumEstimate(
    {
      for (var i = 0; i < items.length; i++) items[i].id: counts[i] / samples,
    },
    exactMatches / samples,
  );
}

bool _contains(List<int> list, int length, int value) {
  for (var i = 0; i < length; i++) {
    if (list[i] == value) return true;
  }
  return false;
}

/// Standard normal sample (Box-Muller).
double _gaussian(math.Random random) {
  final u1 = 1.0 - random.nextDouble();
  final u2 = random.nextDouble();
  return math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2);
}
