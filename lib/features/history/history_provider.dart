import 'package:allergy_app/data/models/scan_report.dart';
import 'package:allergy_app/features/history/history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyRepositoryProvider = Provider<HistoryRepository>(
  (ref) => throw UnimplementedError('historyRepositoryProvider not overridden'),
);

final historyProvider = NotifierProvider<HistoryNotifier, List<ScanReport>>(
  HistoryNotifier.new,
);

class HistoryNotifier extends Notifier<List<ScanReport>> {
  @override
  List<ScanReport> build() => ref.read(historyRepositoryProvider).loadAll();

  Future<void> add(ScanReport report) async {
    final repository = ref.read(historyRepositoryProvider);
    state = [
      report,
      ...state.where((item) => item.scannedAt != report.scannedAt),
    ]..sort((a, b) => b.scannedAt.compareTo(a.scannedAt));
    await repository.add(report);
    state = repository.loadAll();
  }

  Future<void> remove(ScanReport report) async {
    state = state.where((item) => item.scannedAt != report.scannedAt).toList();
    await ref.read(historyRepositoryProvider).remove(report);
  }

  Future<void> clear() async {
    state = const [];
    await ref.read(historyRepositoryProvider).clear();
  }
}