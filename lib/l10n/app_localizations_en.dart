// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTagline => 'Food allergen risk checker';

  @override
  String get navScan => 'Scan';

  @override
  String get navHistory => 'History';

  @override
  String get navProfile => 'Profile';

  @override
  String get navSettings => 'Settings';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonUndo => 'Undo';

  @override
  String get commonClear => 'Clear';

  @override
  String get disclaimer =>
      'This app helps you read food labels but is not a substitute for professional medical advice. Always check the packaging and follow your doctor’s guidance.';

  @override
  String get profileTitle => 'Allergy profile';

  @override
  String get profileIntro =>
      'Select the allergens you react to and how severe the reaction is. Scan results are scored against this profile.';

  @override
  String get crossTitle => 'Include “may contain” warnings';

  @override
  String get crossBody =>
      'Counts traces and shared-production-line warnings in the risk score. Recommended for severe allergies.';

  @override
  String get severityMild => 'Mild';

  @override
  String get severityModerate => 'Moderate';

  @override
  String get severityAnaphylaxis => 'Anaphylaxis';

  @override
  String get allergenPeanut => 'Peanut';

  @override
  String get allergenPeanutExamples => 'Groundnuts, peanut oil';

  @override
  String get allergenTreeNut => 'Tree nuts';

  @override
  String get allergenTreeNutExamples => 'Almond, hazelnut, walnut, cashew';

  @override
  String get allergenMilk => 'Milk and dairy';

  @override
  String get allergenMilkExamples => 'Milk, cheese, whey, lactose';

  @override
  String get allergenEgg => 'Egg';

  @override
  String get allergenEggExamples => 'Egg, albumin, mayonnaise';

  @override
  String get allergenGluten => 'Gluten';

  @override
  String get allergenGlutenExamples => 'Wheat, barley, rye, oats';

  @override
  String get allergenSoy => 'Soy';

  @override
  String get allergenSoyExamples => 'Soy, tofu, soy lecithin';

  @override
  String get allergenFish => 'Fish';

  @override
  String get allergenFishExamples => 'Salmon, tuna, cod, anchovy';

  @override
  String get allergenShellfish => 'Shellfish';

  @override
  String get allergenShellfishExamples => 'Shrimp, crab, mussels, squid';

  @override
  String get allergenSesame => 'Sesame';

  @override
  String get allergenSesameExamples => 'Sesame seeds, tahini';

  @override
  String get allergenCelery => 'Celery';

  @override
  String get allergenCeleryExamples => 'Celery, celeriac';

  @override
  String get allergenMustard => 'Mustard';

  @override
  String get allergenMustardExamples => 'Mustard seed, mustard flour';

  @override
  String get allergenLupin => 'Lupin';

  @override
  String get allergenLupinExamples => 'Lupin flour and seeds';

  @override
  String get allergenSulphites => 'Sulphites';

  @override
  String get allergenSulphitesExamples => 'Sulphur dioxide, E220 to E228';

  @override
  String get allergenAdditives => 'Food additives';

  @override
  String get allergenAdditivesExamples =>
      'Certain colours, preservatives, E621';

  @override
  String get scanTitle => 'Scan label';

  @override
  String get scanTipsTitle => 'For the best result';

  @override
  String get scanTip1 => 'Fill the frame with the whole ingredient list.';

  @override
  String get scanTip2 => 'Use good light and avoid glare on the packaging.';

  @override
  String get scanTip3 => 'Include any “may contain” or “traces of” warning.';

  @override
  String get scanTakePhoto => 'Take photo';

  @override
  String get scanChooseGallery => 'Choose from gallery';

  @override
  String get scanReading => 'Reading the label';

  @override
  String get scanProfileRequiredTitle => 'Set up your profile first';

  @override
  String get scanProfileRequiredBody =>
      'Select the allergens you react to. Without a profile, a scan has nothing to check the label against.';

  @override
  String get scanOpenProfile => 'Open profile';

  @override
  String get failureNotConfigured =>
      'Scanning is not set up yet. Add API_BASE_URL to env/dev.json and restart the app.';

  @override
  String get failureNetwork =>
      'Could not reach the scanning service. Check your internet connection and try again.';

  @override
  String get failureRateLimited =>
      'Too many scans in a short time. Wait a minute and try again.';

  @override
  String get failureBusy =>
      'The scanning service is busy right now. Try again in a moment.';

  @override
  String get failureImageTooLarge =>
      'This photo is too large. Try again with a closer or lower-resolution photo.';

  @override
  String get failureUnsupportedImage =>
      'This image format is not supported. Use a JPEG, PNG or WebP photo.';

  @override
  String get failureImageAccess =>
      'Could not open the camera or photos. Check the app permissions.';

  @override
  String get failureUnreadable =>
      'No ingredient list could be read from this photo. This is not a safe result. Make sure the whole list is in focus and well lit, then try again.';

  @override
  String get failureServer =>
      'Something went wrong while reading the label. Try again.';

  @override
  String get failureEmptyProfile =>
      'Select at least one allergen in your profile first. Without one, a scan cannot tell you anything.';

  @override
  String get resultTitle => 'Scan result';

  @override
  String get riskNoneTitle => 'No profile allergens detected';

  @override
  String get riskNoneSummary =>
      'Nothing in the scanned text matches your profile. Text recognition can miss things, so always check the package too.';

  @override
  String get riskTraceOnlyTitle => 'May contain allergens from your profile';

  @override
  String get riskTraceOnlySummary =>
      'The label has “may contain” warnings for allergens in your profile. They are not counted in the score because that setting is turned off.';

  @override
  String get riskCautionTitle => 'Caution';

  @override
  String get riskCautionSummary =>
      'This product contains allergens from your profile.';

  @override
  String get riskDangerTitle => 'High risk';

  @override
  String get riskDangerSummary =>
      'Avoid this product. It contains allergens from your profile with a high risk score.';

  @override
  String riskScoreWithValue(String score) {
    return 'Risk score $score';
  }

  @override
  String get riskScoreLabel => 'Risk score';

  @override
  String get breakdownTitle => 'Why this score';

  @override
  String get kindListed => 'Listed';

  @override
  String get kindDerived => 'Derived';

  @override
  String get kindMayContain => 'May contain';

  @override
  String crossFactorNote(String factor) {
    return 'Listed ingredients are multiplied by $factor because the label has a “may contain” warning.';
  }

  @override
  String get traceWarningsTitle => 'Trace warnings, not scored';

  @override
  String get traceWarningsSubtitle =>
      'These allergens are in your profile but only appear in a “may contain” warning. Turn on the “may contain” warnings option in your profile to count them.';

  @override
  String get otherAllergensTitle => 'Also found, not in your profile';

  @override
  String get otherAllergensSubtitle => 'These do not affect the score.';

  @override
  String get recognizedTitle => 'What was read from the label';

  @override
  String get recognizedSubtitle =>
      'Compare this with the package. Text recognition can make mistakes.';

  @override
  String get recognizedIngredients => 'Ingredients';

  @override
  String get recognizedMayContain => 'May contain';

  @override
  String get scanAnother => 'Scan another label';

  @override
  String get backToHistory => 'Back to history';

  @override
  String get historyTitle => 'History';

  @override
  String get historyEmpty => 'Your past scans will appear here.';

  @override
  String get historySearchHint => 'Search ingredients or allergens';

  @override
  String get historyNoMatches => 'No scans match your search.';

  @override
  String get historyClearTooltip => 'Clear history';

  @override
  String get historyClearTitle => 'Clear history?';

  @override
  String get historyClearBody => 'All saved scans will be deleted.';

  @override
  String get historyDeleted => 'Scan deleted';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageSystem => 'System default';

  @override
  String get settingsData => 'Data';

  @override
  String get settingsClearHistory => 'Clear scan history';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsAboutNote =>
      'Allergen matching works on English, Azerbaijani, Turkish and Russian labels, whatever language the app is shown in.';
}
