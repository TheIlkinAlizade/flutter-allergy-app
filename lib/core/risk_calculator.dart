import 'package:allergy_app/core/risk_constants.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/ingredient_match.dart';
import 'package:allergy_app/data/models/severity.dart';

enum RiskLevel { safe, caution, danger }

class RiskContribution {
  const RiskContribution({required this.match, required this.severity});

  final IngredientMatch match;
  final Severity severity;

  bool get isTrace => match.isTrace;

  double get value {
    final base = severity.weight * match.confidence.weight;
    return isTrace ? base * RiskConstants.crossContaminationFactor : base;
  }
}

class RiskResult {
  const RiskResult({
    required this.score,
    required this.level,
    required this.contributions,
    required this.traceWarnings,
    required this.crossContaminationApplied,
  });

  final double score;
  final RiskLevel level;
  final List<RiskContribution> contributions;
  final List<RiskContribution> traceWarnings;
  final bool crossContaminationApplied;
}

class RiskCalculator {
  const RiskCalculator();

  RiskResult calculate({
    required List<IngredientMatch> matches,
    required Map<AllergenCategory, Severity> profile,
    bool hasTraceWarning = false,
    bool crossContaminationEnabled = false,
  }) {
    final strongest = <AllergenCategory, IngredientMatch>{};
    for (final match in matches) {
      if (!profile.containsKey(match.category)) continue;
      if (_isStronger(match, strongest[match.category])) {
        strongest[match.category] = match;
      }
    }

    final scored = <RiskContribution>[];
    final warnings = <RiskContribution>[];
    for (final entry in strongest.entries) {
      final contribution = RiskContribution(
        match: entry.value,
        severity: profile[entry.key]!,
      );
      if (contribution.isTrace && !crossContaminationEnabled) {
        warnings.add(contribution);
      } else {
        scored.add(contribution);
      }
    }

    final hasTraceSignal = hasTraceWarning || matches.any((m) => m.isTrace);
    final crossApplied = crossContaminationEnabled && hasTraceSignal;
    final multiplier =
        crossApplied ? 1 + RiskConstants.crossContaminationFactor : 1.0;

    final directSum = _sum(scored.where((c) => !c.isTrace));
    final traceSum = _sum(scored.where((c) => c.isTrace));
    final score = directSum * multiplier + traceSum;

    return RiskResult(
      score: score,
      level: _levelFor(score, scored),
      contributions: scored,
      traceWarnings: warnings,
      crossContaminationApplied: crossApplied,
    );
  }

  bool _isStronger(IngredientMatch candidate, IngredientMatch? current) {
    if (current == null) return true;
    if (candidate.isTrace != current.isTrace) return !candidate.isTrace;
    return candidate.confidence.weight > current.confidence.weight;
  }

  double _sum(Iterable<RiskContribution> contributions) {
    return contributions.fold<double>(0, (sum, c) => sum + c.value);
  }

  RiskLevel _levelFor(double score, List<RiskContribution> scored) {
    if (scored.isEmpty) return RiskLevel.safe;
    final hasAnaphylaxis =
        scored.any((c) => c.severity == Severity.anaphylaxis);
    if (hasAnaphylaxis || score >= RiskConstants.dangerThreshold) {
      return RiskLevel.danger;
    }
    return RiskLevel.caution;
  }
}