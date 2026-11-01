import 'package:allergy_app/core/risk_calculator.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/ingredient_match.dart';
import 'package:allergy_app/data/models/severity.dart';
import 'package:flutter_test/flutter_test.dart';

IngredientMatch match(
  AllergenCategory category, {
  MatchConfidence confidence = MatchConfidence.direct,
  String ingredient = 'ingredient',
  bool isTrace = false,
}) {
  return IngredientMatch(
    ingredient: ingredient,
    category: category,
    confidence: confidence,
    isTrace: isTrace,
  );
}

void main() {
  const calculator = RiskCalculator();

  test('no matches gives a safe zero score', () {
    final result = calculator.calculate(
      matches: [],
      profile: {AllergenCategory.peanut: Severity.anaphylaxis},
    );
    expect(result.score, 0);
    expect(result.level, RiskLevel.safe);
  });

  test('allergens outside the profile are ignored', () {
    final result = calculator.calculate(
      matches: [match(AllergenCategory.gluten)],
      profile: {AllergenCategory.peanut: Severity.moderate},
    );
    expect(result.score, 0);
    expect(result.level, RiskLevel.safe);
    expect(result.contributions, isEmpty);
  });

  test('reproduces the reference example of 9.00', () {
    final result = calculator.calculate(
      matches: [
        match(AllergenCategory.peanut),
        match(AllergenCategory.treeNut),
        match(AllergenCategory.additives),
        match(AllergenCategory.gluten),
      ],
      profile: {
        AllergenCategory.peanut: Severity.anaphylaxis,
        AllergenCategory.treeNut: Severity.moderate,
        AllergenCategory.additives: Severity.mild,
      },
      hasTraceWarning: true,
      crossContaminationEnabled: true,
    );
    expect(result.score, closeTo(9.0, 1e-9));
    expect(result.level, RiskLevel.danger);
    expect(result.crossContaminationApplied, isTrue);
  });

  test('derived matches use the 0.7 confidence weight', () {
    final result = calculator.calculate(
      matches: [
        match(AllergenCategory.milk, confidence: MatchConfidence.derived),
      ],
      profile: {AllergenCategory.milk: Severity.moderate},
    );
    expect(result.score, closeTo(1.4, 1e-9));
    expect(result.level, RiskLevel.caution);
  });

  test('cross contamination is skipped when the toggle is off', () {
    final result = calculator.calculate(
      matches: [match(AllergenCategory.soy)],
      profile: {AllergenCategory.soy: Severity.moderate},
      hasTraceWarning: true,
      crossContaminationEnabled: false,
    );
    expect(result.score, closeTo(2.0, 1e-9));
    expect(result.crossContaminationApplied, isFalse);
  });

  test('cross contamination is skipped without a trace warning', () {
    final result = calculator.calculate(
      matches: [match(AllergenCategory.soy)],
      profile: {AllergenCategory.soy: Severity.moderate},
      crossContaminationEnabled: true,
    );
    expect(result.score, closeTo(2.0, 1e-9));
  });

  test('cross contamination can push a caution into danger', () {
    final result = calculator.calculate(
      matches: [match(AllergenCategory.soy)],
      profile: {AllergenCategory.soy: Severity.moderate},
      hasTraceWarning: true,
      crossContaminationEnabled: true,
    );
    expect(result.score, closeTo(3.0, 1e-9));
    expect(result.level, RiskLevel.danger);
  });

  test('the same category counts once using the strongest match', () {
    final result = calculator.calculate(
      matches: [
        match(AllergenCategory.milk, confidence: MatchConfidence.derived),
        match(AllergenCategory.milk),
      ],
      profile: {AllergenCategory.milk: Severity.mild},
    );
    expect(result.contributions, hasLength(1));
    expect(result.score, closeTo(1.0, 1e-9));
  });

  test('an anaphylaxis allergen is always danger, even when derived', () {
    final result = calculator.calculate(
      matches: [
        match(AllergenCategory.peanut, confidence: MatchConfidence.derived),
      ],
      profile: {AllergenCategory.peanut: Severity.anaphylaxis},
    );
    expect(result.score, closeTo(2.1, 1e-9));
    expect(result.level, RiskLevel.danger);
  });

  test('two moderate direct allergens reach the danger threshold', () {
    final result = calculator.calculate(
      matches: [
        match(AllergenCategory.milk),
        match(AllergenCategory.soy),
      ],
      profile: {
        AllergenCategory.milk: Severity.moderate,
        AllergenCategory.soy: Severity.moderate,
      },
    );
    expect(result.score, closeTo(4.0, 1e-9));
    expect(result.level, RiskLevel.danger);
  });
  test('a trace-only allergen is scored at half weight when enabled', () {
    final result = calculator.calculate(
      matches: [match(AllergenCategory.gluten, isTrace: true)],
      profile: {AllergenCategory.gluten: Severity.mild},
      crossContaminationEnabled: true,
    );
    expect(result.score, closeTo(0.5, 1e-9));
    expect(result.level, RiskLevel.caution);
    expect(result.traceWarnings, isEmpty);
  });

  test('a trace-only allergen is reported but not scored when disabled', () {
    final result = calculator.calculate(
      matches: [match(AllergenCategory.gluten, isTrace: true)],
      profile: {AllergenCategory.gluten: Severity.mild},
      crossContaminationEnabled: false,
    );
    expect(result.score, 0);
    expect(result.level, RiskLevel.safe);
    expect(result.traceWarnings, hasLength(1));
  });

  test('a trace-only anaphylaxis allergen is danger when enabled', () {
    final result = calculator.calculate(
      matches: [match(AllergenCategory.peanut, isTrace: true)],
      profile: {AllergenCategory.peanut: Severity.anaphylaxis},
      crossContaminationEnabled: true,
    );
    expect(result.score, closeTo(1.5, 1e-9));
    expect(result.level, RiskLevel.danger);
  });

  test('a direct match wins over a trace match of the same category', () {
    final result = calculator.calculate(
      matches: [
        match(AllergenCategory.milk, isTrace: true),
        match(AllergenCategory.milk),
      ],
      profile: {AllergenCategory.milk: Severity.mild},
      crossContaminationEnabled: true,
    );
    expect(result.contributions, hasLength(1));
    expect(result.contributions.single.isTrace, isFalse);
    expect(result.score, closeTo(1.5, 1e-9));
  });

  test('trace matches outside the profile are ignored', () {
    final result = calculator.calculate(
      matches: [match(AllergenCategory.egg, isTrace: true)],
      profile: {AllergenCategory.peanut: Severity.mild},
      crossContaminationEnabled: true,
    );
    expect(result.score, 0);
    expect(result.traceWarnings, isEmpty);
  });
}