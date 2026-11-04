import 'package:allergy_app/core/risk_calculator.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/scan_extraction.dart';

class ScanReport {
  const ScanReport({
    required this.extraction,
    required this.risk,
    required this.otherAllergens,
    required this.scannedAt,
  });

  final ScanExtraction extraction;
  final RiskResult risk;
  final List<AllergenCategory> otherAllergens;
  final DateTime scannedAt;
}