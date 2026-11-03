import 'package:allergy_app/config/app_config.dart';
import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/features/shell/app_shell.dart';
import 'package:flutter/material.dart';

class AllergyApp extends StatelessWidget {
  const AllergyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const AppShell(),
    );
  }
}