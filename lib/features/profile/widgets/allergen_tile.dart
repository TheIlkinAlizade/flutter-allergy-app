import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/severity.dart';
import 'package:allergy_app/features/profile/profile_labels.dart';
import 'package:allergy_app/shared/l10n_context.dart';
import 'package:flutter/material.dart';

class AllergenTile extends StatelessWidget {
  const AllergenTile({
    required this.category,
    required this.severity,
    required this.onToggle,
    required this.onSeverityChanged,
    super.key,
  });

  final AllergenCategory category;
  final Severity? severity;
  final ValueChanged<bool> onToggle;
  final ValueChanged<Severity> onSeverityChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final selected = severity != null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primary.withValues(alpha: 0.05)
              : AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? AppTheme.primary.withValues(alpha: 0.4)
                : AppTheme.border,
          ),
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.label(l10n),
                            style: textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            category.examples(l10n),
                            style: textTheme.bodySmall
                                ?.copyWith(color: AppTheme.textMuted),
                          ),
                        ],
                      ),
                    ),
                    Switch(value: selected, onChanged: onToggle),
                  ],
                ),
                if (selected) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (final option in Severity.values)
                        ChoiceChip(
                          label: Text(option.label(l10n)),
                          selected: severity == option,
                          showCheckmark: false,
                          backgroundColor: AppTheme.surface,
                          selectedColor: option.color.withValues(alpha: 0.18),
                          side: BorderSide(
                            color: severity == option
                                ? option.color
                                : AppTheme.border,
                          ),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                          onSelected: (_) => onSeverityChanged(option),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}