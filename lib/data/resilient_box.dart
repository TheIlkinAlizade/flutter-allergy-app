import 'package:hive_flutter/hive_flutter.dart';

Future<Box<dynamic>> openResilientBox(String name) async {
  try {
    return await Hive.openBox<dynamic>(name);
  } catch (_) {
    await Hive.deleteBoxFromDisk(name);
    return Hive.openBox<dynamic>(name);
  }
}