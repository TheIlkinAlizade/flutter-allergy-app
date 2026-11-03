import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/severity.dart';
import 'package:flutter/material.dart';

extension AllergenCategoryLabels on AllergenCategory {
  String get label => switch (this) {
        AllergenCategory.peanut => 'Peanut',
        AllergenCategory.treeNut => 'Tree nuts',
        AllergenCategory.milk => 'Milk and dairy',
        AllergenCategory.egg => 'Egg',
        AllergenCategory.gluten => 'Gluten',
        AllergenCategory.soy => 'Soy',
        AllergenCategory.fish => 'Fish',
        AllergenCategory.shellfish => 'Shellfish',
        AllergenCategory.sesame => 'Sesame',
        AllergenCategory.celery => 'Celery',
        AllergenCategory.mustard => 'Mustard',
        AllergenCategory.lupin => 'Lupin',
        AllergenCategory.sulphites => 'Sulphites',
        AllergenCategory.additives => 'Food additives',
      };

  String get examples => switch (this) {
        AllergenCategory.peanut => 'Groundnuts, peanut oil',
        AllergenCategory.treeNut => 'Almond, hazelnut, walnut, cashew',
        AllergenCategory.milk => 'Milk, cheese, whey, lactose',
        AllergenCategory.egg => 'Egg, albumin, mayonnaise',
        AllergenCategory.gluten => 'Wheat, barley, rye, oats',
        AllergenCategory.soy => 'Soy, tofu, soy lecithin',
        AllergenCategory.fish => 'Salmon, tuna, cod, anchovy',
        AllergenCategory.shellfish => 'Shrimp, crab, mussels, squid',
        AllergenCategory.sesame => 'Sesame seeds, tahini',
        AllergenCategory.celery => 'Celery, celeriac',
        AllergenCategory.mustard => 'Mustard seed, mustard flour',
        AllergenCategory.lupin => 'Lupin flour and seeds',
        AllergenCategory.sulphites => 'Sulphur dioxide, E220 to E228',
        AllergenCategory.additives => 'Certain colours, preservatives, E621',
      };
}

extension SeverityLabels on Severity {
  String get label => switch (this) {
        Severity.mild => 'Mild',
        Severity.moderate => 'Moderate',
        Severity.anaphylaxis => 'Anaphylaxis',
      };

  Color get color => switch (this) {
        Severity.mild => AppTheme.severityMild,
        Severity.moderate => AppTheme.severityModerate,
        Severity.anaphylaxis => AppTheme.severityAnaphylaxis,
      };
}