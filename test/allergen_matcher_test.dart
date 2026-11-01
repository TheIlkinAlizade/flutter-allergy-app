import 'dart:convert';
import 'dart:io';

import 'package:allergy_app/core/allergen_dictionary.dart';
import 'package:allergy_app/core/allergen_matcher.dart';
import 'package:allergy_app/core/text_normalizer.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/ingredient_match.dart';
import 'package:flutter_test/flutter_test.dart';

AllergenDictionary loadDictionary() {
  final raw = File('assets/data/allergen_dictionary.json').readAsStringSync();
  return AllergenDictionary.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}

void main() {
  final matcher = AllergenMatcher(loadDictionary());

  Set<AllergenCategory> categories(List<String> items) {
    return matcher.match(items).map((m) => m.category).toSet();
  }

  group('TextNormalizer', () {
    test('folds Azerbaijani and Turkish letters', () {
      expect(TextNormalizer.normalize('SÜD'), 'sud');
      expect(TextNormalizer.normalize('Fındıq'), 'findiq');
      expect(TextNormalizer.normalize('FINDIK'), 'findik');
      expect(TextNormalizer.normalize('İnek'), 'inek');
    });

    test('unifies E-number spellings including Cyrillic Е', () {
      expect(TextNormalizer.normalize('E-322'), 'e322');
      expect(TextNormalizer.normalize('E 322'), 'e322');
      expect(TextNormalizer.normalize('(E322)'), 'e322');
      expect(TextNormalizer.normalize('Лецитин (Е322)'), 'лецитин e322');
    });
  });

  group('AllergenDictionary', () {
    test('covers every allergen category', () {
      final covered = loadDictionary().rules.map((r) => r.category).toSet();
      expect(covered, AllergenCategory.values.toSet());
    });

    test('rejects unknown categories', () {
      expect(
        () => AllergenDictionary.fromJson({
          'categories': {
            'unknown': {
              'direct': ['x'],
            },
          },
        }),
        throwsFormatException,
      );
    });
  });

  group('AllergenMatcher', () {
    test('reads the Azerbaijani reference label', () {
      expect(
        categories(['Araxid, Süd, Soya, Fındıq']),
        containsAll({
          AllergenCategory.peanut,
          AllergenCategory.milk,
          AllergenCategory.soy,
          AllergenCategory.treeNut,
        }),
      );
    });

    test('reads the English reference label', () {
      final found = categories(['Wheat flour, sugar, soy lecithin (E322), salt']);
      expect(found, containsAll({AllergenCategory.gluten, AllergenCategory.soy}));
      expect(found, isNot(contains(AllergenCategory.milk)));
      expect(found, isNot(contains(AllergenCategory.egg)));
    });

    test('reads the Turkish reference label', () {
      expect(
        categories(['Süt, Kabuklu Deniz Ürünleri']),
        containsAll({AllergenCategory.milk, AllergenCategory.shellfish}),
      );
    });

    test('marks derived ingredients with lower confidence', () {
      final matches = matcher.match(['whey powder']);
      expect(matches, hasLength(1));
      expect(matches.single.category, AllergenCategory.milk);
      expect(matches.single.confidence, MatchConfidence.derived);
    });

    test('maps every E322 spelling to soy', () {
      for (final text in ['E322', 'E 322', 'Е322']) {
        final matches = matcher.match([text]);
        expect(matches.map((m) => m.category), [AllergenCategory.soy]);
        expect(matches.single.confidence, MatchConfidence.derived);
      }
    });

    test('plant milks are not dairy but keep their own allergen', () {
      final almond = categories(['almond milk']);
      expect(almond, contains(AllergenCategory.treeNut));
      expect(almond, isNot(contains(AllergenCategory.milk)));

      final soy = categories(['soy milk']);
      expect(soy, contains(AllergenCategory.soy));
      expect(soy, isNot(contains(AllergenCategory.milk)));
    });

    test('whole-word rules avoid false matches', () {
      expect(categories(['eggplant']), isEmpty);
      expect(categories(['cocoa butter']), isEmpty);
      expect(categories(['cream of tartar']), isEmpty);
      final peanut = categories(['peanut oil']);
      expect(peanut, contains(AllergenCategory.peanut));
      expect(peanut, isNot(contains(AllergenCategory.treeNut)));
    });

    test('gluten-free flours are not flagged as gluten', () {
      expect(categories(['buckwheat flour']), isNot(contains(AllergenCategory.gluten)));
      expect(categories(['rice flour']), isNot(contains(AllergenCategory.gluten)));
      expect(categories(['wheat flour']), contains(AllergenCategory.gluten));
    });

    test('flags trace matches', () {
      final matches = matcher.match(['peanuts'], isTrace: true);
      expect(matches, isNotEmpty);
      expect(matches.every((m) => m.isTrace), isTrue);
    });

    test('returns nothing for harmless or blank input', () {
      expect(categories(['sugar, salt, water']), isEmpty);
      expect(matcher.match(['', '   ']), isEmpty);
    });
  });
}