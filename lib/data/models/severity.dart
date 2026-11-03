enum Severity {
  mild(1),
  moderate(2),
  anaphylaxis(3);

  const Severity(this.weight);

  final int weight;

  static Severity? fromWeight(int weight) {
    for (final severity in values) {
      if (severity.weight == weight) return severity;
    }
    return null;
  }
}