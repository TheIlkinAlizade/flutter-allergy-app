import 'dart:convert';
import 'dart:io';

import 'package:allergy_app/core/allergen_dictionary.dart';
import 'package:allergy_app/core/allergen_matcher.dart';
import 'package:allergy_app/core/risk_calculator.dart';
import 'package:allergy_app/core/scan_analyzer.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/scan_extraction.dart';
import 'package:allergy_app/data/models/severity.dart';
import 'package:allergy_app/data/models/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';

AllergenDictionary loadDictionary() {
  final raw = File('assets/data/allergen_dictionary.json').readAsStringSync();
  return AllergenDictionary.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}

void main() {
  final analyzer = ScanAnalyzer(matcher: AllergenMatcher(loadDictionary()));

  test('scores the real Azerbaijani label end to end', () {
    const extraction = ScanExtraction(
      ingredients: [
        'Şəkər',
        'palma yağı',
        'fındıq (13%)',
        'yağsız süd tozu',
        'kakao',
        'soya lesitini (E322)',
        'vanilin',
      ],
      traces: ['Araxid', 'qluten', 'yumurta', 'PEANUTS', 'GLUTEN'],
      detectedLanguage: 'az',
    );
    final profile = const UserProfile()
        .withAllergen(AllergenCategory.peanut, Severity.anaphylaxis)
        .withAllergen(AllergenCategory.treeNut, Severity.moderate)
        .withAllergen(AllergenCategory.milk, Severity.moderate)
        .withAllergen(AllergenCategory.gluten, Severity.mild)
        .withAllergen(AllergenCategory.soy, Severity.mild);

    final report = analyzer.analyze(extraction, profile);

    expect(report.risk.score, closeTo(9.5, 1e-9));
    expect(report.risk.level, RiskLevel.danger);
    expect(report.risk.contributions, hasLength(5));
    expect(report.otherAllergens, [AllergenCategory.egg]);
  });

  test('a trace-only anaphylaxis allergen depends on the toggle', () {
    const extraction = ScanExtraction(
      ingredients: ['sugar', 'cocoa'],
      traces: ['Araxid'],
    );
    final base = const UserProfile()
        .withAllergen(AllergenCategory.peanut, Severity.anaphylaxis);

    final counted =
        analyzer.analyze(extraction, base.withCrossContamination(true));
    expect(counted.risk.level, RiskLevel.danger);
    expect(counted.risk.score, closeTo(1.5, 1e-9));

    final ignored =
        analyzer.analyze(extraction, base.withCrossContamination(false));
    expect(ignored.risk.level, RiskLevel.safe);
    expect(ignored.risk.traceWarnings, hasLength(1));
  });
}