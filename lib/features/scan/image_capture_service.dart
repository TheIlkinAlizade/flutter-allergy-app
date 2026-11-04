import 'package:allergy_app/data/models/scan_failure.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickedImage {
  const PickedImage({required this.bytes, required this.mimeType});

  final Uint8List bytes;
  final String mimeType;
}

String? detectImageMimeType(Uint8List bytes) {
  if (bytes.length >= 3 &&
      bytes[0] == 0xFF &&
      bytes[1] == 0xD8 &&
      bytes[2] == 0xFF) {
    return 'image/jpeg';
  }
  if (bytes.length >= 8 &&
      bytes[0] == 0x89 &&
      bytes[1] == 0x50 &&
      bytes[2] == 0x4E &&
      bytes[3] == 0x47) {
    return 'image/png';
  }
  if (bytes.length >= 12 &&
      bytes[0] == 0x52 &&
      bytes[1] == 0x49 &&
      bytes[2] == 0x46 &&
      bytes[3] == 0x46 &&
      bytes[8] == 0x57 &&
      bytes[9] == 0x45 &&
      bytes[10] == 0x42 &&
      bytes[11] == 0x50) {
    return 'image/webp';
  }
  return null;
}

class ImageCaptureService {
  ImageCaptureService({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  static const maxDimension = 1600.0;
  static const imageQuality = 80;
  static const maxBytes = 2200000;

  final ImagePicker _picker;

  Future<PickedImage?> pick(ImageSource source) async {
    final XFile? file;
    try {
      file = await _picker.pickImage(
        source: source,
        maxWidth: maxDimension,
        maxHeight: maxDimension,
        imageQuality: imageQuality,
      );
    } on PlatformException {
      throw const ScanException(ScanFailure.imageAccess);
    }
    if (file == null) return null;

    final bytes = await file.readAsBytes();
    if (bytes.length > maxBytes) {
      throw const ScanException(ScanFailure.imageTooLarge);
    }
    final mimeType = detectImageMimeType(bytes);
    if (mimeType == null) {
      throw const ScanException(ScanFailure.unsupportedImage);
    }
    return PickedImage(bytes: bytes, mimeType: mimeType);
  }
}