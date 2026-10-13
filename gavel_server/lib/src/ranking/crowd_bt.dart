import 'dart:math' as math;

/// Crowd-BT: online Bayesian pairwise ranking that also learns how reliable
/// each judge is.
///
/// Every project has a Gaussian posterior over its latent quality
/// (`mu`, `sigmaSq`). Every judge has a Beta(`alpha`, `beta`) posterior over
/// the probability that they report the "true" ordering of a pair. After each
/// comparison both posteriors are updated with moment matching, so a judge
/// who keeps disagreeing with the consensus automatically counts for less.
///
/// Based on Chen, Bennett, Collins-Thompson & Horvitz, "Pairwise Ranking
/// Aggregation in a Crowdsourced Setting" (WSDM 2013), the model behind the
/// classic hackathon expo judging approach. This is an independent Dart
/// implementation.
class CrowdBT {
  CrowdBT._();

  /// Weight of the judge-reliability term in the information gain.
  static const double gamma = 0.1;

  /// Lower bound that keeps variances strictly positive.
  static const double kappa = 0.0001;

  static const double muPrior = 0.0;
  static const double sigmaSqPrior = 1.0;

  /// A new judge starts out trusted: E[reliability] = 5 / 6 ≈ 0.83. A weaker
  /// prior than 10:1 lets the model notice an unreliable judge within a
  /// dozen votes without hurting ranking accuracy (see test/unit).
  static const double alphaPrior = 5.0;
  static const double betaPrior = 1.0;

  /// Probability of picking a random candidate instead of the most
  /// informative one (keeps coverage healthy).
  static const double epsilon = 0.25;

  /// Applies one comparison where the judge preferred the winner.
  static CrowdBTUpdate update({
    required double alpha,
    required double beta,
    required double muWinner,
    required double sigmaSqWinner,
    required double muLoser,
    required double sigmaSqLoser,
  }) {
    final annotator = _updatedAnnotator(
      alpha,
      beta,
      muWinner,
      sigmaSqWinner,
      muLoser,
      sigmaSqLoser,
    );
    final mus = _updatedMus(
      alpha,
      beta,
      muWinner,
      sigmaSqWinner,
      muLoser,
      sigmaSqLoser,
    );
    final sigmaSqs = _updatedSigmaSqs(
      alpha,
      beta,
      muWinner,
      sigmaSqWinner,
      muLoser,
      sigmaSqLoser,
    );
    return CrowdBTUpdate(
      alpha: annotator.alpha,
      beta: annotator.beta,
      muWinner: mus.$1,
      sigmaSqWinner: sigmaSqs.$1,
      muLoser: mus.$2,
      sigmaSqLoser: sigmaSqs.$2,
      probability: annotator.c,
    );
  }

  /// Expected information gain (KL divergence between posterior and prior,
  /// averaged over both possible outcomes) of asking a judge to compare a
  /// project with posterior (`muA`, `sigmaSqA`) to one with (`muB`,
  /// `sigmaSqB`).
  static double expectedInformationGain({
    required double alpha,
    required double beta,
    required double muA,
    required double sigmaSqA,
    required double muB,
    required double sigmaSqB,
  }) {
    // Outcome 1: the judge prefers A.
    final ann1 = _updatedAnnotator(alpha, beta, muA, sigmaSqA, muB, sigmaSqB);
    final mus1 = _updatedMus(alpha, beta, muA, sigmaSqA, muB, sigmaSqB);
    final sig1 = _updatedSigmaSqs(alpha, beta, muA, sigmaSqA, muB, sigmaSqB);
    final probAAbove = ann1.c;

    // Outcome 2: the judge prefers B.
    final ann2 = _updatedAnnotator(alpha, beta, muB, sigmaSqB, muA, sigmaSqA);
    final mus2 = _updatedMus(alpha, beta, muB, sigmaSqB, muA, sigmaSqA);
    final sig2 = _updatedSigmaSqs(alpha, beta, muB, sigmaSqB, muA, sigmaSqA);

    final gainIfA =
        divergenceGaussian(mus1.$1, sig1.$1, muA, sigmaSqA) +
        divergenceGaussian(mus1.$2, sig1.$2, muB, sigmaSqB) +
        gamma * divergenceBeta(ann1.alpha, ann1.beta, alpha, beta);
    final gainIfB =
        divergenceGaussian(mus2.$2, sig2.$2, muA, sigmaSqA) +
        divergenceGaussian(mus2.$1, sig2.$1, muB, sigmaSqB) +
        gamma * divergenceBeta(ann2.alpha, ann2.beta, alpha, beta);

    return probAAbove * gainIfA + (1 - probAAbove) * gainIfB;
  }

  /// KL(N(mu1, s1) || N(mu2, s2)).
  static double divergenceGaussian(
    double mu1,
    double sigmaSq1,
    double mu2,
    double sigmaSq2,
  ) {
    final ratio = sigmaSq1 / sigmaSq2;
    return (mu1 - mu2) * (mu1 - mu2) / (2 * sigmaSq2) +
        (ratio - 1 - math.log(ratio)) / 2;
  }

