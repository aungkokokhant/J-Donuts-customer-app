import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../core/data/app_database.dart';
import '../core/domain/member_profile.dart';
import '../core/domain/result.dart';
import '../features/home/data/local_home_repository.dart';
import '../features/home/domain/home_repository.dart';
import '../features/product/data/local_product_repository.dart';
import '../features/product/domain/product_repository.dart';
import '../features/rewards/data/local_rewards_repository.dart';
import '../features/rewards/domain/rewards_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase(
    LazyDatabase(() async {
      final directory = await getApplicationSupportDirectory();
      final file = File(path.join(directory.path, 'jdonuts.sqlite'));
      return NativeDatabase.createInBackground(file);
    }),
    loadSeed: () => rootBundle.loadString('assets/data/catalog.json'),
  );
  ref.onDispose(() => unawaited(database.close()));
  return database;
});

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => LocalHomeRepository(ref.watch(databaseProvider)),
);

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => LocalProductRepository(ref.watch(databaseProvider)),
);

final rewardsRepositoryProvider = Provider<RewardsRepository>(
  (ref) => LocalRewardsRepository(ref.watch(databaseProvider)),
);

final memberProfileProvider =
    FutureProvider.autoDispose<Result<MemberProfile?>>(
      (ref) => ref.watch(homeRepositoryProvider).loadMember(demoMemberId),
    );
