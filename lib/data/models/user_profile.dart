import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/severity.dart';

class UserProfile {
  const UserProfile({
    this.allergens = const {},
    this.crossContamination = true,
  });

  factory UserProfile.fromJson(Map<dynamic, dynamic> json) {
    final allergens = <AllergenCategory, Severity>{};
    final raw = json['allergens'];
    if (raw is Map) {
      for (final entry in raw.entries) {
        final key = entry.key;
        final category = key is String ? AllergenCategory.fromId(key) : null;
        if (category == null) continue;
        final value = entry.value;
        allergens[category] =
            (value is int ? Severity.fromWeight(value) : null) ??
                Severity.anaphylaxis;
      }
    }
    final cross = json['crossContamination'];
    return UserProfile(
      allergens: allergens,
      crossContamination: cross is bool ? cross : true,
    );
  }

  final Map<AllergenCategory, Severity> allergens;
  final bool crossContamination;

  UserProfile withAllergen(AllergenCategory category, Severity severity) {
    return UserProfile(
      allergens: {...allergens, category: severity},
      crossContamination: crossContamination,
    );
  }

  UserProfile withoutAllergen(AllergenCategory category) {
    return UserProfile(
      allergens: {...allergens}..remove(category),
      crossContamination: crossContamination,
    );
  }

  UserProfile withCrossContamination(bool value) {
    return UserProfile(allergens: allergens, crossContamination: value);
  }

  Map<String, dynamic> toJson() {
    return {
      'allergens': {
        for (final entry in allergens.entries) entry.key.id: entry.value.weight,
      },
      'crossContamination': crossContamination,
    };
  }
}