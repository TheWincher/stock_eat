import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:stock_eat/domain/entities/unit.dart';
import 'package:stock_eat/domain/entities/storage_location.dart';

import 'tables/categories_table.dart';
import 'tables/products_table.dart';
import 'tables/stock_items_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Categories, Products, StockItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @visibleForTesting
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'stock_eat.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
