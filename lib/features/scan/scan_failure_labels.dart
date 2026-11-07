import 'package:allergy_app/data/models/scan_failure.dart';
import 'package:allergy_app/l10n/app_localizations.dart';

extension ScanFailureMessages on ScanFailure {
  String message(AppLocalizations l10n) => switch (this) {
        ScanFailure.notConfigured => l10n.failureNotConfigured,
        ScanFailure.network => l10n.failureNetwork,
        ScanFailure.rateLimited => l10n.failureRateLimited,
        ScanFailure.busy => l10n.failureBusy,
        ScanFailure.imageTooLarge => l10n.failureImageTooLarge,
        ScanFailure.unsupportedImage => l10n.failureUnsupportedImage,
        ScanFailure.imageAccess => l10n.failureImageAccess,
        ScanFailure.unreadable => l10n.failureUnreadable,
        ScanFailure.server || ScanFailure.unknown => l10n.failureServer,
        ScanFailure.emptyProfile => l10n.failureEmptyProfile,
      };
}