  /// KL(Beta(a1, b1) || Beta(a2, b2)).
  static double divergenceBeta(
    double alpha1,
    double beta1,
    double alpha2,
    double beta2,
  ) {
    return logBeta(alpha2, beta2) -
        logBeta(alpha1, beta1) +
        (alpha1 - alpha2) * digamma(alpha1) +
        (beta1 - beta2) * digamma(beta1) +
        (alpha2 - alpha1 + beta2 - beta1) * digamma(alpha1 + beta1);
  }

  /// Expected judge reliability, E[eta] for eta ~ Beta(alpha, beta).
  static double reliability(double alpha, double beta) =>
      alpha / (alpha + beta);

  static (double, double) _updatedMus(
    double alpha,
    double beta,
    double muWinner,
    double sigmaSqWinner,
    double muLoser,
    double sigmaSqLoser,
  ) {
    final ew = math.exp(muWinner);
    final el = math.exp(muLoser);
    final mult = (alpha * ew) / (alpha * ew + beta * el) - ew / (ew + el);
    return (muWinner + sigmaSqWinner * mult, muLoser - sigmaSqLoser * mult);
  }

  static (double, double) _updatedSigmaSqs(
    double alpha,
    double beta,
    double muWinner,
    double sigmaSqWinner,
    double muLoser,
    double sigmaSqLoser,
  ) {
    final ew = math.exp(muWinner);
    final el = math.exp(muLoser);
    final weighted = alpha * ew + beta * el;
    final plain = ew + el;
    final mult =
        (alpha * ew * beta * el) / (weighted * weighted) -
        (ew * el) / (plain * plain);
    return (
      sigmaSqWinner * math.max(1 + sigmaSqWinner * mult, kappa),
      sigmaSqLoser * math.max(1 + sigmaSqLoser * mult, kappa),
    );
  }

  static ({double alpha, double beta, double c}) _updatedAnnotator(
    double alpha,
    double beta,
    double muWinner,
    double sigmaSqWinner,
    double muLoser,
    double sigmaSqLoser,
  ) {
    final ew = math.exp(muWinner);
    final el = math.exp(muLoser);
    final sum = ew + el;
    // Second-order approximation of E[P(winner > loser)] under the item
    // posteriors.
    final c1 =
        ew / sum +
        0.5 *
            (sigmaSqWinner + sigmaSqLoser) *
            (ew * el * (el - ew)) /
            (sum * sum * sum);
    final c2 = 1 - c1;
    final c = (c1 * alpha + c2 * beta) / (alpha + beta);

    final ab = alpha + beta;
    final expt =
        (c1 * (alpha + 1) * alpha + c2 * alpha * beta) / (c * (ab + 1) * ab);
    final exptSq =
        (c1 * (alpha + 2) * (alpha + 1) * alpha +
            c2 * (alpha + 1) * alpha * beta) /
        (c * (ab + 2) * (ab + 1) * ab);
    final variance = exptSq - expt * expt;

    // Moment matching back onto a Beta distribution.
    final newAlpha = (expt - exptSq) * expt / variance;
    final newBeta = (expt - exptSq) * (1 - expt) / variance;
    if (!newAlpha.isFinite ||
        !newBeta.isFinite ||
        newAlpha <= 0 ||
        newBeta <= 0) {
      return (alpha: alpha, beta: beta, c: c);
    }
    return (alpha: newAlpha, beta: newBeta, c: c);
  }
}

/// Result of [CrowdBT.update].
class CrowdBTUpdate {
  final double alpha;
  final double beta;
  final double muWinner;
  final double sigmaSqWinner;
  final double muLoser;
  final double sigmaSqLoser;

  /// Probability the model assigned to the observed outcome before updating.
  final double probability;

  const CrowdBTUpdate({
    required this.alpha,
    required this.beta,
    required this.muWinner,
    required this.sigmaSqWinner,
    required this.muLoser,
    required this.sigmaSqLoser,
    required this.probability,
  });
}

const List<double> _lanczos = [
  0.99999999999980993,
  676.5203681218851,
  -1259.1392167224028,
  771.32342877765313,
  -176.61502916214059,
  12.507343278686905,
  -0.13857109526572012,
  9.9843695780195716e-6,
  1.5056327351493116e-7,
];

/// Natural log of the gamma function (Lanczos approximation, x > 0).
double logGamma(double x) {
  if (x < 0.5) {
    // Reflection formula.
    return math.log(math.pi / math.sin(math.pi * x).abs()) - logGamma(1 - x);
  }
  final z = x - 1;
  var a = _lanczos[0];
  final t = z + 7.5;
  for (var i = 1; i < _lanczos.length; i++) {
    a += _lanczos[i] / (z + i);
  }
  return 0.5 * math.log(2 * math.pi) +
      (z + 0.5) * math.log(t) -
      t +
      math.log(a);
}

/// Natural log of the beta function.
double logBeta(double a, double b) =>
    logGamma(a) + logGamma(b) - logGamma(a + b);

/// Digamma function (recurrence + asymptotic expansion, x > 0).
double digamma(double x) {
  var result = 0.0;
  var v = x;
  while (v < 6) {
    result -= 1 / v;
    v += 1;
  }
  final f = 1 / (v * v);
  return result +
      math.log(v) -
      0.5 / v -
      f * (1 / 12 - f * (1 / 120 - f * (1 / 252 - f * (1 / 240 - f / 132))));
}
