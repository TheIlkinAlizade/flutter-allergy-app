import 'package:allergy_app/config/app_config.dart';
import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/features/shell/app_shell.dart';
import 'package:flutter/material.dart';

class AllergyApp extends StatelessWidget {
  const AllergyApp({super.key});

  static const maxContentWidth = 600.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
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
}