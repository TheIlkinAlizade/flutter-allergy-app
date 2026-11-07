// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get appTagline => 'Qida allergenlərinin risk yoxlayıcısı';

  @override
  String get navScan => 'Skan';

  @override
  String get navHistory => 'Tarixçə';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get commonCancel => 'Ləğv et';

  @override
  String get commonUndo => 'Geri al';

  @override
  String get commonClear => 'Təmizlə';

  @override
  String get disclaimer =>
      'Bu tətbiq qida etiketlərini oxumağa kömək edir, lakin peşəkar tibbi məsləhəti əvəz etmir. Həmişə qablaşdırmanı yoxlayın və həkiminizin tövsiyələrinə əməl edin.';

  @override
  String get profileTitle => 'Allergiya profili';

  @override
  String get profileIntro =>
      'Reaksiya verdiyiniz allergenləri və reaksiyanın nə qədər ağır olduğunu seçin. Skan nəticələri bu profilə görə qiymətləndirilir.';

  @override
  String get crossTitle => '“Tərkibində ola bilər” xəbərdarlıqlarını daxil et';

  @override
  String get crossBody =>
      'İzlərə və ortaq istehsal xəttinə dair xəbərdarlıqlar risk balına daxil edilir. Ağır allergiyalar üçün tövsiyə olunur.';

  @override
  String get severityMild => 'Yüngül';

  @override
  String get severityModerate => 'Orta';

  @override
  String get severityAnaphylaxis => 'Anafilaksiya';

  @override
  String get allergenPeanut => 'Araxid (yerfındığı)';

  @override
  String get allergenPeanutExamples => 'Yerfındığı, araxid yağı';

  @override
  String get allergenTreeNut => 'Ağac fındıqları';

  @override
  String get allergenTreeNutExamples => 'Badam, fındıq, qoz, kaju';

  @override
  String get allergenMilk => 'Süd və süd məhsulları';

  @override
  String get allergenMilkExamples => 'Süd, pendir, zərdab, laktoza';

  @override
  String get allergenEgg => 'Yumurta';

  @override
  String get allergenEggExamples => 'Yumurta, albumin, mayonez';

  @override
  String get allergenGluten => 'Qluten';

  @override
  String get allergenGlutenExamples => 'Buğda, arpa, çovdar, yulaf';

  @override
  String get allergenSoy => 'Soya';

  @override
  String get allergenSoyExamples => 'Soya, tofu, soya lesitini';

  @override
  String get allergenFish => 'Balıq';

  @override
  String get allergenFishExamples => 'Qızılbalıq, tuna, treska, kilkə';

  @override
  String get allergenShellfish => 'Dəniz qabıqlıları';

  @override
  String get allergenShellfishExamples => 'Krevet, krab, midiya, kalmar';

  @override
  String get allergenSesame => 'Küncüt';

  @override
  String get allergenSesameExamples => 'Küncüt toxumu, tahin';

  @override
  String get allergenCelery => 'Kərəviz';

  @override
  String get allergenCeleryExamples => 'Kərəviz, kök kərəviz';

  @override
  String get allergenMustard => 'Xardal';

  @override
  String get allergenMustardExamples => 'Xardal toxumu, xardal unu';

  @override
  String get allergenLupin => 'Lupin';

  @override
  String get allergenLupinExamples => 'Lupin unu və toxumları';

  @override
  String get allergenSulphites => 'Sulfitlər';

  @override
  String get allergenSulphitesExamples => 'Kükürd dioksidi, E220–E228';

  @override
  String get allergenAdditives => 'Qida əlavələri';

  @override
  String get allergenAdditivesExamples => 'Bəzi boyalar, konservantlar, E621';

  @override
  String get scanTitle => 'Etiketi skan et';

  @override
  String get scanTipsTitle => 'Ən yaxşı nəticə üçün';

  @override
  String get scanTip1 => 'Tərkib siyahısının hamısını kadra sığdırın.';

  @override
  String get scanTip2 =>
      'Yaxşı işıqdan istifadə edin və qablaşdırmadakı əksliyin qarşısını alın.';

  @override
  String get scanTip3 =>
      'Varsa, “tərkibində ola bilər” və ya “izləri ola bilər” xəbərdarlığını da daxil edin.';

  @override
  String get scanTakePhoto => 'Şəkil çək';

  @override
  String get scanChooseGallery => 'Qalereyadan seç';

  @override
  String get scanReading => 'Etiket oxunur';

  @override
  String get scanProfileRequiredTitle => 'Əvvəlcə profilinizi qurun';

  @override
  String get scanProfileRequiredBody =>
      'Reaksiya verdiyiniz allergenləri seçin. Profil olmadan skan etiketi nəyləsə müqayisə edə bilməz.';

  @override
  String get scanOpenProfile => 'Profili aç';

  @override
  String get failureNotConfigured =>
      'Skan hələ qurulmayıb. env/dev.json faylına API_BASE_URL əlavə edib tətbiqi yenidən başladın.';

  @override
  String get failureNetwork =>
      'Skan xidmətinə qoşulmaq mümkün olmadı. İnternet bağlantınızı yoxlayıb yenidən cəhd edin.';

  @override
  String get failureRateLimited =>
      'Qısa müddətdə çox skan edilib. Bir dəqiqə gözləyib yenidən cəhd edin.';

  @override
  String get failureBusy =>
      'Skan xidməti hazırda məşğuldur. Bir az sonra yenidən cəhd edin.';

  @override
  String get failureImageTooLarge =>
      'Bu şəkil çox böyükdür. Daha yaxından və ya daha aşağı ayırdetmə ilə yenidən çəkin.';

  @override
  String get failureUnsupportedImage =>
      'Bu şəkil formatı dəstəklənmir. JPEG, PNG və ya WebP şəkildən istifadə edin.';

  @override
  String get failureImageAccess =>
      'Kameraya və ya şəkillərə giriş mümkün olmadı. Tətbiq icazələrini yoxlayın.';

  @override
  String get failureUnreadable =>
      'Bu şəkildən tərkib siyahısı oxunmadı. Bu, təhlükəsizlik nəticəsi deyil. Bütün siyahının fokusda və yaxşı işıqlandırılmış olduğundan əmin olub yenidən cəhd edin.';

  @override
  String get failureServer =>
      'Etiket oxunarkən xəta baş verdi. Yenidən cəhd edin.';

  @override
  String get failureEmptyProfile =>
      'Əvvəlcə profilinizdə ən azı bir allergen seçin. Onsuz skan sizə heç nə deyə bilməz.';

  @override
  String get resultTitle => 'Skan nəticəsi';

  @override
  String get riskNoneTitle => 'Profilinizdəki allergenlər aşkarlanmadı';

  @override
  String get riskNoneSummary =>
      'Skan edilmiş mətndə profilinizə uyğun heç nə yoxdur. Mətn tanıma bəzi şeyləri buraxa bilər, ona görə qablaşdırmanı da mütləq yoxlayın.';

  @override
  String get riskTraceOnlyTitle => 'Profilinizdəki allergenlər ola bilər';

  @override
  String get riskTraceOnlySummary =>
      'Etiketdə profilinizdəki allergenlər üçün “ola bilər” xəbərdarlıqları var. Həmin ayar söndürülü olduğu üçün onlar risk balına daxil edilmir.';

  @override
  String get riskCautionTitle => 'Diqqət';

  @override
  String get riskCautionSummary =>
      'Bu məhsulda profilinizdəki allergenlər var.';

  @override
  String get riskDangerTitle => 'Yüksək risk';

  @override
  String get riskDangerSummary =>
      'Bu məhsuldan istifadə etməyin. Tərkibində profilinizdəki allergenlər var və risk balı yüksəkdir.';

  @override
  String riskScoreWithValue(String score) {
    return 'Risk balı $score';
  }

  @override
  String get riskScoreLabel => 'Risk balı';

  @override
  String get breakdownTitle => 'Bu bal niyə belədir';

  @override
  String get kindListed => 'Tərkibdə';

  @override
  String get kindDerived => 'Törəmə';

  @override
  String get kindMayContain => 'Ola bilər';

  @override
  String crossFactorNote(String factor) {
    return 'Etiketdə “ola bilər” xəbərdarlığı olduğu üçün tərkibdə göstərilən maddələr $factor əmsalı ilə vurulur.';
  }

  @override
  String get traceWarningsTitle => 'İz xəbərdarlıqları, hesablanmır';

  @override
  String get traceWarningsSubtitle =>
      'Bu allergenlər profilinizdədir, lakin yalnız “ola bilər” xəbərdarlığında görünür. Onları hesaba qatmaq üçün profilinizdə “ola bilər” xəbərdarlıqları seçimini yandırın.';

  @override
  String get otherAllergensTitle => 'Həmçinin tapıldı, profilinizdə yoxdur';

  @override
  String get otherAllergensSubtitle => 'Bunlar risk balına təsir etmir.';

  @override
  String get recognizedTitle => 'Etiketdən nə oxundu';

  @override
  String get recognizedSubtitle =>
      'Bunu qablaşdırma ilə müqayisə edin. Mətn tanıma səhv edə bilər.';

  @override
  String get recognizedIngredients => 'Tərkib';

  @override
  String get recognizedMayContain => 'Ola bilər';

  @override
  String get scanAnother => 'Başqa etiketi skan et';

  @override
  String get backToHistory => 'Tarixçəyə qayıt';

  @override
  String get historyTitle => 'Tarixçə';

  @override
  String get historyEmpty => 'Keçmiş skanlarınız burada görünəcək.';

  @override
  String get historySearchHint => 'Tərkib və ya allergen üzrə axtar';

  @override
  String get historyNoMatches => 'Axtarışınıza uyğun skan yoxdur.';

  @override
  String get historyClearTooltip => 'Tarixçəni təmizlə';

  @override
  String get historyClearTitle => 'Tarixçə təmizlənsin?';

  @override
  String get historyClearBody => 'Bütün saxlanılmış skanlar silinəcək.';

  @override
  String get historyDeleted => 'Skan silindi';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get languageSystem => 'Sistem dili';

  @override
  String get settingsData => 'Məlumatlar';

  @override
  String get settingsClearHistory => 'Skan tarixçəsini təmizlə';

  @override
  String get settingsAbout => 'Haqqında';

  @override
  String get settingsAboutNote =>
      'Allergen tanıma tətbiqin göstərildiyi dildən asılı olmayaraq ingilis, azərbaycan, türk və rus dillərindəki etiketlərdə işləyir.';
}
