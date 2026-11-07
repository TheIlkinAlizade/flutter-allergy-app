import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/shared/l10n_context.dart';
import 'package:flutter/material.dart';

class DisclaimerCard extends StatelessWidget {
  const DisclaimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline, color: AppTheme.textMuted, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                context.l10n.disclaimer,
                style: textTheme.bodySmall?.copyWith(
                  color: AppTheme.textMuted,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}