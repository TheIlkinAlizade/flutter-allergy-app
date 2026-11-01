import 'package:allergy_app/core/text_normalizer.dart';
import 'package:allergy_app/data/models/allergen_category.dart';

class CategoryRules {
  const CategoryRules({
    required this.category,
    required this.direct,
    required this.derived,
    required this.exclude,
  });

  final AllergenCategory category;
  final List<RegExp> direct;
  final List<RegExp> derived;
  final List<RegExp> exclude;
}

class AllergenDictionary {
  const AllergenDictionary(this.rules);

  final List<CategoryRules> rules;

  factory AllergenDictionary.fromJson(Map<String, dynamic> json) {
    final categories = json['categories'];
    if (categories is! Map<String, dynamic>) {
      throw const FormatException('Dictionary is missing "categories"');
    }

    final rules = <CategoryRules>[];
    for (final entry in categories.entries) {
      final category = AllergenCategory.fromId(entry.key);
      if (category == null) {
        throw FormatException('Unknown category "${entry.key}"');
      }
      final body = entry.value;
      if (body is! Map<String, dynamic>) {
        throw FormatException('Category "${entry.key}" must be an object');
      }
      rules.add(
        CategoryRules(
          category: category,
          direct: _compile(body['direct'], entry.key),
          derived: _compile(body['derived'], entry.key),
          exclude: _compile(body['exclude'], entry.key),
        ),
      );
    }
    return AllergenDictionary(rules);
  }

  static List<RegExp> _compile(Object? raw, String categoryId) {
    if (raw == null) return const [];
    if (raw is! List) {
      throw FormatException('Terms of "$categoryId" must be a list');
    }
    return [for (final term in raw) _compileTerm(term, categoryId)];
  }

  static RegExp _compileTerm(Object? term, String categoryId) {
    if (term is! String) {
      throw FormatException('Non-text term in "$categoryId"');
    }
    final isStem = term.endsWith('*');
    final normalized = TextNormalizer.normalize(
      isStem ? term.substring(0, term.length - 1) : term,
    );
    if (normalized.isEmpty) {
      throw FormatException('Empty term in "$categoryId"');
    }
    final head = '(?<![${TextNormalizer.wordChars}])';
    final tail = isStem ? '' : '(?![${TextNormalizer.wordChars}])';
    return RegExp('$head${RegExp.escape(normalized)}$tail');
  }
}