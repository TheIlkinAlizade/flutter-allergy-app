enum AllergenCategory {
  peanut('peanut'),
  treeNut('tree_nut'),
  milk('milk'),
  egg('egg'),
  gluten('gluten'),
  soy('soy'),
  fish('fish'),
  shellfish('shellfish'),
  sesame('sesame'),
  celery('celery'),
  mustard('mustard'),
  lupin('lupin'),
  sulphites('sulphites'),
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