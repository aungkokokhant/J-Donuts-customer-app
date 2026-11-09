part of 'app_database.dart';

Future<void> _insertSeed(AppDatabase db, String raw) async {
  final json = jsonDecode(raw) as Map<String, Object?>;
  Iterable<T> rows<T>(String key, T Function(Map<String, dynamic>) parse) =>
      (json[key] as List<Object?>).map(
        (row) => parse(row as Map<String, dynamic>),
      );

  await db.batch((batch) {
    batch.insertAll(db.products, rows('products', Product.fromJson));
    batch.insertAll(db.banners, rows('banners', Banner.fromJson));
    batch.insertAll(db.sections, rows('sections', Section.fromJson));
    batch.insertAll(
      db.sectionProducts,
      rows('section_products', SectionProduct.fromJson),
    );
    batch.insertAll(db.shops, rows('shops', Shop.fromJson));
    batch.insertAll(db.members, rows('members', Member.fromJson));
    batch.insertAll(db.challenges, rows('challenges', Challenge.fromJson));
  });
}

Future<void> _seedTierStarts(AppDatabase db, String raw) async {
  final json = jsonDecode(raw) as Map<String, Object?>;
  final members = (json['members'] as List<Object?>).map(
    (row) => Member.fromJson(row as Map<String, dynamic>),
  );
  for (final member in members) {
    await (db.update(
      db.members,
    )..where((row) => row.id.equals(member.id))).write(
      MembersCompanion(tierStartPoints: Value(member.tierStartPoints)),
    );
  }
}

Future<void> _refreshCoconutDescription(AppDatabase db, String raw) async {
  const original = 'A soft donut with coconut and a chocolate drizzle.';
  final json = jsonDecode(raw) as Map<String, Object?>;
  for (final row
      in (json['products'] as List<Object?>).cast<Map<String, dynamic>>()) {
    if (row['id'] != 'p_coconut') continue;
    await (db.update(db.products)..where(
          (product) =>
              product.id.equals('p_coconut') &
              product.description.equals(original),
        ))
        .write(
          ProductsCompanion(description: Value(row['description'] as String)),
        );
    return;
  }
}
