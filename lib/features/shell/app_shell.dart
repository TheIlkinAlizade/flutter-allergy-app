import 'package:allergy_app/features/profile/profile_page.dart';
import 'package:allergy_app/shared/widgets/placeholder_page.dart';
import 'package:flutter/material.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  static const _pages = <Widget>[
    PlaceholderPage(
      title: 'Scan',
      icon: Icons.document_scanner_outlined,
      message: 'Label scanning arrives in the next step.',
    ),
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

  int _index = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
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