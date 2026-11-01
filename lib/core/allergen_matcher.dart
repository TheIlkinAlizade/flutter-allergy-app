import 'package:allergy_app/core/allergen_dictionary.dart';
import 'package:allergy_app/core/text_normalizer.dart';
import 'package:allergy_app/data/models/ingredient_match.dart';

class AllergenMatcher {
  const AllergenMatcher(this._dictionary);

  final AllergenDictionary _dictionary;

  List<IngredientMatch> match(
    List<String> ingredients, {
    bool isTrace = false,
  }) {
    final matches = <IngredientMatch>[];
    for (final ingredient in ingredients) {
      final text = TextNormalizer.normalize(ingredient);
      if (text.isEmpty) continue;
      for (final rules in _dictionary.rules) {
        final confidence = _confidenceFor(text, rules);
        if (confidence == null) continue;
        matches.add(
          IngredientMatch(
            ingredient: ingredient,
            category: rules.category,
            confidence: confidence,
            isTrace: isTrace,
          ),
        );
      }
    }
    return matches;
  }

  MatchConfidence? _confidenceFor(String text, CategoryRules rules) {
    var cleaned = text;
    for (final pattern in rules.exclude) {
      cleaned = cleaned.replaceAll(pattern, ' ');
    }
    if (rules.direct.any((p) => p.hasMatch(cleaned))) {
      return MatchConfidence.direct;
    }
    if (rules.derived.any((p) => p.hasMatch(cleaned))) {
      return MatchConfidence.derived;
    }
    return null;
  }
}