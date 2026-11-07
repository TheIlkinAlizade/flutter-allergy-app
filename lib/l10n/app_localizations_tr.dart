// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTagline => 'Gıda alerjeni risk denetleyicisi';

  @override
  String get navScan => 'Tara';

  @override
  String get navHistory => 'Geçmiş';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get commonCancel => 'İptal';

  @override
  String get commonUndo => 'Geri al';

  @override
  String get commonClear => 'Temizle';

  @override
  String get disclaimer =>
      'Bu uygulama gıda etiketlerini okumanıza yardımcı olur ancak profesyonel tıbbi tavsiyenin yerini tutmaz. Ambalajı her zaman kontrol edin ve doktorunuzun yönlendirmelerine uyun.';

  @override
  String get profileTitle => 'Alerji profili';

  @override
  String get profileIntro =>
      'Tepki verdiğiniz alerjenleri ve tepkinin ne kadar şiddetli olduğunu seçin. Tarama sonuçları bu profile göre puanlanır.';

  @override
  String get crossTitle => '“İçerebilir” uyarılarını dahil et';

  @override
  String get crossBody =>
      'İz miktarları ve ortak üretim hattı uyarılarını risk puanına katar. Ağır alerjiler için önerilir.';

  @override
  String get severityMild => 'Hafif';

  @override
  String get severityModerate => 'Orta';

  @override
  String get severityAnaphylaxis => 'Anafilaksi';

  @override
  String get allergenPeanut => 'Yer fıstığı';

  @override
  String get allergenPeanutExamples => 'Yer fıstığı, fıstık yağı';

  @override
  String get allergenTreeNut => 'Sert kabuklu yemişler';

  @override
  String get allergenTreeNutExamples => 'Badem, fındık, ceviz, kaju';

  @override
  String get allergenMilk => 'Süt ve süt ürünleri';

  @override
  String get allergenMilkExamples => 'Süt, peynir, peynir altı suyu, laktoz';

  @override
  String get allergenEgg => 'Yumurta';

  @override
  String get allergenEggExamples => 'Yumurta, albümin, mayonez';

  @override
  String get allergenGluten => 'Gluten';

  @override
  String get allergenGlutenExamples => 'Buğday, arpa, çavdar, yulaf';

  @override
  String get allergenSoy => 'Soya';

  @override
  String get allergenSoyExamples => 'Soya, tofu, soya lesitini';

  @override
  String get allergenFish => 'Balık';

  @override
  String get allergenFishExamples => 'Somon, ton balığı, morina, hamsi';

  @override
  String get allergenShellfish => 'Kabuklu deniz ürünleri';

  @override
  String get allergenShellfishExamples => 'Karides, yengeç, midye, kalamar';

  @override
  String get allergenSesame => 'Susam';

  @override
  String get allergenSesameExamples => 'Susam, tahin';

  @override
  String get allergenCelery => 'Kereviz';

  @override
  String get allergenCeleryExamples => 'Kereviz, kereviz kökü';

  @override
  String get allergenMustard => 'Hardal';

  @override
  String get allergenMustardExamples => 'Hardal tohumu, hardal unu';

  @override
  String get allergenLupin => 'Acı bakla';

  @override
  String get allergenLupinExamples => 'Acı bakla unu ve tohumları';

  @override
  String get allergenSulphites => 'Sülfitler';

  @override
  String get allergenSulphitesExamples => 'Kükürt dioksit, E220 ile E228';

  @override
  String get allergenAdditives => 'Gıda katkı maddeleri';

  @override
  String get allergenAdditivesExamples =>
      'Bazı renklendiriciler, koruyucular, E621';

  @override
  String get scanTitle => 'Etiketi tara';

  @override
  String get scanTipsTitle => 'En iyi sonuç için';

  @override
  String get scanTip1 => 'İçindekiler listesinin tamamını kadraja sığdırın.';

  @override
  String get scanTip2 =>
      'İyi bir ışık kullanın ve ambalajdaki parlamayı önleyin.';

  @override
  String get scanTip3 =>
      'Varsa “içerebilir” veya “eser miktarda içerebilir” uyarısını da ekleyin.';

  @override
  String get scanTakePhoto => 'Fotoğraf çek';

  @override
  String get scanChooseGallery => 'Galeriden seç';

  @override
  String get scanReading => 'Etiket okunuyor';

  @override
  String get scanProfileRequiredTitle => 'Önce profilinizi oluşturun';

  @override
  String get scanProfileRequiredBody =>
      'Tepki verdiğiniz alerjenleri seçin. Profil olmadan tarama, etiketi karşılaştıracak bir şey bulamaz.';

  @override
  String get scanOpenProfile => 'Profili aç';

  @override
  String get failureNotConfigured =>
      'Tarama henüz kurulmadı. env/dev.json dosyasına API_BASE_URL ekleyip uygulamayı yeniden başlatın.';

  @override
  String get failureNetwork =>
      'Tarama hizmetine ulaşılamadı. İnternet bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get failureRateLimited =>
      'Kısa sürede çok fazla tarama yapıldı. Bir dakika bekleyip tekrar deneyin.';

  @override
  String get failureBusy =>
      'Tarama hizmeti şu an meşgul. Biraz sonra tekrar deneyin.';

  @override
  String get failureImageTooLarge =>
      'Bu fotoğraf çok büyük. Daha yakından veya daha düşük çözünürlükte tekrar çekin.';

  @override
  String get failureUnsupportedImage =>
      'Bu görüntü biçimi desteklenmiyor. JPEG, PNG veya WebP bir fotoğraf kullanın.';

  @override
  String get failureImageAccess =>
      'Kameraya veya fotoğraflara erişilemedi. Uygulama izinlerini kontrol edin.';

  @override
  String get failureUnreadable =>
      'Bu fotoğraftan bir içindekiler listesi okunamadı. Bu güvenli bir sonuç değildir. Listenin tamamının net ve iyi aydınlatılmış olduğundan emin olup tekrar deneyin.';

  @override
  String get failureServer =>
      'Etiket okunurken bir sorun oluştu. Tekrar deneyin.';

  @override
  String get failureEmptyProfile =>
      'Önce profilinizde en az bir alerjen seçin. Bu olmadan tarama size bir şey söyleyemez.';

  @override
  String get resultTitle => 'Tarama sonucu';

  @override
  String get riskNoneTitle => 'Profilinizdeki alerjenler tespit edilmedi';

  @override
  String get riskNoneSummary =>
      'Taranan metinde profilinizle eşleşen bir şey yok. Metin tanıma bazı şeyleri kaçırabilir, bu yüzden ambalajı da mutlaka kontrol edin.';

  @override
  String get riskTraceOnlyTitle => 'Profilinizdeki alerjenleri içerebilir';

  @override
  String get riskTraceOnlySummary =>
      'Etikette profilinizdeki alerjenler için “içerebilir” uyarıları var. Bu ayar kapalı olduğu için risk puanına katılmıyor.';

  @override
  String get riskCautionTitle => 'Dikkat';

  @override
  String get riskCautionSummary =>
      'Bu ürün profilinizdeki alerjenleri içeriyor.';

  @override
  String get riskDangerTitle => 'Yüksek risk';

  @override
  String get riskDangerSummary =>
      'Bu üründen uzak durun. Profilinizdeki alerjenleri içeriyor ve risk puanı yüksek.';

  @override
  String riskScoreWithValue(String score) {
    return 'Risk puanı $score';
  }

  @override
  String get riskScoreLabel => 'Risk puanı';

  @override
  String get breakdownTitle => 'Bu puan neden böyle';

  @override
  String get kindListed => 'Listelenen';

  @override
  String get kindDerived => 'Türev';

  @override
  String get kindMayContain => 'İçerebilir';

  @override
  String crossFactorNote(String factor) {
    return 'Etikette “içerebilir” uyarısı bulunduğu için listelenen içerikler $factor ile çarpılır.';
  }

  @override
  String get traceWarningsTitle => 'Eser miktar uyarıları, puana katılmaz';

  @override
  String get traceWarningsSubtitle =>
      'Bu alerjenler profilinizde var ancak yalnızca bir “içerebilir” uyarısında geçiyor. Hesaba katmak için profilinizde “içerebilir” uyarıları seçeneğini açın.';

  @override
  String get otherAllergensTitle => 'Ayrıca bulundu, profilinizde yok';

  @override
  String get otherAllergensSubtitle => 'Bunlar puanı etkilemez.';

  @override
  String get recognizedTitle => 'Etiketten okunanlar';

  @override
  String get recognizedSubtitle =>
      'Bunu ambalajla karşılaştırın. Metin tanıma hata yapabilir.';

  @override
  String get recognizedIngredients => 'İçindekiler';

  @override
  String get recognizedMayContain => 'İçerebilir';

  @override
  String get scanAnother => 'Başka bir etiketi tara';

  @override
  String get backToHistory => 'Geçmişe dön';

  @override
  String get historyTitle => 'Geçmiş';

  @override
  String get historyEmpty => 'Geçmiş taramalarınız burada görünecek.';

  @override
  String get historySearchHint => 'İçerik veya alerjen ara';

  @override
  String get historyNoMatches => 'Aramanızla eşleşen tarama yok.';

  @override
  String get historyClearTooltip => 'Geçmişi temizle';

  @override
  String get historyClearTitle => 'Geçmiş temizlensin mi?';

  @override
  String get historyClearBody => 'Kayıtlı tüm taramalar silinecek.';

  @override
  String get historyDeleted => 'Tarama silindi';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get languageSystem => 'Sistem varsayılanı';

  @override
  String get settingsData => 'Veriler';

  @override
  String get settingsClearHistory => 'Tarama geçmişini temizle';

  @override
  String get settingsAbout => 'Hakkında';

  @override
  String get settingsAboutNote =>
      'Alerjen eşleştirme, uygulama hangi dilde gösterilirse gösterilsin İngilizce, Azerbaycan Türkçesi, Türkçe ve Rusça etiketlerde çalışır.';
}
