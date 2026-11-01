enum AllergenCategory {
  peanut('peanut'),
  treeNut('tree_nut'),
  milk('milk'),
  gluten('gluten'),
  soy('soy'),
  seafood('seafood'),
  additives('additives');

  const AllergenCategory(this.id);

  final String id;

  static AllergenCategory? fromId(String id) {
    for (final category in values) {
      if (category.id == id) return category;
    }
    return null;
  }
}