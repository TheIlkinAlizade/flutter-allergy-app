import 'dart:convert';

import 'package:allergy_app/core/allergen_dictionary.dart';
import 'package:flutter/services.dart';

Future<AllergenDictionary> loadAllergenDictionary() async {
  final raw = await rootBundle.loadString('assets/data/allergen_dictionary.json');
  final decoded = jsonDecode(raw);
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('Dictionary root must be an object');
  }
  return AllergenDictionary.fromJson(decoded);
}