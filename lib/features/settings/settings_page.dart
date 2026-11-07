import 'package:allergy_app/config/app_config.dart';
import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/features/history/clear_history_dialog.dart';
import 'package:allergy_app/features/history/history_provider.dart';
import 'package:allergy_app/features/settings/settings_provider.dart';
import 'package:allergy_app/shared/l10n_context.dart';
import 'package:allergy_app/shared/widgets/disclaimer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _languages = <({Locale locale, String name})>[
  (locale: Locale('en'), name: 'English'),
  (locale: Locale('az'), name: 'Azərbaycanca'),
  (locale: Locale('tr'), name: 'Türkçe'),
  (locale: Locale('ru'), name: 'Русский'),
];

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final current = ref.watch(localeProvider);
    final notifier = ref.read(localeProvider.notifier);
    final hasHistory = ref.watch(historyProvider).isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          _SectionHeader(l10n.settingsLanguage),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                _LanguageTile(
                  label: l10n.languageSystem,
                  selected: current == null,
                  onTap: () => notifier.select(null),
                ),
                for (final option in _languages) ...[
                  const Divider(height: 1),
                  _LanguageTile(
                    label: option.name,
                    selected:
                        current?.languageCode == option.locale.languageCode,
                    onTap: () => notifier.select(option.locale),
                  ),
                ],
              ],
            ),
          ),
          _SectionHeader(l10n.settingsData),
          Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              enabled: hasHistory,
              leading: Icon(
                Icons.delete_outline,
                color: hasHistory ? AppTheme.danger : AppTheme.textMuted,
              ),
              title: Text(l10n.settingsClearHistory),
              onTap: () => confirmAndClearHistory(context, ref),
            ),
          ),
          _SectionHeader(l10n.settingsAbout),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConfig.appName,
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.appTagline,
                    style: textTheme.bodySmall
                        ?.copyWith(color: AppTheme.textMuted),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.settingsAboutNote,
                    style: textTheme.bodyMedium?.copyWith(height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const DisclaimerCard(),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.textMuted,
            ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing:
          selected ? const Icon(Icons.check, color: AppTheme.primary) : null,
      onTap: onTap,
    );
  }
}