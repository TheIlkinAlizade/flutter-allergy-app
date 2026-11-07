import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/severity.dart';
import 'package:allergy_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension AllergenCategoryLabels on AllergenCategory {
  String label(AppLocalizations l10n) => switch (this) {
        AllergenCategory.peanut => l10n.allergenPeanut,
        AllergenCategory.treeNut => l10n.allergenTreeNut,
        AllergenCategory.milk => l10n.allergenMilk,
        AllergenCategory.egg => l10n.allergenEgg,
        AllergenCategory.gluten => l10n.allergenGluten,
        AllergenCategory.soy => l10n.allergenSoy,
        AllergenCategory.fish => l10n.allergenFish,
        AllergenCategory.shellfish => l10n.allergenShellfish,
        AllergenCategory.sesame => l10n.allergenSesame,
        AllergenCategory.celery => l10n.allergenCelery,
        AllergenCategory.mustard => l10n.allergenMustard,
        AllergenCategory.lupin => l10n.allergenLupin,
        AllergenCategory.sulphites => l10n.allergenSulphites,
        AllergenCategory.additives => l10n.allergenAdditives,
      };

  String examples(AppLocalizations l10n) => switch (this) {
        AllergenCategory.peanut => l10n.allergenPeanutExamples,
        AllergenCategory.treeNut => l10n.allergenTreeNutExamples,
        AllergenCategory.milk => l10n.allergenMilkExamples,
        AllergenCategory.egg => l10n.allergenEggExamples,
        AllergenCategory.gluten => l10n.allergenGlutenExamples,
        AllergenCategory.soy => l10n.allergenSoyExamples,
        AllergenCategory.fish => l10n.allergenFishExamples,
        AllergenCategory.shellfish => l10n.allergenShellfishExamples,
        AllergenCategory.sesame => l10n.allergenSesameExamples,
        AllergenCategory.celery => l10n.allergenCeleryExamples,
        AllergenCategory.mustard => l10n.allergenMustardExamples,
        AllergenCategory.lupin => l10n.allergenLupinExamples,
        AllergenCategory.sulphites => l10n.allergenSulphitesExamples,
        AllergenCategory.additives => l10n.allergenAdditivesExamples,
      };
}

extension SeverityLabels on Severity {
  String label(AppLocalizations l10n) => switch (this) {
        Severity.mild => l10n.severityMild,
        Severity.moderate => l10n.severityModerate,
        Severity.anaphylaxis => l10n.severityAnaphylaxis,
      };

  Color get color => switch (this) {
        Severity.mild => AppTheme.severityMild,
        Severity.moderate => AppTheme.severityModerate,
        Severity.anaphylaxis => AppTheme.severityAnaphylaxis,
      };
}