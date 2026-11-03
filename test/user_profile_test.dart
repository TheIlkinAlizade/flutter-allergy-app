import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/severity.dart';
import 'package:allergy_app/data/models/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('survives a save and load round trip', () {
    final profile = const UserProfile()
        .withAllergen(AllergenCategory.peanut, Severity.anaphylaxis)
        .withAllergen(AllergenCategory.milk, Severity.mild)
        .withCrossContamination(false);

    final restored = UserProfile.fromJson(profile.toJson());

    expect(restored.allergens, profile.allergens);
    expect(restored.crossContamination, isFalse);
  });

  test('corrupt severities fall back to the safest level', () {
    final restored = UserProfile.fromJson({
      'allergens': {
        'peanut': 1,
        'martian_dust': 2,
        'milk': 9,
        'soy': 'high',
      },
      'crossContamination': 'yes',
    });

    expect(restored.allergens, {
      AllergenCategory.peanut: Severity.mild,
      AllergenCategory.milk: Severity.anaphylaxis,
      AllergenCategory.soy: Severity.anaphylaxis,
    });
    expect(restored.crossContamination, isTrue);
  });

  test('empty storage gives an empty profile with traces counted', () {
    final restored = UserProfile.fromJson({});

    expect(restored.allergens, isEmpty);
    expect(restored.crossContamination, isTrue);
  });
}