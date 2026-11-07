import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/features/profile/profile_provider.dart';
import 'package:allergy_app/features/profile/widgets/allergen_tile.dart';
import 'package:allergy_app/features/profile/widgets/cross_contamination_card.dart';
import 'package:allergy_app/shared/l10n_context.dart';
import 'package:allergy_app/shared/widgets/disclaimer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final profile = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(
            l10n.profileIntro,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppTheme.textMuted, height: 1.4),
          ),
          const SizedBox(height: 16),
          for (final category in AllergenCategory.values)
            AllergenTile(
              category: category,
              severity: profile.allergens[category],
              onToggle: (enabled) {
                if (enabled) {
                  notifier.setAllergen(category, ProfileNotifier.defaultSeverity);
                } else {
                  notifier.removeAllergen(category);
                }
              },
              onSeverityChanged: (severity) =>
                  notifier.setAllergen(category, severity),
            ),
          const SizedBox(height: 6),
          CrossContaminationCard(
            value: profile.crossContamination,
            onChanged: notifier.setCrossContamination,
          ),
          const SizedBox(height: 16),
          const DisclaimerCard(),
        ],
      ),
    );
  }
}