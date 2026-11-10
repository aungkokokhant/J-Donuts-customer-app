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
  Future<Result<List<ProductSection>>> loadSections() => readLocal(() async {
    final query = _db.select(_db.sections)
      ..orderBy([(row) => OrderingTerm.asc(row.position)]);
    return List.unmodifiable(
      (await query.get()).map((row) => (id: row.id, title: row.title)),
    );
  });

  @override
  Future<Result<List<CatalogProduct>>> loadSectionProducts(String sectionId) =>
      readLocal(() => _loadSectionProducts(sectionId));

  Future<List<CatalogProduct>> _loadSectionProducts(String sectionId) async {
    final links = _db.sectionProducts;
    final products = _db.products;
    final items =
        _db.select(links).join([
            innerJoin(products, products.id.equalsExp(links.productId)),
          ])
          ..where(links.sectionId.equals(sectionId))
          ..orderBy([OrderingTerm.asc(links.position)]);
    return List.unmodifiable(
      (await items.get()).map((row) => row.readTable(products).toDomain()),
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
