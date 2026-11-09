import 'dart:convert';

import 'package:drift/drift.dart';

part 'app_database.g.dart';
part 'catalog_seed.dart';

@DriftDatabase(include: {'catalog.drift'})
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor, {required this.loadSeed});

  final Future<String> Function() loadSeed;

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      final seed = await loadSeed();
      await customStatement('PRAGMA foreign_keys = ON');
      await transaction(() async {
        await migrator.createAll();
        await _insertSeed(this, seed);
      });
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) await migrator.createTable(registeredUsers);
    },
    beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
  );
}
