import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/repository_providers.dart';
import '../../../core/domain/member_profile.dart';
import '../../../core/domain/result.dart';
import '../domain/home_repository.dart';

const demoMemberId = 'demo';

final homeMemberProvider = FutureProvider.autoDispose<Result<MemberProfile?>>(
  (ref) => ref.watch(homeRepositoryProvider).loadMember(demoMemberId),
);

final homeBannersProvider =
    FutureProvider.autoDispose<Result<List<HomeBanner>>>(
      (ref) => ref.watch(homeRepositoryProvider).loadBanners(),
    );

final homeSectionsProvider =
    FutureProvider.autoDispose<Result<List<ProductSection>>>(
      (ref) => ref.watch(homeRepositoryProvider).loadSections(),
    );

final homeShopsProvider = FutureProvider.autoDispose<Result<List<NearbyShop>>>(
  (ref) => ref.watch(homeRepositoryProvider).loadShops(),
);
