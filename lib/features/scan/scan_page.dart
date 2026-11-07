import 'dart:typed_data';

import 'package:allergy_app/config/app_theme.dart';
import 'package:allergy_app/data/models/scan_failure.dart';
import 'package:allergy_app/features/profile/profile_provider.dart';
import 'package:allergy_app/features/result/result_page.dart';
import 'package:allergy_app/features/scan/image_capture_service.dart';
import 'package:allergy_app/features/scan/scan_controller.dart';
import 'package:allergy_app/features/scan/scan_failure_labels.dart';
import 'package:allergy_app/features/scan/scan_providers.dart';
import 'package:allergy_app/features/shell/app_tab.dart';
import 'package:allergy_app/shared/l10n_context.dart';
import 'package:allergy_app/shared/widgets/disclaimer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends ConsumerStatefulWidget {
  const ScanPage({super.key});

  @override
  ConsumerState<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends ConsumerState<ScanPage> {
  Uint8List? _preview;

  Future<void> _pick(ImageSource source) async {
    final controller = ref.read(scanControllerProvider.notifier);
    final image = await _tryPick(source, controller);
    if (image == null) return;
    setState(() => _preview = image.bytes);
    await controller.scan(image);
  }

  Future<PickedImage?> _tryPick(
    ImageSource source,
    ScanController controller,
  ) async {
    try {
      return await ref.read(imageCaptureServiceProvider).pick(source);
    } on ScanException catch (error) {
      controller.fail(error.failure);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    ref.listen<ScanState>(scanControllerProvider, (previous, next) {
      if (next is! ScanSuccess) return;
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ResultPage(report: next.report),
        ),
      );
      ref.read(scanControllerProvider.notifier).reset();
      setState(() => _preview = null);
    });

    final state = ref.watch(scanControllerProvider);
    final profile = ref.watch(profileProvider);
    final loading = state is ScanLoading;
    final needsProfile = profile.allergens.isEmpty;
    final canScan = !loading && !needsProfile;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.scanTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          if (needsProfile) ...[
            _ProfileRequiredCard(
              onOpenProfile: () => ref
                  .read(selectedTabProvider.notifier)
                  .select(AppTab.profile),
            ),
            const SizedBox(height: 16),
          ],
          if (loading)
            _LoadingCard(preview: _preview)
          else
            const _TipsCard(),
          if (state is ScanFailed && !needsProfile) ...[
            const SizedBox(height: 16),
            _FailureCard(failure: state.failure),
          ],
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: canScan ? () => _pick(ImageSource.camera) : null,
            icon: const Icon(Icons.photo_camera_outlined),
            label: Text(l10n.scanTakePhoto),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: canScan ? () => _pick(ImageSource.gallery) : null,
            icon: const Icon(Icons.photo_library_outlined),
            label: Text(l10n.scanChooseGallery),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              foregroundColor: AppTheme.textDark,
              side: const BorderSide(color: AppTheme.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const DisclaimerCard(),
        ],
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  const _TipsCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lightbulb_outline, color: AppTheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.scanTipsTitle,
                    style: textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final tip in [l10n.scanTip1, l10n.scanTip2, l10n.scanTip3])
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  tip,
                  style: textTheme.bodyMedium?.copyWith(
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

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({required this.preview});

  final Uint8List? preview;

  @override
  Widget build(BuildContext context) {
    final image = preview;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (image != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
            ],
            const LinearProgressIndicator(),
            const SizedBox(height: 12),
            Text(
              context.l10n.scanReading,
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

class _FailureCard extends StatelessWidget {
  const _FailureCard({required this.failure});

  final ScanFailure failure;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.error_outline, color: AppTheme.danger),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                failure.message(context.l10n),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRequiredCard extends StatelessWidget {
  const _ProfileRequiredCard({required this.onOpenProfile});

  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.shield_outlined, color: AppTheme.caution),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.scanProfileRequiredTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.scanProfileRequiredBody,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppTheme.textMuted, height: 1.4),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: onOpenProfile,
              child: Text(l10n.scanOpenProfile),
            ),
          ],
        ),
      ),
    );
  }
}