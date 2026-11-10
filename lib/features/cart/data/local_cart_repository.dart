import 'package:drift/drift.dart';

import '../../../core/data/app_database.dart';
import '../../../core/data/read_local.dart';
import '../../../core/domain/result.dart';
import '../../product/data/local_product_repository.dart';
import '../domain/cart_repository.dart';

final class LocalCartRepository implements CartRepository {
  const LocalCartRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<Result<List<CartLine>>> watch(String owner) async* {
    final items = _db.cartItems;
    final products = _db.products;
    final query =
        _db.select(items).join([
            innerJoin(products, products.id.equalsExp(items.productId)),
          ])
          ..where(items.ownerPhone.equals(owner))
          ..orderBy([
            OrderingTerm.asc(products.name),
            OrderingTerm.asc(products.id),
          ]);
    try {
      await for (final rows in query.watch()) {
        yield Success(
          List.unmodifiable(
            rows.map(
              (row) => (
                product: row.readTable(products).toDomain(),
                quantity: row.readTable(items).quantity,
              ),
            ),
          ),
        );
      }
    } on Exception catch (error, stackTrace) {
      yield Failure(LocalDataFailure(error, stackTrace));
    }
  }

  @override
  Future<Result<void>> add(String owner, String productId, int quantity) =>
      readLocal(() async {
        if (quantity <= 0) {
          throw const FormatException('Expected a positive quantity');
        }
        await _db
            .into(_db.cartItems)
            .insert(
              CartItemsCompanion.insert(
                ownerPhone: owner,
                productId: productId,
                quantity: quantity,
              ),
              onConflict: DoUpdate(
                (row) => CartItemsCompanion.custom(
                  quantity: row.quantity + Variable(quantity),
                ),
              ),
            );
      });

  @override
  Future<Result<void>> decrease(String owner, String productId) => readLocal(
    () => _db.transaction(() async {
      final items = _db.cartItems;
      final line =
          items.ownerPhone.equals(owner) & items.productId.equals(productId);
      await (_db.delete(
        items,
      )..where((row) => line & row.quantity.equals(1))).go();
      await (_db.update(items)..where((_) => line)).write(
        CartItemsCompanion.custom(quantity: items.quantity - const Variable(1)),
      );
    }),
  );
}
