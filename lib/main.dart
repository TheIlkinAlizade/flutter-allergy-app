import 'package:allergy_app/app.dart';
import 'package:allergy_app/features/profile/profile_provider.dart';
import 'package:allergy_app/features/profile/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final box = await openProfileBox();

  runApp(
    ProviderScope(
      overrides: [
        profileRepositoryProvider.overrideWithValue(ProfileRepository(box)),
      ],
      child: const AllergyApp(),
    ),
  );
}