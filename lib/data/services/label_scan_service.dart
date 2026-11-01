import 'dart:convert';
import 'dart:typed_data';

import 'package:allergy_app/config/app_config.dart';
import 'package:allergy_app/data/models/scan_extraction.dart';
import 'package:http/http.dart' as http;

enum ScanFailure {
  notConfigured,
  network,
  rateLimited,
  busy,
  imageTooLarge,
  unreadable,
  server,
}

class ScanException implements Exception {
  const ScanException(this.failure);

  final ScanFailure failure;

  @override
  String toString() => 'ScanException(${failure.name})';
}

class LabelScanService {
  LabelScanService({http.Client? client, String? baseUrl})
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? AppConfig.apiBaseUrl;

  static const _timeout = Duration(seconds: 45);

  final http.Client _client;
  final String _baseUrl;

  Future<ScanExtraction> extract(Uint8List imageBytes, String mimeType) async {
    if (_baseUrl.isEmpty) {
      throw const ScanException(ScanFailure.notConfigured);
    }

    final http.Response response;
    try {
      response = await _client
          .post(
            Uri.parse('$_baseUrl/extract'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'image': base64Encode(imageBytes),
              'mimeType': mimeType,
            }),
          )
          .timeout(_timeout);
    } on Exception {
      throw const ScanException(ScanFailure.network);
    }

    switch (response.statusCode) {
      case 200:
        break;
      case 413:
        throw const ScanException(ScanFailure.imageTooLarge);
      case 429:
        throw const ScanException(ScanFailure.rateLimited);
      case 503:
        throw const ScanException(ScanFailure.busy);
      default:
        throw const ScanException(ScanFailure.server);
    }

    final Object? decoded;
    try {
      decoded = jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      throw const ScanException(ScanFailure.server);
    }
    if (decoded is! Map<String, dynamic>) {
      throw const ScanException(ScanFailure.server);
    }

    final extraction = ScanExtraction.fromJson(decoded);
    if (extraction.isEmpty) {
      throw const ScanException(ScanFailure.unreadable);
    }
    return extraction;
  }
}