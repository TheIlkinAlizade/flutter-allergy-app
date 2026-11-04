import 'package:allergy_app/core/scan_analyzer.dart';
import 'package:allergy_app/data/models/scan_failure.dart';
import 'package:allergy_app/data/models/scan_report.dart';
import 'package:allergy_app/features/profile/profile_provider.dart';
import 'package:allergy_app/features/scan/image_capture_service.dart';
import 'package:allergy_app/features/scan/scan_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

sealed class ScanState {
  const ScanState();
}

class ScanIdle extends ScanState {
  const ScanIdle();
}

class ScanLoading extends ScanState {
  const ScanLoading();
}

class ScanSuccess extends ScanState {
  const ScanSuccess(this.report);

  final ScanReport report;
}

class ScanFailed extends ScanState {
  const ScanFailed(this.failure);

  final ScanFailure failure;
}

final scanControllerProvider = NotifierProvider<ScanController, ScanState>(
  ScanController.new,
);

class ScanController extends Notifier<ScanState> {
  @override
  ScanState build() => const ScanIdle();

  void reset() => state = const ScanIdle();

  void fail(ScanFailure failure) => state = ScanFailed(failure);

  Future<void> scan(PickedImage image) async {
    if (state is ScanLoading) return;

    final profile = ref.read(profileProvider);
    if (profile.allergens.isEmpty) {
      state = const ScanFailed(ScanFailure.emptyProfile);
      return;
    }

    state = const ScanLoading();
    try {
      final extraction = await ref
          .read(labelScanServiceProvider)
          .extract(image.bytes, image.mimeType);
      final matcher = await ref.read(allergenMatcherProvider.future);
      final report = ScanAnalyzer(matcher: matcher).analyze(
        extraction,
        ref.read(profileProvider),
      );
      state = ScanSuccess(report);
    } on ScanException catch (error) {
      state = ScanFailed(error.failure);
    } catch (error, stackTrace) {
      debugPrint('Unexpected scan error: $error\n$stackTrace');
      state = const ScanFailed(ScanFailure.unknown);
    }
  }
}