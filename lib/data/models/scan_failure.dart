enum ScanFailure {
  notConfigured,
  network,
  rateLimited,
  busy,
  imageTooLarge,
  unsupportedImage,
  imageAccess,
  unreadable,
  server,
  emptyProfile,
  unknown,
}

class ScanException implements Exception {
  const ScanException(this.failure);

  final ScanFailure failure;

  @override
  String toString() => 'ScanException(${failure.name})';
}