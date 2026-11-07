// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTagline => 'Проверка риска пищевых аллергенов';

  @override
  String get navScan => 'Скан';

  @override
  String get navHistory => 'История';

  @override
  String get navProfile => 'Профиль';

  @override
  String get navSettings => 'Настройки';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonUndo => 'Отменить';

  @override
  String get commonClear => 'Очистить';

  @override
  String get disclaimer =>
      'Приложение помогает читать состав на этикетках, но не заменяет консультацию врача. Всегда проверяйте упаковку и следуйте рекомендациям своего врача.';

  @override
  String get profileTitle => 'Профиль аллергии';

  @override
  String get profileIntro =>
      'Выберите аллергены, на которые вы реагируете, и насколько тяжёлая реакция. Результаты сканирования оцениваются по этому профилю.';

  @override
  String get crossTitle => 'Учитывать предупреждения «может содержать»';

  @override
  String get crossBody =>
      'Добавляет в оценку риска следы и предупреждения об общей производственной линии. Рекомендуется при тяжёлой аллергии.';

  @override
  String get severityMild => 'Лёгкая';

  @override
  String get severityModerate => 'Средняя';

  @override
  String get severityAnaphylaxis => 'Анафилаксия';

  @override
  String get allergenPeanut => 'Арахис';

  @override
  String get allergenPeanutExamples => 'Арахис, арахисовое масло';

  @override
  String get allergenTreeNut => 'Древесные орехи';

  @override
  String get allergenTreeNutExamples => 'Миндаль, фундук, грецкий орех, кешью';

  @override
  String get allergenMilk => 'Молоко и молочные продукты';

  @override
  String get allergenMilkExamples => 'Молоко, сыр, сыворотка, лактоза';

  @override
  String get allergenEgg => 'Яйца';

  @override
  String get allergenEggExamples => 'Яйцо, альбумин, майонез';

  @override
  String get allergenGluten => 'Глютен';

  @override
  String get allergenGlutenExamples => 'Пшеница, ячмень, рожь, овёс';

  @override
  String get allergenSoy => 'Соя';

  @override
  String get allergenSoyExamples => 'Соя, тофу, соевый лецитин';

  @override
  String get allergenFish => 'Рыба';

  @override
  String get allergenFishExamples => 'Лосось, тунец, треска, анчоусы';

  @override
  String get allergenShellfish => 'Ракообразные и моллюски';

  @override
  String get allergenShellfishExamples => 'Креветки, краб, мидии, кальмар';

  @override
  String get allergenSesame => 'Кунжут';

  @override
  String get allergenSesameExamples => 'Семена кунжута, тахини';

  @override
  String get allergenCelery => 'Сельдерей';

  @override
  String get allergenCeleryExamples => 'Сельдерей, корень сельдерея';

  @override
  String get allergenMustard => 'Горчица';

  @override
  String get allergenMustardExamples => 'Семена горчицы, горчичная мука';

  @override
  String get allergenLupin => 'Люпин';

  @override
  String get allergenLupinExamples => 'Люпиновая мука и семена';

  @override
  String get allergenSulphites => 'Сульфиты';

  @override
  String get allergenSulphitesExamples => 'Диоксид серы, E220–E228';

  @override
  String get allergenAdditives => 'Пищевые добавки';

  @override
  String get allergenAdditivesExamples =>
      'Некоторые красители, консерванты, E621';

  @override
  String get scanTitle => 'Сканировать этикетку';

  @override
  String get scanTipsTitle => 'Для лучшего результата';

  @override
  String get scanTip1 => 'Поместите в кадр весь список состава.';

  @override
  String get scanTip2 =>
      'Используйте хорошее освещение и избегайте бликов на упаковке.';

  @override
  String get scanTip3 =>
      'Захватите предупреждение «может содержать» или «следы», если оно есть.';

  @override
  String get scanTakePhoto => 'Сделать фото';

  @override
  String get scanChooseGallery => 'Выбрать из галереи';

  @override
  String get scanReading => 'Чтение этикетки';

  @override
  String get scanProfileRequiredTitle => 'Сначала настройте профиль';

  @override
  String get scanProfileRequiredBody =>
      'Выберите аллергены, на которые вы реагируете. Без профиля сканированию не с чем сравнивать состав.';

  @override
  String get scanOpenProfile => 'Открыть профиль';

  @override
  String get failureNotConfigured =>
      'Сканирование ещё не настроено. Добавьте API_BASE_URL в env/dev.json и перезапустите приложение.';

  @override
  String get failureNetwork =>
      'Не удалось связаться со службой сканирования. Проверьте подключение к интернету и повторите попытку.';

  @override
  String get failureRateLimited =>
      'Слишком много сканирований за короткое время. Подождите минуту и повторите попытку.';

  @override
  String get failureBusy =>
      'Служба сканирования сейчас занята. Повторите попытку чуть позже.';

  @override
  String get failureImageTooLarge =>
      'Это фото слишком большое. Сделайте снимок ближе или в меньшем разрешении.';

  @override
  String get failureUnsupportedImage =>
      'Этот формат изображения не поддерживается. Используйте фото в JPEG, PNG или WebP.';

  @override
  String get failureImageAccess =>
      'Не удалось открыть камеру или фотографии. Проверьте разрешения приложения.';

  @override
  String get failureUnreadable =>
      'На этом фото не удалось прочитать список состава. Это не означает, что продукт безопасен. Убедитесь, что весь список в фокусе и хорошо освещён, и повторите попытку.';

  @override
  String get failureServer =>
      'При чтении этикетки что-то пошло не так. Повторите попытку.';

  @override
  String get failureEmptyProfile =>
      'Сначала выберите в профиле хотя бы один аллерген. Без этого сканирование ничего не покажет.';

  @override
  String get resultTitle => 'Результат сканирования';

  @override
  String get riskNoneTitle => 'Аллергены из вашего профиля не обнаружены';

  @override
  String get riskNoneSummary =>
      'В отсканированном тексте нет совпадений с вашим профилем. Распознавание текста может что-то пропустить, поэтому всегда проверяйте и упаковку.';

  @override
  String get riskTraceOnlyTitle =>
      'Может содержать аллергены из вашего профиля';

  @override
  String get riskTraceOnlySummary =>
      'На этикетке есть предупреждения «может содержать» об аллергенах из вашего профиля. В оценку риска они не входят, потому что эта настройка выключена.';

  @override
  String get riskCautionTitle => 'Осторожно';

  @override
  String get riskCautionSummary =>
      'Этот продукт содержит аллергены из вашего профиля.';

  @override
  String get riskDangerTitle => 'Высокий риск';

  @override
  String get riskDangerSummary =>
      'Не употребляйте этот продукт. Он содержит аллергены из вашего профиля, оценка риска высокая.';

  @override
  String riskScoreWithValue(String score) {
    return 'Оценка риска $score';
  }

  @override
  String get riskScoreLabel => 'Оценка риска';

  @override
  String get breakdownTitle => 'Из чего складывается оценка';

  @override
  String get kindListed => 'В составе';

  @override
  String get kindDerived => 'Производное';

  @override
  String get kindMayContain => 'Может содержать';

  @override
  String crossFactorNote(String factor) {
    return 'Ингредиенты из состава умножаются на $factor, потому что на этикетке есть предупреждение «может содержать».';
  }

  @override
  String get traceWarningsTitle =>
      'Предупреждения о следах, не входят в оценку';

  @override
  String get traceWarningsSubtitle =>
      'Эти аллергены есть в вашем профиле, но упомянуты только в предупреждении «может содержать». Чтобы учитывать их, включите в профиле параметр предупреждений «может содержать».';

  @override
  String get otherAllergensTitle => 'Также найдено, нет в вашем профиле';

  @override
  String get otherAllergensSubtitle => 'Они не влияют на оценку.';

  @override
  String get recognizedTitle => 'Что прочитано с этикетки';

  @override
  String get recognizedSubtitle =>
      'Сверьте это с упаковкой. Распознавание текста может ошибаться.';

  @override
  String get recognizedIngredients => 'Состав';

  @override
  String get recognizedMayContain => 'Может содержать';

  @override
  String get scanAnother => 'Сканировать другую этикетку';

  @override
  String get backToHistory => 'Назад к истории';

  @override
  String get historyTitle => 'История';

  @override
  String get historyEmpty => 'Здесь появятся ваши прошлые сканирования.';

  @override
  String get historySearchHint => 'Поиск по составу или аллергенам';

  @override
  String get historyNoMatches => 'Нет сканирований, подходящих под запрос.';

  @override
  String get historyClearTooltip => 'Очистить историю';

  @override
  String get historyClearTitle => 'Очистить историю?';

  @override
  String get historyClearBody => 'Все сохранённые сканирования будут удалены.';

  @override
  String get historyDeleted => 'Сканирование удалено';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get languageSystem => 'Как в системе';

  @override
  String get settingsData => 'Данные';

  @override
  String get settingsClearHistory => 'Очистить историю сканирований';

  @override
  String get settingsAbout => 'О приложении';

  @override
  String get settingsAboutNote =>
      'Распознавание аллергенов работает с этикетками на английском, азербайджанском, турецком и русском языках, независимо от языка интерфейса.';
}
