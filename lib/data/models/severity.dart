enum Severity {
  mild(1),
  moderate(2),
  anaphylaxis(3);

  const Severity(this.weight);

  final int weight;
}