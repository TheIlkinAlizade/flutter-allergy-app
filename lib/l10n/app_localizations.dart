import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_az.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('az'),
    Locale('en'),
    Locale('ru'),
    Locale('tr'),
  ];

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Food allergen risk checker'**
  String get appTagline;

  /// No description provided for @navScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get navScan;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get commonUndo;

  /// No description provided for @commonClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'This app helps you read food labels but is not a substitute for professional medical advice. Always check the packaging and follow your doctor’s guidance.'**
  String get disclaimer;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Allergy profile'**
  String get profileTitle;

  /// No description provided for @profileIntro.
  ///
  /// In en, this message translates to:
  /// **'Select the allergens you react to and how severe the reaction is. Scan results are scored against this profile.'**
  String get profileIntro;

  /// No description provided for @crossTitle.
  ///
  /// In en, this message translates to:
  /// **'Include “may contain” warnings'**
  String get crossTitle;

  /// No description provided for @crossBody.
  ///
  /// In en, this message translates to:
  /// **'Counts traces and shared-production-line warnings in the risk score. Recommended for severe allergies.'**
  String get crossBody;

  /// No description provided for @severityMild.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get severityMild;

  /// No description provided for @severityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get severityModerate;

  /// No description provided for @severityAnaphylaxis.
  ///
  /// In en, this message translates to:
  /// **'Anaphylaxis'**
  String get severityAnaphylaxis;

  /// No description provided for @allergenPeanut.
  ///
  /// In en, this message translates to:
  /// **'Peanut'**
  String get allergenPeanut;

  /// No description provided for @allergenPeanutExamples.
  ///
  /// In en, this message translates to:
  /// **'Groundnuts, peanut oil'**
  String get allergenPeanutExamples;

  /// No description provided for @allergenTreeNut.
  ///
  /// In en, this message translates to:
  /// **'Tree nuts'**
  String get allergenTreeNut;

  /// No description provided for @allergenTreeNutExamples.
  ///
  /// In en, this message translates to:
  /// **'Almond, hazelnut, walnut, cashew'**
  String get allergenTreeNutExamples;

  /// No description provided for @allergenMilk.
  ///
  /// In en, this message translates to:
  /// **'Milk and dairy'**
  String get allergenMilk;

  /// No description provided for @allergenMilkExamples.
  ///
  /// In en, this message translates to:
  /// **'Milk, cheese, whey, lactose'**
  String get allergenMilkExamples;

  /// No description provided for @allergenEgg.
  ///
  /// In en, this message translates to:
  /// **'Egg'**
  String get allergenEgg;

  /// No description provided for @allergenEggExamples.
  ///
  /// In en, this message translates to:
  /// **'Egg, albumin, mayonnaise'**
  String get allergenEggExamples;

  /// No description provided for @allergenGluten.
  ///
  /// In en, this message translates to:
  /// **'Gluten'**
  String get allergenGluten;

  /// No description provided for @allergenGlutenExamples.
  ///
  /// In en, this message translates to:
  /// **'Wheat, barley, rye, oats'**
  String get allergenGlutenExamples;

  /// No description provided for @allergenSoy.
  ///
  /// In en, this message translates to:
  /// **'Soy'**
  String get allergenSoy;

  /// No description provided for @allergenSoyExamples.
  ///
  /// In en, this message translates to:
  /// **'Soy, tofu, soy lecithin'**
  String get allergenSoyExamples;

  /// No description provided for @allergenFish.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get allergenFish;

  /// No description provided for @allergenFishExamples.
  ///
  /// In en, this message translates to:
  /// **'Salmon, tuna, cod, anchovy'**
  String get allergenFishExamples;

  /// No description provided for @allergenShellfish.
  ///
  /// In en, this message translates to:
  /// **'Shellfish'**
  String get allergenShellfish;

  /// No description provided for @allergenShellfishExamples.
  ///
  /// In en, this message translates to:
  /// **'Shrimp, crab, mussels, squid'**
  String get allergenShellfishExamples;

  /// No description provided for @allergenSesame.
  ///
  /// In en, this message translates to:
  /// **'Sesame'**
  String get allergenSesame;

  /// No description provided for @allergenSesameExamples.
  ///
  /// In en, this message translates to:
  /// **'Sesame seeds, tahini'**
  String get allergenSesameExamples;

  /// No description provided for @allergenCelery.
  ///
  /// In en, this message translates to:
  /// **'Celery'**
  String get allergenCelery;

  /// No description provided for @allergenCeleryExamples.
  ///
  /// In en, this message translates to:
  /// **'Celery, celeriac'**
  String get allergenCeleryExamples;

  /// No description provided for @allergenMustard.
  ///
  /// In en, this message translates to:
  /// **'Mustard'**
  String get allergenMustard;

  /// No description provided for @allergenMustardExamples.
  ///
  /// In en, this message translates to:
  /// **'Mustard seed, mustard flour'**
  String get allergenMustardExamples;

  /// No description provided for @allergenLupin.
  ///
  /// In en, this message translates to:
  /// **'Lupin'**
  String get allergenLupin;

  /// No description provided for @allergenLupinExamples.
  ///
  /// In en, this message translates to:
  /// **'Lupin flour and seeds'**
  String get allergenLupinExamples;

  /// No description provided for @allergenSulphites.
  ///
  /// In en, this message translates to:
  /// **'Sulphites'**
  String get allergenSulphites;

  /// No description provided for @allergenSulphitesExamples.
  ///
  /// In en, this message translates to:
  /// **'Sulphur dioxide, E220 to E228'**
  String get allergenSulphitesExamples;

  /// No description provided for @allergenAdditives.
  ///
  /// In en, this message translates to:
  /// **'Food additives'**
  String get allergenAdditives;

  /// No description provided for @allergenAdditivesExamples.
  ///
  /// In en, this message translates to:
  /// **'Certain colours, preservatives, E621'**
  String get allergenAdditivesExamples;

  /// No description provided for @scanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan label'**
  String get scanTitle;

  /// No description provided for @scanTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'For the best result'**
  String get scanTipsTitle;

  /// No description provided for @scanTip1.
  ///
  /// In en, this message translates to:
  /// **'Fill the frame with the whole ingredient list.'**
  String get scanTip1;

  /// No description provided for @scanTip2.
  ///
  /// In en, this message translates to:
  /// **'Use good light and avoid glare on the packaging.'**
  String get scanTip2;

  /// No description provided for @scanTip3.
  ///
  /// In en, this message translates to:
  /// **'Include any “may contain” or “traces of” warning.'**
  String get scanTip3;

  /// No description provided for @scanTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get scanTakePhoto;

  /// No description provided for @scanChooseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get scanChooseGallery;

  /// No description provided for @scanReading.
  ///
  /// In en, this message translates to:
  /// **'Reading the label'**
  String get scanReading;

  /// No description provided for @scanProfileRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up your profile first'**
  String get scanProfileRequiredTitle;

  /// No description provided for @scanProfileRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'Select the allergens you react to. Without a profile, a scan has nothing to check the label against.'**
  String get scanProfileRequiredBody;

  /// No description provided for @scanOpenProfile.
  ///
  /// In en, this message translates to:
  /// **'Open profile'**
  String get scanOpenProfile;

  /// No description provided for @failureNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Scanning is not set up yet. Add API_BASE_URL to env/dev.json and restart the app.'**
  String get failureNotConfigured;

  /// No description provided for @failureNetwork.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the scanning service. Check your internet connection and try again.'**
  String get failureNetwork;

  /// No description provided for @failureRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many scans in a short time. Wait a minute and try again.'**
  String get failureRateLimited;

  /// No description provided for @failureBusy.
  ///
  /// In en, this message translates to:
  /// **'The scanning service is busy right now. Try again in a moment.'**
  String get failureBusy;

  /// No description provided for @failureImageTooLarge.
  ///
  /// In en, this message translates to:
  /// **'This photo is too large. Try again with a closer or lower-resolution photo.'**
  String get failureImageTooLarge;

  /// No description provided for @failureUnsupportedImage.
  ///
  /// In en, this message translates to:
  /// **'This image format is not supported. Use a JPEG, PNG or WebP photo.'**
  String get failureUnsupportedImage;

  /// No description provided for @failureImageAccess.
  ///
  /// In en, this message translates to:
  /// **'Could not open the camera or photos. Check the app permissions.'**
  String get failureImageAccess;

  /// No description provided for @failureUnreadable.
  ///
  /// In en, this message translates to:
  /// **'No ingredient list could be read from this photo. This is not a safe result. Make sure the whole list is in focus and well lit, then try again.'**
  String get failureUnreadable;

  /// No description provided for @failureServer.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while reading the label. Try again.'**
  String get failureServer;

  /// No description provided for @failureEmptyProfile.
  ///
  /// In en, this message translates to:
  /// **'Select at least one allergen in your profile first. Without one, a scan cannot tell you anything.'**
  String get failureEmptyProfile;

  /// No description provided for @resultTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan result'**
  String get resultTitle;

  /// No description provided for @riskNoneTitle.
  ///
  /// In en, this message translates to:
  /// **'No profile allergens detected'**
  String get riskNoneTitle;

  /// No description provided for @riskNoneSummary.
  ///
  /// In en, this message translates to:
  /// **'Nothing in the scanned text matches your profile. Text recognition can miss things, so always check the package too.'**
  String get riskNoneSummary;

  /// No description provided for @riskTraceOnlyTitle.
  ///
  /// In en, this message translates to:
  /// **'May contain allergens from your profile'**
  String get riskTraceOnlyTitle;

  /// No description provided for @riskTraceOnlySummary.
  ///
  /// In en, this message translates to:
  /// **'The label has “may contain” warnings for allergens in your profile. They are not counted in the score because that setting is turned off.'**
  String get riskTraceOnlySummary;

  /// No description provided for @riskCautionTitle.
  ///
  /// In en, this message translates to:
  /// **'Caution'**
  String get riskCautionTitle;

  /// No description provided for @riskCautionSummary.
  ///
  /// In en, this message translates to:
  /// **'This product contains allergens from your profile.'**
  String get riskCautionSummary;

  /// No description provided for @riskDangerTitle.
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get riskDangerTitle;

  /// No description provided for @riskDangerSummary.
  ///
  /// In en, this message translates to:
  /// **'Avoid this product. It contains allergens from your profile with a high risk score.'**
  String get riskDangerSummary;

  /// No description provided for @riskScoreWithValue.
  ///
  /// In en, this message translates to:
  /// **'Risk score {score}'**
  String riskScoreWithValue(String score);

  /// No description provided for @riskScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Risk score'**
  String get riskScoreLabel;

  /// No description provided for @breakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Why this score'**
  String get breakdownTitle;

  /// No description provided for @kindListed.
  ///
  /// In en, this message translates to:
  /// **'Listed'**
  String get kindListed;

  /// No description provided for @kindDerived.
  ///
  /// In en, this message translates to:
  /// **'Derived'**
  String get kindDerived;

  /// No description provided for @kindMayContain.
  ///
  /// In en, this message translates to:
  /// **'May contain'**
  String get kindMayContain;

  /// No description provided for @crossFactorNote.
  ///
  /// In en, this message translates to:
  /// **'Listed ingredients are multiplied by {factor} because the label has a “may contain” warning.'**
  String crossFactorNote(String factor);

  /// No description provided for @traceWarningsTitle.
  ///
  /// In en, this message translates to:
  /// **'Trace warnings, not scored'**
  String get traceWarningsTitle;

  /// No description provided for @traceWarningsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'These allergens are in your profile but only appear in a “may contain” warning. Turn on the “may contain” warnings option in your profile to count them.'**
  String get traceWarningsSubtitle;

  /// No description provided for @otherAllergensTitle.
  ///
  /// In en, this message translates to:
  /// **'Also found, not in your profile'**
  String get otherAllergensTitle;

  /// No description provided for @otherAllergensSubtitle.
  ///
  /// In en, this message translates to:
  /// **'These do not affect the score.'**
  String get otherAllergensSubtitle;

  /// No description provided for @recognizedTitle.
  ///
  /// In en, this message translates to:
  /// **'What was read from the label'**
  String get recognizedTitle;

  /// No description provided for @recognizedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Compare this with the package. Text recognition can make mistakes.'**
  String get recognizedSubtitle;

  /// No description provided for @recognizedIngredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get recognizedIngredients;

  /// No description provided for @recognizedMayContain.
  ///
  /// In en, this message translates to:
  /// **'May contain'**
  String get recognizedMayContain;

  /// No description provided for @scanAnother.
  ///
  /// In en, this message translates to:
  /// **'Scan another label'**
  String get scanAnother;

  /// No description provided for @backToHistory.
  ///
  /// In en, this message translates to:
  /// **'Back to history'**
  String get backToHistory;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your past scans will appear here.'**
  String get historyEmpty;

  /// No description provided for @historySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search ingredients or allergens'**
  String get historySearchHint;

  /// No description provided for @historyNoMatches.
  ///
  /// In en, this message translates to:
  /// **'No scans match your search.'**
  String get historyNoMatches;

  /// No description provided for @historyClearTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get historyClearTooltip;

  /// No description provided for @historyClearTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear history?'**
  String get historyClearTitle;

  /// No description provided for @historyClearBody.
  ///
  /// In en, this message translates to:
  /// **'All saved scans will be deleted.'**
  String get historyClearBody;

  /// No description provided for @historyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Scan deleted'**
  String get historyDeleted;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystem;

  /// No description provided for @settingsData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsData;

  /// No description provided for @settingsClearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear scan history'**
  String get settingsClearHistory;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsAboutNote.
  ///
  /// In en, this message translates to:
  /// **'Allergen matching works on English, Azerbaijani, Turkish and Russian labels, whatever language the app is shown in.'**
  String get settingsAboutNote;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['az', 'en', 'ru', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'az':
      return AppLocalizationsAz();
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
