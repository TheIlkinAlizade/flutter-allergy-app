import 'package:allergy_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsRepository {
  SettingsRepository(this._box);

  static const boxName = 'settings';
  static const _languageKey = 'language_code';

  final Box<dynamic> _box;

  Locale? loadLocale() {
    final code = _box.get(_languageKey);
    if (code is! String) return null;
    for (final locale in AppLocalizations.supportedLocales) {
      if (locale.languageCode == code) return locale;
    }
    return null;
  }

  Future<void> saveLocale(Locale? locale) {
    if (locale == null) return _box.delete(_languageKey);
    return _box.put(_languageKey, locale.languageCode);
  }
}