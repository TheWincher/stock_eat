import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stock_eat/infrastructure/database/app_database.dart';
import 'package:stock_eat/presentation/pages/home_page.dart';
import 'package:stock_eat/presentation/providers/database_providers.dart';

void main() {
  testWidgets('Stock list shows empty state when there is no data', (
    tester,
  ) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: const MyApp(),
      ),
    );
    await tester.pump();

    expect(find.text('Aucun article en stock'), findsOneWidget);

    // Dispose the widget tree (and its Drift stream subscriptions) before
    // the test ends, then pump once more so Drift's internal zero-duration
    // cleanup Timer fires. Otherwise flutter_test's teardown finds that
    // timer still pending and fails the test.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(Duration.zero);
  });
}
