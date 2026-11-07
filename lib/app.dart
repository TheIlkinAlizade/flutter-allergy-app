import 'package:allergy_app/config/app_config.dart';
import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/features/settings/settings_provider.dart';
import 'package:allergy_app/features/shell/app_shell.dart';
import 'package:allergy_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllergyApp extends ConsumerWidget {
  const AllergyApp({super.key});

  static const maxContentWidth = 600.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      onGenerateTitle: (_) => AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: _resolveLocale,
      builder: (context, child) {
        return ColoredBox(
          color: AppTheme.background,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxContentWidth),
              child: child,
            ),
          ),
        );
      },
      home: const AppShell(),
    );
  }

  static Locale _resolveLocale(Locale? locale, Iterable<Locale> supported) {
    if (locale != null) {
      for (final candidate in supported) {
        if (candidate.languageCode == locale.languageCode) return candidate;
      }
    }
    return const Locale('en');
  }
}