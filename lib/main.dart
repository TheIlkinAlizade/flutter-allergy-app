import 'package:allergy_app/app.dart';
import 'package:allergy_app/data/resilient_box.dart';
import 'package:allergy_app/features/history/history_provider.dart';
import 'package:allergy_app/features/history/history_repository.dart';
import 'package:allergy_app/features/profile/profile_provider.dart';
import 'package:allergy_app/features/profile/profile_repository.dart';
import 'package:allergy_app/features/settings/settings_provider.dart';
import 'package:allergy_app/features/settings/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final profileBox = await openResilientBox(ProfileRepository.boxName);
  final historyBox = await openResilientBox(HistoryRepository.boxName);
  final settingsBox = await openResilientBox(SettingsRepository.boxName);

  runApp(
    ProviderScope(
      overrides: [
        profileRepositoryProvider
            .overrideWithValue(ProfileRepository(profileBox)),
        historyRepositoryProvider
            .overrideWithValue(HistoryRepository(historyBox)),
        settingsRepositoryProvider
            .overrideWithValue(SettingsRepository(settingsBox)),
      ],
      child: const AllergyApp(),
    ),
  );
}