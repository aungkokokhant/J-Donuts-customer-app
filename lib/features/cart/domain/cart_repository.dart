import '../../../core/domain/result.dart';
import '../../product/domain/product_repository.dart';

typedef CartLine = ({CatalogProduct product, int quantity});

abstract interface class CartRepository {
  Stream<Result<List<CartLine>>> watch(String owner);
  Future<Result<void>> add(String owner, String productId, int quantity);
  Future<Result<void>> decrease(String owner, String productId);
}
