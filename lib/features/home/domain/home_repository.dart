import '../../../core/domain/member_profile.dart';
import '../../../core/domain/result.dart';
import '../../product/domain/product_repository.dart';

typedef HomeBanner = ({String title, String label, String imageKey});
typedef NearbyShop = ({String name, String address, String imageKey});
typedef ProductSection = ({
  String id,
  String title,
  List<CatalogProduct> products,
});

abstract interface class HomeRepository {
  Future<Result<MemberProfile?>> loadMember(String id);
  Future<Result<List<HomeBanner>>> loadBanners();
  Future<Result<List<ProductSection>>> loadSections();
  Future<Result<List<NearbyShop>>> loadShops();
}
