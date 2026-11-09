import '../../../core/data/app_database.dart';
import '../../../core/data/read_local.dart';
import '../../../core/domain/result.dart';
import '../domain/product_repository.dart';

final class LocalProductRepository implements ProductRepository {
  const LocalProductRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<CatalogProduct?>> findById(String id) => readLocal(() async {
    final query = _db.select(_db.products)..where((row) => row.id.equals(id));
    return (await query.getSingleOrNull())?.toDomain();
  });
}

extension ProductMapping on Product {
  CatalogProduct toDomain() => (
    id: id,
    code: code,
    name: name,
    priceMmk: priceMmk,
    isNew: isNew,
    discountPercent: discountPercent,
    imageKey: imageKey,
    description: description,
  );
}
