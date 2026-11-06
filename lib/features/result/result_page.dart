import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/core/risk_calculator.dart';
import 'package:allergy_app/core/risk_constants.dart';
import 'package:allergy_app/data/models/ingredient_match.dart';
import 'package:allergy_app/data/models/scan_extraction.dart';
import 'package:allergy_app/data/models/scan_report.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/features/profile/profile_labels.dart';
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
    final risk = report.risk;
    return Scaffold(
      appBar: AppBar(title: const Text('Scan result')),
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
            child: Text(fromHistory ? 'Back to history' : 'Scan another label'),
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

  factory RiskBannerStyle.of(RiskResult risk) {
    if (risk.level == RiskLevel.safe && risk.traceWarnings.isNotEmpty) {
      return const RiskBannerStyle(
        color: AppTheme.caution,
        icon: Icons.warning_amber_rounded,
        title: 'May contain allergens from your profile',
        summary: 'The label has "may contain" warnings for allergens in your '
            'profile. They are not counted in the score because that '
            'setting is turned off.',
      );
    }
    return switch (risk.level) {
      RiskLevel.safe => const RiskBannerStyle(
          color: AppTheme.safe,
          icon: Icons.check_circle_outline,
          title: 'No profile allergens detected',
          summary: 'Nothing in the scanned text matches your profile. Text '
              'recognition can miss things, so always check the package too.',
        ),
      RiskLevel.caution => const RiskBannerStyle(
          color: AppTheme.caution,
          icon: Icons.warning_amber_rounded,
          title: 'Caution',
          summary: 'This product contains allergens from your profile.',
        ),
      RiskLevel.danger => const RiskBannerStyle(
          color: AppTheme.danger,
          icon: Icons.dangerous_outlined,
          title: 'High risk',
          summary: 'Avoid this product. It contains allergens from your '
              'profile with a high risk score.',
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
    final style = RiskBannerStyle.of(risk);
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
          Text(style.summary, style: textTheme.bodyMedium?.copyWith(height: 1.4)),
          const SizedBox(height: 12),
          Text(
            'Risk score ${risk.score.toStringAsFixed(1)}',
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

String _kindLabel(IngredientMatch match) {
  if (match.isTrace) return 'May contain';
  return match.confidence == MatchConfidence.direct ? 'Listed' : 'Derived';
}

class _BreakdownCard extends StatelessWidget {
  const _BreakdownCard({required this.risk});

  final RiskResult risk;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final rows = [...risk.contributions]
      ..sort((a, b) => b.value.compareTo(a.value));

    return _SectionCard(
      title: 'Why this score',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final contribution in rows)
            _ContributionRow(contribution: contribution),
          if (risk.crossContaminationApplied) ...[
            const SizedBox(height: 8),
            Text(
              'Listed ingredients are multiplied by '
              '${1 + RiskConstants.crossContaminationFactor} because the label '
              'has a "may contain" warning.',
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
                  'Risk score',
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
                  match.category.label,
                  style: textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  '${_kindLabel(match)} · "${match.ingredient}" · '
                  '${contribution.severity.label}',
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
    final textTheme = Theme.of(context).textTheme;
    return _SectionCard(
      title: 'Trace warnings, not scored',
      subtitle: 'These allergens are in your profile but only appear in a '
          '"may contain" warning. Turn on "Include may contain warnings" in '
          'your profile to count them.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final warning in warnings)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                '${warning.match.category.label} · "${warning.match.ingredient}" '
                '· ${warning.severity.label}',
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
    return _SectionCard(
      title: 'Also found, not in your profile',
      subtitle: 'These do not affect the score.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final category in categories)
            Chip(
              label: Text(category.label),
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
    final textTheme = Theme.of(context).textTheme;
    return _SectionCard(
      title: 'What was read from the label',
      subtitle: 'Compare this with the package. Text recognition can make '
          'mistakes.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (extraction.ingredients.isNotEmpty) ...[
            Text(
              'Ingredients',
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
              'May contain',
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