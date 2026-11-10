import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/repository_providers.dart';
import '../../../core/domain/result.dart';
import '../../product/domain/product_repository.dart';
import '../domain/home_repository.dart';

final homeBannersProvider =
    FutureProvider.autoDispose<Result<List<HomeBanner>>>(
      (ref) => ref.watch(homeRepositoryProvider).loadBanners(),
    );

final homeSectionsProvider =
    FutureProvider.autoDispose<Result<List<ProductSection>>>(
      (ref) => ref.watch(homeRepositoryProvider).loadSections(),
    );

// Keep loaded rails available when the viewport recycles their widgets.
final homeSectionProductsProvider =
    FutureProvider.family<Result<List<CatalogProduct>>, String>(
      (ref, id) => ref.watch(homeRepositoryProvider).loadSectionProducts(id),
    );

final homeShopsProvider = FutureProvider.autoDispose<Result<List<NearbyShop>>>(
  (ref) => ref.watch(homeRepositoryProvider).loadShops(),
);
