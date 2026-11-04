import 'package:allergy_app/features/profile/profile_page.dart';
import 'package:allergy_app/features/scan/scan_page.dart';
import 'package:allergy_app/features/shell/app_tab.dart';
import 'package:allergy_app/shared/widgets/placeholder_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  static const _pages = <Widget>[
    ScanPage(),
    PlaceholderPage(
      title: 'History',
      icon: Icons.history,
      message: 'Your past scans will appear here.',
    ),
    ProfilePage(),
    PlaceholderPage(
      title: 'Settings',
      icon: Icons.settings_outlined,
      message: 'Language and app settings will appear here.',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(selectedTabProvider);

    return Scaffold(
      body: IndexedStack(index: tab.index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab.index,
        onDestinationSelected: (value) => ref
            .read(selectedTabProvider.notifier)
            .select(AppTab.values[value]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.document_scanner_outlined),
            selectedIcon: Icon(Icons.document_scanner),
            label: 'Scan',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.shield_outlined),
            selectedIcon: Icon(Icons.shield),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}