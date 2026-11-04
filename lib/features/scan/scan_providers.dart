import 'package:allergy_app/core/allergen_matcher.dart';
import 'package:allergy_app/data/allergen_dictionary_loader.dart';
import 'package:allergy_app/data/services/label_scan_service.dart';
import 'package:allergy_app/features/scan/image_capture_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final labelScanServiceProvider = Provider<LabelScanService>(
  (ref) => LabelScanService(),
);

final imageCaptureServiceProvider = Provider<ImageCaptureService>(
  (ref) => ImageCaptureService(),
);

final allergenMatcherProvider = FutureProvider<AllergenMatcher>((ref) async {
  return AllergenMatcher(await loadAllergenDictionary());
});