import 'package:allergy_app/core/allergen_matcher.dart';
import 'package:allergy_app/core/risk_calculator.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/scan_extraction.dart';
import 'package:allergy_app/data/models/scan_report.dart';
import 'package:allergy_app/data/models/user_profile.dart';

class ScanAnalyzer {
  const ScanAnalyzer({
    required this.matcher,
    this.calculator = const RiskCalculator(),
  });

  final AllergenMatcher matcher;
  final RiskCalculator calculator;

  ScanReport analyze(
    ScanExtraction extraction,
    UserProfile profile, {
    DateTime? scannedAt,
  }) {
    final matches = [
      ...matcher.match(extraction.ingredients),
      ...matcher.match(extraction.traces, isTrace: true),
    ];

    final risk = calculator.calculate(
      matches: matches,
      profile: profile.allergens,
      hasTraceWarning: extraction.traces.isNotEmpty,
      crossContaminationEnabled: profile.crossContamination,
    );

    final others = <AllergenCategory>{
      for (final match in matches)
        if (!profile.allergens.containsKey(match.category)) match.category,
    }.toList()
      ..sort((a, b) => a.index.compareTo(b.index));

    return ScanReport(
      extraction: extraction,
      risk: risk,
      otherAllergens: others,
      scannedAt: scannedAt ?? DateTime.now(),
    );
  }
}