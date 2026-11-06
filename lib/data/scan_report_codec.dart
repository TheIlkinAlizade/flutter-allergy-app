import 'package:allergy_app/core/risk_calculator.dart';
import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/ingredient_match.dart';
import 'package:allergy_app/data/models/scan_extraction.dart';
import 'package:allergy_app/data/models/scan_report.dart';
import 'package:allergy_app/data/models/severity.dart';

Map<String, dynamic> scanReportToJson(ScanReport report) {
  return {
    'scannedAt': report.scannedAt.toIso8601String(),
    'extraction': {
      'ingredients': report.extraction.ingredients,
      'traces': report.extraction.traces,
      'detectedLanguage': report.extraction.detectedLanguage,
    },
    'risk': {
      'score': report.risk.score,
      'level': report.risk.level.name,
      'crossApplied': report.risk.crossContaminationApplied,
      'contributions': [
        for (final item in report.risk.contributions) _contributionToJson(item),
      ],
      'traceWarnings': [
        for (final item in report.risk.traceWarnings) _contributionToJson(item),
      ],
    },
    'otherAllergens': [for (final item in report.otherAllergens) item.id],
  };
}

Map<String, dynamic> _contributionToJson(RiskContribution item) {
  return {
    'ingredient': item.match.ingredient,
    'category': item.match.category.id,
    'confidence': item.match.confidence.name,
    'isTrace': item.match.isTrace,
    'severity': item.severity.weight,
  };
}

ScanReport? scanReportFromJson(Map<dynamic, dynamic> json) {
  try {
    final scannedAt = DateTime.tryParse(json['scannedAt'] as String);
    final extraction = json['extraction'];
    final risk = json['risk'];
    if (scannedAt == null || extraction is! Map || risk is! Map) return null;

    final ingredients = _strings(extraction['ingredients']);
    final traces = _strings(extraction['traces']);
    final contributions = _contributions(risk['contributions']);
    final traceWarnings = _contributions(risk['traceWarnings']);
    final level = RiskLevel.values.asNameMap()[risk['level']];
    final score = risk['score'];
    final crossApplied = risk['crossApplied'];

    if (ingredients == null ||
        traces == null ||
        contributions == null ||
        traceWarnings == null ||
        level == null ||
        score is! num ||
        crossApplied is! bool) {
      return null;
    }

    final language = extraction['detectedLanguage'];
    return ScanReport(
      extraction: ScanExtraction(
        ingredients: ingredients,
        traces: traces,
        detectedLanguage: language is String ? language : null,
      ),
      risk: RiskResult(
        score: score.toDouble(),
        level: level,
        contributions: contributions,
        traceWarnings: traceWarnings,
        crossContaminationApplied: crossApplied,
      ),
      otherAllergens: _categories(json['otherAllergens']),
      scannedAt: scannedAt,
    );
  } catch (_) {
    return null;
  }
}

List<String>? _strings(Object? raw) {
  if (raw is! List) return null;
  return [
    for (final item in raw)
      if (item is String) item,
  ];
}

List<AllergenCategory> _categories(Object? raw) {
  if (raw is! List) return const [];
  return [
    for (final item in raw)
      if (item is String && AllergenCategory.fromId(item) != null)
        AllergenCategory.fromId(item)!,
  ];
}

List<RiskContribution>? _contributions(Object? raw) {
  if (raw is! List) return null;
  final result = <RiskContribution>[];
  for (final item in raw) {
    final contribution = _contributionFromJson(item);
    if (contribution == null) return null;
    result.add(contribution);
  }
  return result;
}

RiskContribution? _contributionFromJson(Object? raw) {
  if (raw is! Map) return null;
  final ingredient = raw['ingredient'];
  final categoryId = raw['category'];
  final severityWeight = raw['severity'];
  final isTrace = raw['isTrace'];
  final confidence = MatchConfidence.values.asNameMap()[raw['confidence']];
  final category =
      categoryId is String ? AllergenCategory.fromId(categoryId) : null;
  final severity =
      severityWeight is int ? Severity.fromWeight(severityWeight) : null;

  if (ingredient is! String ||
      category == null ||
      confidence == null ||
      severity == null ||
      isTrace is! bool) {
    return null;
  }

  return RiskContribution(
    match: IngredientMatch(
      ingredient: ingredient,
      category: category,
      confidence: confidence,
      isTrace: isTrace,
    ),
    severity: severity,
  );
}