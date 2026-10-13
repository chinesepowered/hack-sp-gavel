import 'dart:math' as math;

import 'package:gavel_server/src/ranking/crowd_bt.dart';
import 'package:gavel_server/src/ranking/podium.dart';
import 'package:test/test.dart';

void main() {
  group('Given the special functions', () {
    test('when evaluated at known points then they match reference values', () {
      expect(digamma(1), closeTo(-0.5772156649, 1e-9));
      expect(digamma(0.5), closeTo(-1.9635100260, 1e-9));
      expect(logGamma(5), closeTo(math.log(24), 1e-10));
      expect(logGamma(0.5), closeTo(math.log(math.sqrt(math.pi)), 1e-10));
      expect(logBeta(2, 3), closeTo(math.log(1 / 12), 1e-10));
    });
  });

  group('Given two fresh projects and a fresh judge', () {
    final update = CrowdBT.update(
      alpha: CrowdBT.alphaPrior,
      beta: CrowdBT.betaPrior,
      muWinner: 0,
      sigmaSqWinner: 1,
      muLoser: 0,
      sigmaSqLoser: 1,
    );

    test('when one wins then its mean rises and the loser\'s falls', () {
      expect(update.muWinner, greaterThan(0));
      expect(update.muLoser, lessThan(0));
      expect(update.muWinner, closeTo(-update.muLoser, 1e-12));
    });

    test('when one wins then both become more certain', () {
      expect(update.sigmaSqWinner, lessThan(1));
      expect(update.sigmaSqLoser, lessThan(1));
    });

    test(
      'when comparing them then the expected information gain is positive',
      () {
        final gain = CrowdBT.expectedInformationGain(
          alpha: CrowdBT.alphaPrior,
          beta: CrowdBT.betaPrior,
          muA: 0,
          sigmaSqA: 1,
          muB: 0,
          sigmaSqB: 1,
        );
        expect(gain, greaterThan(0));
      },
    );
  });

  group('Given a settled project pair', () {
    test('when choosing what to compare next then an uncertain project is '
        'more informative than a settled one', () {
      double gain(double mu, double sigmaSq) => CrowdBT.expectedInformationGain(
        alpha: CrowdBT.alphaPrior,
        beta: CrowdBT.betaPrior,
        muA: 0,
        sigmaSqA: 0.2,
        muB: mu,
        sigmaSqB: sigmaSq,
      );
      expect(gain(0.1, 1.0), greaterThan(gain(0.1, 0.05)));
    });
  });

  group('Given a simulated expo with one contrarian judge', () {
    final result = _simulate(seed: 3);

    test('when judging finishes then the ranking tracks the ground truth', () {
      expect(result.spearman, greaterThan(0.7));
    });

    test('when judging finishes then the contrarian is the least trusted', () {
      final contrarian = result.reliability.last;
      final honest = result.reliability.sublist(
        0,
        result.reliability.length - 1,
      );
      expect(contrarian, lessThan(honest.reduce(math.min)));
    });
  });

  group('Given podium estimates', () {
    test('when the top three are far ahead then certainty is high', () {
      final estimate = estimatePodium([
        (id: 1, mu: 3, sigmaSq: 0.01),
        (id: 2, mu: 2, sigmaSq: 0.01),
        (id: 3, mu: 1, sigmaSq: 0.01),
        for (var i = 4; i < 20; i++) (id: i, mu: -1, sigmaSq: 0.01),
      ]);
      expect(estimate.certainty, greaterThan(0.99));
      expect(estimate.podiumProbability[1], greaterThan(0.99));
    });

    test('when nothing is known yet then certainty is low', () {
      final estimate = estimatePodium([
        for (var i = 0; i < 20; i++) (id: i, mu: 0, sigmaSq: 1),
      ]);
      expect(estimate.certainty, lessThan(0.05));
    });
  });
}

/// A small expo: 24 projects, 9 honest judges and a contrarian, each judge
/// visits 14 projects chosen by expected information gain.
({double spearman, List<double> reliability}) _simulate({required int seed}) {
  final random = math.Random(seed);
  const n = 24;
  final truth = List.generate(n, (_) => random.nextDouble() * 4 - 2);
  final mu = List.filled(n, 0.0);
  final sigmaSq = List.filled(n, 1.0);
  final seen = List.filled(n, 0);
  final kinds = [
    ...List.filled(5, 'careful'),
    ...List.filled(4, 'noisy'),
    'contrarian',
  ];
  final alpha = List.filled(kinds.length, CrowdBT.alphaPrior);
  final beta = List.filled(kinds.length, CrowdBT.betaPrior);
  final previous = List<int?>.filled(kinds.length, null);
  final visited = List.generate(kinds.length, (_) => <int>{});

  for (var round = 0; round < 14; round++) {
    for (var j = 0; j < kinds.length; j++) {
      var candidates = [
        for (var i = 0; i < n; i++)
          if (!visited[j].contains(i)) i,
      ];
      final lessSeen = candidates.where((i) => seen[i] < 2).toList();
      if (lessSeen.isNotEmpty) candidates = lessSeen;
      candidates.shuffle(random);
      final prev = previous[j];
      final next = prev == null
          ? candidates.first
          : candidates.reduce((a, b) {
              double gain(int i) => CrowdBT.expectedInformationGain(
                alpha: alpha[j],
                beta: beta[j],
                muA: mu[prev],
                sigmaSqA: sigmaSq[prev],
                muB: mu[i],
                sigmaSqB: sigmaSq[i],
              );
              return gain(a) >= gain(b) ? a : b;
            });
      visited[j].add(next);
      seen[next]++;
      if (prev != null) {
        final diff = truth[next] - truth[prev];
        var pickNext = kinds[j] == 'contrarian'
            ? (random.nextDouble() < 0.9 ? diff < 0 : diff >= 0)
            : random.nextDouble() <
                  1 / (1 + math.exp(-diff * (kinds[j] == 'noisy' ? 1 : 3)));
        final w = pickNext ? next : prev;
        final l = pickNext ? prev : next;
        final u = CrowdBT.update(
          alpha: alpha[j],
          beta: beta[j],
          muWinner: mu[w],
          sigmaSqWinner: sigmaSq[w],
          muLoser: mu[l],
          sigmaSqLoser: sigmaSq[l],
        );
        alpha[j] = u.alpha;
        beta[j] = u.beta;
        mu[w] = u.muWinner;
        sigmaSq[w] = u.sigmaSqWinner;
        mu[l] = u.muLoser;
        sigmaSq[l] = u.sigmaSqLoser;
      }
      previous[j] = next;
    }
  }

  List<int> ranks(List<double> v) {
    final order = List.generate(n, (i) => i)
      ..sort((a, b) => v[b].compareTo(v[a]));
    final r = List.filled(n, 0);
    for (var k = 0; k < n; k++) {
      r[order[k]] = k;
    }
    return r;
  }

  final rt = ranks(truth);
  final rm = ranks(mu);
  var d2 = 0;
  for (var i = 0; i < n; i++) {
    d2 += (rt[i] - rm[i]) * (rt[i] - rm[i]);
  }
  return (
    spearman: 1 - 6 * d2 / (n * (n * n - 1)),
    reliability: [
      for (var j = 0; j < kinds.length; j++)
        CrowdBT.reliability(alpha[j], beta[j]),
    ],
  );
}
