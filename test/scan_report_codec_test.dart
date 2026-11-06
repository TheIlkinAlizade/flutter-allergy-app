import 'dart:convert';

import 'package:allergy_app/core/risk_calculator.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/ingredient_match.dart';
import 'package:allergy_app/data/models/scan_extraction.dart';
import 'package:allergy_app/data/models/scan_report.dart';
import 'package:allergy_app/data/models/severity.dart';
import 'package:allergy_app/data/scan_report_codec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final report = ScanReport(
    extraction: const ScanExtraction(
      ingredients: ['milk powder'],
      traces: ['peanuts'],
      detectedLanguage: 'en',
    ),
    risk: RiskResult(
      score: 2.5,
      level: RiskLevel.danger,
      contributions: const [
        RiskContribution(
          match: IngredientMatch(
            ingredient: 'milk powder',
            category: AllergenCategory.milk,
            confidence: MatchConfidence.direct,
          ),
          severity: Severity.moderate,
        ),
      ],
      traceWarnings: const [
        RiskContribution(
          match: IngredientMatch(
            ingredient: 'peanuts',
            category: AllergenCategory.peanut,
            confidence: MatchConfidence.direct,
            isTrace: true,
          ),
          severity: Severity.anaphylaxis,
        ),
      ],
      crossContaminationApplied: true,
    ),
    otherAllergens: const [AllergenCategory.egg],
    scannedAt: DateTime.utc(2026, 11, 6, 12, 30),
  );

  test('a report survives storage unchanged', () {
    final stored = jsonDecode(jsonEncode(scanReportToJson(report)));
    final restored = scanReportFromJson(stored as Map<String, dynamic>);

    expect(restored, isNotNull);
    expect(restored!.scannedAt, report.scannedAt);
    expect(restored.risk.score, closeTo(2.5, 1e-9));
    expect(restored.risk.level, RiskLevel.danger);
    expect(restored.risk.crossContaminationApplied, isTrue);
    expect(restored.risk.contributions.single.value, closeTo(2.0, 1e-9));
    expect(restored.risk.traceWarnings.single.match.isTrace, isTrue);
    expect(
      restored.risk.traceWarnings.single.severity,
      Severity.anaphylaxis,
    );
    expect(restored.extraction.traces, ['peanuts']);
    expect(restored.otherAllergens, [AllergenCategory.egg]);
  });

  test('corrupt entries are rejected instead of misread', () {
    expect(scanReportFromJson({'scannedAt': 'not a date'}), isNull);

    final stored =
        jsonDecode(jsonEncode(scanReportToJson(report))) as Map<String, dynamic>;
    final risk = stored['risk'] as Map<String, dynamic>;
    final contributions = risk['contributions'] as List<dynamic>;
    (contributions.first as Map<String, dynamic>)['severity'] = 9;

    expect(scanReportFromJson(stored), isNull);
  });
}