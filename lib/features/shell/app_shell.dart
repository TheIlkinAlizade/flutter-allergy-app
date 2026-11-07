import 'package:allergy_app/features/history/history_page.dart';
import 'package:allergy_app/features/profile/profile_page.dart';
import 'package:allergy_app/features/scan/scan_page.dart';
import 'package:allergy_app/features/settings/settings_page.dart';
import 'package:allergy_app/features/shell/app_tab.dart';
import 'package:allergy_app/shared/l10n_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  static const _pages = <Widget>[
    ScanPage(),
    HistoryPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final tab = ref.watch(selectedTabProvider);

    return Scaffold(
      body: IndexedStack(index: tab.index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab.index,
        onDestinationSelected: (value) => ref
            .read(selectedTabProvider.notifier)
            .select(AppTab.values[value]),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.document_scanner_outlined),
            selectedIcon: const Icon(Icons.document_scanner),
            label: l10n.navScan,
          ),
          NavigationDestination(
            icon: const Icon(Icons.history),
            label: l10n.navHistory,
          ),
          NavigationDestination(
            icon: const Icon(Icons.shield_outlined),
            selectedIcon: const Icon(Icons.shield),
            label: l10n.navProfile,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}