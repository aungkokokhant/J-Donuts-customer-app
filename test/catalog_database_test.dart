import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts_customer_app/app/repository_providers.dart';
import 'package:jdonuts_customer_app/core/data/app_database.dart';
import 'package:jdonuts_customer_app/core/domain/result.dart';

T valueOf<T>(Result<T> result) => switch (result) {
  Success(:final value) => value,
  Failure(:final error) => throw StateError('Expected success, got $error'),
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('bundled catalog persists and is only seeded on first open', () async {
    final directory = await Directory.systemTemp.createTemp('jdonuts_catalog_');
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/catalog.sqlite');
    var seedLoads = 0;
    Future<String> loadSeed() {
      seedLoads++;
      return rootBundle.loadString('assets/data/catalog.json');
    }

    final first = AppDatabase(NativeDatabase(file), loadSeed: loadSeed);
    try {
      expect(await first.select(first.products).get(), hasLength(5));
    } finally {
      await first.close();
    }

    final reopened = AppDatabase(NativeDatabase(file), loadSeed: loadSeed);
    addTearDown(reopened.close);
    expect(await reopened.select(reopened.products).get(), hasLength(5));
    expect(await reopened.select(reopened.sectionProducts).get(), hasLength(7));
    expect(seedLoads, 1);
  });

  test(
    'Home and Rewards read one member and the same seeded catalog',
    () async {
      final database = AppDatabase(
        NativeDatabase.memory(),
        loadSeed: () => rootBundle.loadString('assets/data/catalog.json'),
      );
      final container = ProviderContainer(
        overrides: [databaseProvider.overrideWithValue(database)],
      );
      addTearDown(() async {
        container.dispose();
        await database.close();
      });

      final home = container.read(homeRepositoryProvider);
      final rewards = container.read(rewardsRepositoryProvider);
      final products = container.read(productRepositoryProvider);
      final member = valueOf(await home.loadMember('demo'))!;

      expect(valueOf(await rewards.loadMember(member.id)), member);
      expect(member.tier, 'Silver');
      expect(member.pointsToNextTier, 500);
      expect(member.totalPoints, 680000);
      expect(valueOf(await home.loadShops()), hasLength(4));
      expect(valueOf(await home.loadBanners()), hasLength(2));

      final sections = valueOf(await home.loadSections());
      expect(sections.map((section) => section.id), [
        'seasonal',
        'popular',
        'order_again',
      ]);
      final coconut = valueOf(await products.findById('p_coconut'));
      expect(coconut?.priceMmk, 3200);
      expect(sections[1].products.last, coconut);
      expect(valueOf(await products.findById('missing')), isNull);

      final challenges = valueOf(await rewards.loadChallenges(member.id));
      expect(
        challenges.map((challenge) => (challenge.completed, challenge.target)),
        [(4, 4), (1, 4), (9, 12)],
      );
    },
  );
}
