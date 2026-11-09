import '../../../core/domain/result.dart';

typedef CatalogProduct = ({
  String id,
  String code,
  String name,
  int priceMmk,
  bool isNew,
  int? discountPercent,
  String imageKey,
  String description,
});

abstract interface class ProductRepository {
  Future<Result<CatalogProduct?>> findById(String id);
}
