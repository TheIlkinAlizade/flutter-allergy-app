import 'package:allergy_app/core/risk_constants.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/ingredient_match.dart';
import 'package:allergy_app/data/models/severity.dart';

enum RiskLevel { safe, caution, danger }

class RiskContribution {
  const RiskContribution({required this.match, required this.severity});

  final IngredientMatch match;
  final Severity severity;

  double get value => severity.weight * match.confidence.weight;
}

class RiskResult {
  const RiskResult({
    required this.score,
    required this.level,
    required this.contributions,
    required this.crossContaminationApplied,
  });

  final double score;
  final RiskLevel level;
  final List<RiskContribution> contributions;
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
      final current = strongest[match.category];
      if (current == null ||
          match.confidence.weight > current.confidence.weight) {
        strongest[match.category] = match;
      }
    }

    final contributions = [
      for (final entry in strongest.entries)
        RiskContribution(match: entry.value, severity: profile[entry.key]!),
    ];

    final base = contributions.fold<double>(0, (sum, c) => sum + c.value);
    final crossApplied = crossContaminationEnabled && hasTraceWarning;
    final score = crossApplied
        ? base * (1 + RiskConstants.crossContaminationFactor)
        : base;

    return RiskResult(
      score: score,
      level: _levelFor(score, contributions),
      contributions: contributions,
      crossContaminationApplied: crossApplied,
    );
  }

  RiskLevel _levelFor(double score, List<RiskContribution> contributions) {
    if (contributions.isEmpty) return RiskLevel.safe;
    final hasAnaphylaxis =
        contributions.any((c) => c.severity == Severity.anaphylaxis);
    if (hasAnaphylaxis || score >= RiskConstants.dangerThreshold) {
      return RiskLevel.danger;
    }
    return RiskLevel.caution;
  }
}