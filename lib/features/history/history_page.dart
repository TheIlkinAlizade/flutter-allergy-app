import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/core/text_normalizer.dart';
import 'package:allergy_app/data/models/scan_report.dart';
import 'package:allergy_app/features/history/history_provider.dart';
import 'package:allergy_app/features/profile/profile_labels.dart';
import 'package:allergy_app/features/result/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _searchText(ScanReport report) {
    return [
      ...report.extraction.ingredients,
      ...report.extraction.traces,
      for (final item in report.risk.contributions) item.match.category.label,
      for (final item in report.risk.traceWarnings) item.match.category.label,
      for (final category in report.otherAllergens) category.label,
    ].join(' ');
  }

  List<ScanReport> _filter(List<ScanReport> reports) {
    final query = TextNormalizer.normalize(_query);
    if (query.isEmpty) return reports;
    return reports
        .where(
          (report) =>
              TextNormalizer.normalize(_searchText(report)).contains(query),
        )
        .toList();
  }

  Future<void> _confirmClear() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear history?'),
        content: const Text('All saved scans will be deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(historyProvider.notifier).clear();
    }
  }

  void _delete(ScanReport report) {
    final notifier = ref.read(historyProvider.notifier);
    notifier.remove(report);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Scan deleted'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => notifier.add(report),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final reports = ref.watch(historyProvider);
    final filtered = _filter(reports);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          if (reports.isNotEmpty)
            IconButton(
              tooltip: 'Clear history',
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: _confirmClear,
            ),
        ],
      ),
      body: reports.isEmpty
          ? const _Message(
              icon: Icons.history,
              text: 'Your past scans will appear here.',
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: 'Search ingredients or allergens',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _query.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                            ),
                      filled: true,
                      fillColor: AppTheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppTheme.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppTheme.border),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: filtered.isEmpty
                      ? const _Message(
                          icon: Icons.search_off,
                          text: 'No scans match your search.',
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                          itemCount: filtered.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final report = filtered[index];
                            return Dismissible(
                              key: ValueKey(
                                report.scannedAt.microsecondsSinceEpoch,
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) => _delete(report),
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: AppTheme.danger,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                              ),
                              child: _HistoryTile(
                                report: report,
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => ResultPage(
                                      report: report,
                                      fromHistory: true,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.report, required this.onTap});

  final ScanReport report;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final style = RiskBannerStyle.of(report.risk);
    final flagged = {
      for (final item in report.risk.contributions) item.match.category.label,
      for (final item in report.risk.traceWarnings) item.match.category.label,
    }.join(', ');

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: style.color.withValues(alpha: 0.12),
                child: Icon(style.icon, color: style.color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      style.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateFormat.yMMMd().add_Hm().format(report.scannedAt),
                      style: textTheme.bodySmall
                          ?.copyWith(color: AppTheme.textMuted),
                    ),
                    if (flagged.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        flagged,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                report.risk.score.toStringAsFixed(1),
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: AppTheme.textMuted),
            const SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppTheme.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}