import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/core/text_normalizer.dart';
import 'package:allergy_app/data/models/scan_report.dart';
import 'package:allergy_app/features/history/clear_history_dialog.dart';
import 'package:allergy_app/features/history/history_provider.dart';
import 'package:allergy_app/features/profile/profile_labels.dart';
import 'package:allergy_app/features/result/result_page.dart';
import 'package:allergy_app/l10n/app_localizations.dart';
import 'package:allergy_app/shared/l10n_context.dart';
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

  String _searchText(ScanReport report, AppLocalizations l10n) {
    return [
      ...report.extraction.ingredients,
      ...report.extraction.traces,
      for (final item in report.risk.contributions)
        item.match.category.label(l10n),
      for (final item in report.risk.traceWarnings)
        item.match.category.label(l10n),
      for (final category in report.otherAllergens) category.label(l10n),
    ].join(' ');
  }

  List<ScanReport> _filter(List<ScanReport> reports, AppLocalizations l10n) {
    final query = TextNormalizer.normalize(_query);
    if (query.isEmpty) return reports;
    return reports
        .where(
          (report) => TextNormalizer.normalize(_searchText(report, l10n))
              .contains(query),
        )
        .toList();
  }

  void _delete(ScanReport report) {
    final l10n = context.l10n;
    final notifier = ref.read(historyProvider.notifier);
    notifier.remove(report);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.historyDeleted),
          action: SnackBarAction(
            label: l10n.commonUndo,
            onPressed: () => notifier.add(report),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final reports = ref.watch(historyProvider);
    final filtered = _filter(reports, l10n);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.historyTitle),
        actions: [
          if (reports.isNotEmpty)
            IconButton(
              tooltip: l10n.historyClearTooltip,
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: () => confirmAndClearHistory(context, ref),
            ),
        ],
      ),
      body: reports.isEmpty
          ? _Message(icon: Icons.history, text: l10n.historyEmpty)
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: l10n.historySearchHint,
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
                      ? _Message(
                          icon: Icons.search_off,
                          text: l10n.historyNoMatches,
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
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final style = RiskBannerStyle.of(report.risk, l10n);
    final localeName = Localizations.localeOf(context).toString();
    final flagged = {
      for (final item in report.risk.contributions)
        item.match.category.label(l10n),
      for (final item in report.risk.traceWarnings)
        item.match.category.label(l10n),
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
                      DateFormat.yMMMd(localeName)
                          .add_Hm()
                          .format(report.scannedAt),
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