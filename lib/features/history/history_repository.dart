import 'package:allergy_app/data/models/scan_report.dart';
import 'package:allergy_app/data/scan_report_codec.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryRepository {
  HistoryRepository(this._box);

  static const boxName = 'history';
  static const maxEntries = 200;

  final Box<dynamic> _box;

  List<ScanReport> loadAll() {
    final reports = <ScanReport>[];
    for (final raw in _box.values) {
      final report = raw is Map ? scanReportFromJson(raw) : null;
      if (report == null) {
        debugPrint('Skipped an unreadable history entry');
        continue;
      }
      reports.add(report);
    }
    reports.sort((a, b) => b.scannedAt.compareTo(a.scannedAt));
    return reports;
  }

  Future<void> add(ScanReport report) async {
    await _box.put(_keyFor(report), scanReportToJson(report));
    await _trimToLimit();
  }

  Future<void> remove(ScanReport report) => _box.delete(_keyFor(report));

  Future<void> clear() async {
    await _box.clear();
  }

  String _keyFor(ScanReport report) {
    return report.scannedAt.microsecondsSinceEpoch.toString();
  }

  Future<void> _trimToLimit() async {
    final overflow = _box.length - maxEntries;
    if (overflow <= 0) return;
    final keys = _box.keys.map((key) => key.toString()).toList()
      ..sort((a, b) => (int.tryParse(a) ?? 0).compareTo(int.tryParse(b) ?? 0));
    await _box.deleteAll(keys.take(overflow));
  }
}

Future<Box<dynamic>> openHistoryBox() async {
  try {
    return await Hive.openBox<dynamic>(HistoryRepository.boxName);
  } catch (_) {
    await Hive.deleteBoxFromDisk(HistoryRepository.boxName);
    return Hive.openBox<dynamic>(HistoryRepository.boxName);
  }
}