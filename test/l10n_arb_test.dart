import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Map<String, String> loadMessages(File file) {
  final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return {
    for (final entry in json.entries)
      if (!entry.key.startsWith('@') && entry.value is String)
        entry.key: entry.value as String,
  };
}

Set<String> placeholdersOf(String message) {
  return RegExp(r'\{(\w+)\}')
      .allMatches(message)
      .map((match) => match.group(1)!)
      .toSet();
}

void main() {
  final template = loadMessages(File('lib/l10n/app_en.arb'));
  final translations = Directory('lib/l10n')
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.arb'))
      .where((file) => !file.path.endsWith('app_en.arb'))
      .toList();

  test('at least one translation exists', () {
    expect(translations, isNotEmpty);
  });

  for (final file in translations) {
    final name = file.uri.pathSegments.last;
    final messages = loadMessages(file);

    test('$name has exactly the template keys', () {
      expect(messages.keys.toSet(), template.keys.toSet());
    });

    test('$name keeps the template placeholders', () {
      for (final entry in template.entries) {
        final translated = messages[entry.key];
        if (translated == null) continue;
        expect(
          placeholdersOf(translated),
          placeholdersOf(entry.value),
          reason: '${entry.key} in $name',
        );
      }
    });

    test('$name has no empty values', () {
      for (final entry in messages.entries) {
        expect(entry.value.trim(), isNotEmpty, reason: entry.key);
      }
    });
  }
}