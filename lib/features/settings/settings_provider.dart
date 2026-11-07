import 'package:allergy_app/features/settings/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => throw UnimplementedError('settingsRepositoryProvider not overridden'),
);

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);

class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() => ref.read(settingsRepositoryProvider).loadLocale();

  Future<void> select(Locale? locale) async {
    state = locale;
    await ref.read(settingsRepositoryProvider).saveLocale(locale);
  }
}