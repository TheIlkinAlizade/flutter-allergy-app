class ScanExtraction {
  const ScanExtraction({
    required this.ingredients,
    required this.traces,
    this.detectedLanguage,
  });

  factory ScanExtraction.fromJson(Map<String, dynamic> json) {
    final language = json['detectedLanguage'];
    return ScanExtraction(
      ingredients: _strings(json['ingredients']),
      traces: _strings(json['traces']),
      detectedLanguage: language is String ? language : null,
    );
  }

  final List<String> ingredients;
  final List<String> traces;
  final String? detectedLanguage;

  bool get isEmpty => ingredients.isEmpty && traces.isEmpty;

  static List<String> _strings(Object? value) {
    if (value is! List) return const [];
    return [
      for (final item in value)
        if (item is String && item.trim().isNotEmpty) item.trim(),
    ];
  }
}