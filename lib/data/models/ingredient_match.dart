import 'package:allergy_app/data/models/allergen_category.dart';

enum MatchConfidence {
  direct(1.0),
  derived(0.7);

  const MatchConfidence(this.weight);

  final double weight;
}

class IngredientMatch {
  const IngredientMatch({
    required this.ingredient,
    required this.category,
    required this.confidence,
    this.isTrace = false,
  });

  final String ingredient;
  final AllergenCategory category;
  final MatchConfidence confidence;
  final bool isTrace;
}