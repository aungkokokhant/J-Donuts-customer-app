import 'package:drift/drift.dart';

import '../../../core/data/app_database.dart';
import '../../../core/data/local_member.dart';
import '../../../core/data/read_local.dart';
import '../../../core/domain/member_profile.dart';
import '../../../core/domain/result.dart';
import '../../product/data/local_product_repository.dart';
import '../../product/domain/product_repository.dart';
import '../domain/home_repository.dart';

final class LocalHomeRepository implements HomeRepository {
  const LocalHomeRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<MemberProfile?>> loadMember(String id) =>
      readLocal(() => loadLocalMember(_db, id));

  @override
  Future<Result<List<HomeBanner>>> loadBanners() => readLocal(() async {
    final query = _db.select(_db.banners)
      ..orderBy([(row) => OrderingTerm.asc(row.position)]);
    return List.unmodifiable(
      (await query.get()).map(
        (row) => (title: row.title, label: row.label, imageKey: row.imageKey),
      ),
    );
  });

  @override
  Future<Result<List<ProductSection>>> loadSections() =>
      readLocal(() => _db.transaction(_loadSections));

  Future<List<ProductSection>> _loadSections() async {
    final query = _db.select(_db.sections)
      ..orderBy([(row) => OrderingTerm.asc(row.position)]);
    final sections = await query.get();
    final links = _db.sectionProducts;
    final products = _db.products;
    final items = _db.select(links).join([
      innerJoin(products, products.id.equalsExp(links.productId)),
    ])..orderBy([OrderingTerm.asc(links.position)]);
    final productsBySection = <String, List<CatalogProduct>>{};
    for (final row in await items.get()) {
      productsBySection
          .putIfAbsent(row.readTable(links).sectionId, () => [])
          .add(row.readTable(products).toDomain());
    }
    return List.unmodifiable(
      sections.map(
        (row) => (
          id: row.id,
          title: row.title,
          products: List<CatalogProduct>.unmodifiable(
            productsBySection[row.id] ?? const [],
          ),
        ),
      ),
    );
  }

  @override
  Future<Result<List<NearbyShop>>> loadShops() => readLocal(() async {
    final query = _db.select(_db.shops)
      ..orderBy([(row) => OrderingTerm.asc(row.position)]);
    return List.unmodifiable(
      (await query.get()).map(
        (row) => (name: row.name, address: row.address, imageKey: row.imageKey),
      ),
    );
  });
}
