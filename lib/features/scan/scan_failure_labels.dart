import 'package:allergy_app/data/models/scan_failure.dart';

extension ScanFailureMessages on ScanFailure {
  String get message => switch (this) {
        ScanFailure.notConfigured =>
          'Scanning is not set up yet. Add API_BASE_URL to env/dev.json and '
              'restart the app.',
        ScanFailure.network =>
          'Could not reach the scanning service. Check your internet '
              'connection and try again.',
        ScanFailure.rateLimited =>
          'Too many scans in a short time. Wait a minute and try again.',
        ScanFailure.busy =>
          'The scanning service is busy right now. Try again in a moment.',
        ScanFailure.imageTooLarge =>
          'This photo is too large. Try again with a closer or '
              'lower-resolution photo.',
        ScanFailure.unsupportedImage =>
          'This image format is not supported. Use a JPEG, PNG or WebP photo.',
        ScanFailure.imageAccess =>
          'Could not open the camera or photos. Check the app permissions.',
        ScanFailure.unreadable =>
          'No ingredient list could be read from this photo. This is not a '
              'safe result. Make sure the whole list is in focus and well lit, '
              'then try again.',
        ScanFailure.server ||
        ScanFailure.unknown =>
          'Something went wrong while reading the label. Try again.',
        ScanFailure.emptyProfile =>
          'Select at least one allergen in your profile first. Without one, '
              'a scan cannot tell you anything.',
      };
}