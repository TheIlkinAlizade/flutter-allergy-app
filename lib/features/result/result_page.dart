import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/core/risk_calculator.dart';
import 'package:allergy_app/core/risk_constants.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/ingredient_match.dart';
import 'package:allergy_app/data/models/scan_extraction.dart';
import 'package:allergy_app/data/models/scan_report.dart';
import 'package:allergy_app/features/profile/profile_labels.dart';
import 'package:allergy_app/l10n/app_localizations.dart';
import 'package:allergy_app/shared/l10n_context.dart';
import 'package:allergy_app/shared/widgets/disclaimer_card.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    required this.report,
    this.fromHistory = false,
    super.key,
  });

  final ScanReport report;
  final bool fromHistory;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final risk = report.risk;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.resultTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          _RiskBanner(risk: risk),
          if (risk.contributions.isNotEmpty) ...[
            const SizedBox(height: 16),
            _BreakdownCard(risk: risk),
          ],
          if (risk.traceWarnings.isNotEmpty) ...[
            const SizedBox(height: 16),
            _TraceWarningsCard(warnings: risk.traceWarnings),
          ],
          if (report.otherAllergens.isNotEmpty) ...[
            const SizedBox(height: 16),
            _OtherAllergensCard(categories: report.otherAllergens),
          ],
          const SizedBox(height: 16),
          _RecognizedTextCard(extraction: report.extraction),
          const SizedBox(height: 16),
          const DisclaimerCard(),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(fromHistory ? l10n.backToHistory : l10n.scanAnother),
          ),
        ],
      ),
    );
  }
}

class RiskBannerStyle {
  const RiskBannerStyle({
    required this.color,
    required this.icon,
    required this.title,
    required this.summary,
  });

  factory RiskBannerStyle.of(RiskResult risk, AppLocalizations l10n) {
    if (risk.level == RiskLevel.safe && risk.traceWarnings.isNotEmpty) {
      return RiskBannerStyle(
        color: AppTheme.caution,
        icon: Icons.warning_amber_rounded,
        title: l10n.riskTraceOnlyTitle,
        summary: l10n.riskTraceOnlySummary,
      );
    }
    return switch (risk.level) {
      RiskLevel.safe => RiskBannerStyle(
          color: AppTheme.safe,
          icon: Icons.check_circle_outline,
          title: l10n.riskNoneTitle,
          summary: l10n.riskNoneSummary,
        ),
      RiskLevel.caution => RiskBannerStyle(
          color: AppTheme.caution,
          icon: Icons.warning_amber_rounded,
          title: l10n.riskCautionTitle,
          summary: l10n.riskCautionSummary,
        ),
      RiskLevel.danger => RiskBannerStyle(
          color: AppTheme.danger,
          icon: Icons.dangerous_outlined,
          title: l10n.riskDangerTitle,
          summary: l10n.riskDangerSummary,
        ),
    };
  }

  final Color color;
  final IconData icon;
  final String title;
  final String summary;
}

class _RiskBanner extends StatelessWidget {
  const _RiskBanner({required this.risk});

  final RiskResult risk;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final style = RiskBannerStyle.of(risk, l10n);
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: style.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: style.color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(style.icon, color: style.color, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  style.title,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: style.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            style.summary,
            style: textTheme.bodyMedium?.copyWith(height: 1.4),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.riskScoreWithValue(risk.score.toStringAsFixed(1)),
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final note = subtitle;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            if (note != null) ...[
              const SizedBox(height: 4),
              Text(
                note,
                style: textTheme.bodySmall?.copyWith(
                  color: AppTheme.textMuted,
                  height: 1.4,
                ),
              ),
            ],
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

String _kindLabel(IngredientMatch match, AppLocalizations l10n) {
  if (match.isTrace) return l10n.kindMayContain;
  return match.confidence == MatchConfidence.direct
      ? l10n.kindListed
      : l10n.kindDerived;
}

class _BreakdownCard extends StatelessWidget {
  const _BreakdownCard({required this.risk});

  final RiskResult risk;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final rows = [...risk.contributions]
      ..sort((a, b) => b.value.compareTo(a.value));

    return _SectionCard(
      title: l10n.breakdownTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final contribution in rows)
            _ContributionRow(contribution: contribution),
          if (risk.crossContaminationApplied) ...[
            const SizedBox(height: 8),
            Text(
              l10n.crossFactorNote(
                '${1 + RiskConstants.crossContaminationFactor}',
              ),
              style: textTheme.bodySmall?.copyWith(
                color: AppTheme.textMuted,
                height: 1.4,
              ),
            ),
          ],
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.riskScoreLabel,
                  style: textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                risk.score.toStringAsFixed(1),
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContributionRow extends StatelessWidget {
  const _ContributionRow({required this.contribution});

  final RiskContribution contribution;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final match = contribution.match;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: contribution.severity.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  match.category.label(l10n),
                  style: textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  '${_kindLabel(match, l10n)} · "${match.ingredient}" · '
                  '${contribution.severity.label(l10n)}',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppTheme.textMuted,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '+${contribution.value.toStringAsFixed(1)}',
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _TraceWarningsCard extends StatelessWidget {
  const _TraceWarningsCard({required this.warnings});

  final List<RiskContribution> warnings;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return _SectionCard(
      title: l10n.traceWarningsTitle,
      subtitle: l10n.traceWarningsSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final warning in warnings)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                '${warning.match.category.label(l10n)} · '
                '"${warning.match.ingredient}" · '
                '${warning.severity.label(l10n)}',
                style: textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}

class _OtherAllergensCard extends StatelessWidget {
  const _OtherAllergensCard({required this.categories});

  final List<AllergenCategory> categories;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _SectionCard(
      title: l10n.otherAllergensTitle,
      subtitle: l10n.otherAllergensSubtitle,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final category in categories)
            Chip(
              label: Text(category.label(l10n)),
              backgroundColor: AppTheme.background,
              side: const BorderSide(color: AppTheme.border),
            ),
        ],
      ),
    );
  }
}

class _RecognizedTextCard extends StatelessWidget {
  const _RecognizedTextCard({required this.extraction});

  final ScanExtraction extraction;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return _SectionCard(
      title: l10n.recognizedTitle,
      subtitle: l10n.recognizedSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (extraction.ingredients.isNotEmpty) ...[
            Text(
              l10n.recognizedIngredients,
              style: textTheme.bodySmall?.copyWith(
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            SelectableText(
              extraction.ingredients.join(', '),
              style: textTheme.bodyMedium?.copyWith(height: 1.4),
            ),
          ],
          if (extraction.traces.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              l10n.recognizedMayContain,
              style: textTheme.bodySmall?.copyWith(
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            SelectableText(
              extraction.traces.join(', '),
              style: textTheme.bodyMedium?.copyWith(height: 1.4),
            ),
          ],
        ],
      ),
    );
  }
}