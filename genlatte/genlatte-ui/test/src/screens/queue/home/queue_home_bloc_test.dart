// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_redundant_argument_values

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:data_layer/data_layer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genlatte/src/data/data.dart';
import 'package:genlatte/src/data/shared_preferences_repository.dart';
import 'package:genlatte/src/screens/queue/home/queue_home_bloc.dart';
import 'package:genlatte/src/screens/queue/home/queue_settings.dart';
import 'package:genlatte_data/models.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRequestDetails());
  });

  group('QueueHomeBloc', () {
    late MockLatteOrderMetadataRepository metadataRepository;
    late MockLatteOrdersRepository ordersRepository;
    late MockSharedPreferencesRepository sharedPrefsRepository;
    late StreamController<List<LatteOrderMetadata>> streamController;

    setUp(() {
      metadataRepository = MockLatteOrderMetadataRepository();
      ordersRepository = MockLatteOrdersRepository();
      sharedPrefsRepository = MockSharedPreferencesRepository();
      when(
        () => sharedPrefsRepository.setString(any(), any()),
      ).thenAnswer((_) async {});
      streamController = StreamController<List<LatteOrderMetadata>>.broadcast();

      when(
        () => metadataRepository.watchList(details: any(named: 'details')),
      ).thenAnswer((_) => streamController.stream);
    });

    tearDown(() async {
      await streamController.close();
    });

    test('initial state is correct', () async {
      final bloc = QueueHomeBloc(
        metadataRepository: metadataRepository,
        ordersRepository: ordersRepository,
        sharedPrefsRepository: sharedPrefsRepository,
        initialSettings: const QueueSettingsState(
          shardNumber: 42,
          shardTotal: 67,
        ),
      );
      expect(
        bloc.state,
        const QueueHomeState(
          settings: QueueSettingsState(shardNumber: 42, shardTotal: 67),
        ),
      );
      await bloc.close();
    });

    blocTest<QueueHomeBloc, QueueHomeState>(
      'SetRecency updates max ages',
      build: () => QueueHomeBloc(
        metadataRepository: metadataRepository,
        ordersRepository: ordersRepository,
        sharedPrefsRepository: sharedPrefsRepository,
        initialSettings: const QueueSettingsState(
          shardNumber: 1,
          shardTotal: 2,
        ),
      ),
      act: (bloc) => bloc.add(
        const SetRecency(Duration(seconds: 10), Duration(seconds: 20)),
      ),
      expect: () => [
        const QueueHomeState(
          settings: QueueSettingsState(
            shardNumber: 1,
            shardTotal: 2,
            maxRecentAge: Duration(seconds: 10),
            maxShowAge: Duration(seconds: 20),
          ),
        ),
      ],
    );

    blocTest<QueueHomeBloc, QueueHomeState>(
      'SetShard updates shards',
      build: () => QueueHomeBloc(
        metadataRepository: metadataRepository,
        ordersRepository: ordersRepository,
        sharedPrefsRepository: sharedPrefsRepository,
        initialSettings: const QueueSettingsState(
          shardNumber: 1,
          shardTotal: 2,
        ),
      ),
      act: (bloc) => bloc.add(const SetShard(2, 3)),
      expect: () => [
        const QueueHomeState(
          settings: QueueSettingsState(shardNumber: 2, shardTotal: 3),
        ),
      ],
    );

    blocTest<QueueHomeBloc, QueueHomeState>(
      'SlotsCounted updates slot capacity',
      build: () => QueueHomeBloc(
        metadataRepository: metadataRepository,
        ordersRepository: ordersRepository,
        sharedPrefsRepository: sharedPrefsRepository,
        initialSettings: const QueueSettingsState(
          shardNumber: 1,
          shardTotal: 1,
        ),
      ),
      act: (bloc) => bloc.add(const SlotsCounted(42)),

      expect: () => contains(
        isA<QueueHomeState>().having(
          (s) => s.uiSlotCapacity,
          'uiSlotCapacity',
          42,
        ),
      ),
    );

    blocTest<QueueHomeBloc, QueueHomeState>(
      'Orders load and pages are updated on capacity',
      build: () {
        when(() => ordersRepository.toLattes(any())).thenAnswer(
          (_) async => [
            Latte(
              order: const LatteOrder(id: '1', name: 'order1'),
              metadata: LatteOrderMetadata(
                id: '1',
                status: LatteOrderStatus.inProgress,
                orderSubmittedTime: DateTime.now().subtract(
                  const Duration(seconds: 10),
                ),
              ),
            ),
          ],
        );
        return QueueHomeBloc(
          metadataRepository: metadataRepository,
          ordersRepository: ordersRepository,
          sharedPrefsRepository: sharedPrefsRepository,
          initialSettings: const QueueSettingsState(
            shardNumber: 1,
            shardTotal: 1,
          ),
        );
      },
      seed: () => const QueueHomeState(
        settings: QueueSettingsState(shardNumber: 1, shardTotal: 1),
        uiSlotCapacity: 2,
      ),
      act: (bloc) async {
        bloc.add(
          OrdersUpdated([
            LatteOrderMetadata(
              id: '1',
              status: LatteOrderStatus.inProgress,
              orderSubmittedTime: DateTime.now().subtract(
                const Duration(seconds: 10),
              ),
            ),
          ]),
        );
        await Future<void>.delayed(const Duration(milliseconds: 10));
      },
      expect: () => [
        isA<QueueHomeState>()
            .having((s) => s.shownPages.length, 'pages length', 1)
            .having(
              (s) => s.shownPages.first.orders.length,
              'orders per page',
              2,
            )
            .having(
              (s) => s.shownPages.first.orders.first?.order.id,
              'order id',
              '1',
            ),
      ],
    );

    blocTest<QueueHomeBloc, QueueHomeState>(
      'Shard change should change the UI pages',
      build: () {
        when(() => ordersRepository.toLattes(any())).thenAnswer(
          (_) async => [
            Latte(
              order: const LatteOrder(id: '2', name: 'order2'),
              metadata: LatteOrderMetadata(
                id: '2',
                status: LatteOrderStatus.inProgress,
                orderSubmittedTime: DateTime.now(),
              ),
            ),
          ],
        );
        return QueueHomeBloc(
          metadataRepository: metadataRepository,
          ordersRepository: ordersRepository,
          sharedPrefsRepository: sharedPrefsRepository,
          initialSettings: const QueueSettingsState(
            shardNumber: 1,
            shardTotal: 2,
          ),
        );
      },
      seed: () => const QueueHomeState(
        settings: QueueSettingsState(shardNumber: 1, shardTotal: 2),
        uiSlotCapacity: 2,
      ),
      act: (bloc) async {
        bloc.add(
          OrdersUpdated([
            LatteOrderMetadata(
              id: '2',
              status: LatteOrderStatus.inProgress,
              orderSubmittedTime: DateTime.now(),
            ),
          ]),
        );
        await Future<void>.delayed(const Duration(milliseconds: 10));

        bloc.add(const SetShard(42, 1337));
      },
      expect: () => [
        // The intermediate state from OrdersUpdated
        isA<QueueHomeState>(),
        // Setting shard sets details
        isA<QueueHomeState>()
            .having((s) => s.settings.shardNumber, 'shardNumber', 42)
            .having(
              (s) => s.settings.shardTotal,
              'shardTotal',
              1337,
            ),
        // RefreshPages updates the pages based on new details
        isA<QueueHomeState>(),
      ],
    );

    blocTest<QueueHomeBloc, QueueHomeState>(
      'Recency change should change the UI pages',
      build: () {
        when(() => ordersRepository.toLattes(any())).thenAnswer(
          (_) async => [
            Latte(
              order: const LatteOrder(id: '2', name: 'order2'),
              metadata: LatteOrderMetadata(
                id: '2',
                status: LatteOrderStatus.inProgress,
                orderSubmittedTime: DateTime.now(),
              ),
            ),
          ],
        );
        return QueueHomeBloc(
          metadataRepository: metadataRepository,
          ordersRepository: ordersRepository,
          sharedPrefsRepository: sharedPrefsRepository,
          initialSettings: const QueueSettingsState(
            shardNumber: 1,
            shardTotal: 2,
          ),
        );
      },
      seed: () => const QueueHomeState(
        settings: QueueSettingsState(shardNumber: 1, shardTotal: 2),
        uiSlotCapacity: 2,
      ),
      act: (bloc) async {
        bloc.add(
          OrdersUpdated([
            LatteOrderMetadata(
              id: '2',
              status: LatteOrderStatus.inProgress,
              orderSubmittedTime: DateTime.now(),
            ),
          ]),
        );
        await Future<void>.delayed(const Duration(milliseconds: 10));

        bloc.add(const SetRecency(Duration(minutes: 3), Duration(minutes: 30)));
      },
      expect: () => [
        // First state from OrdersUpdated
        isA<QueueHomeState>(),
        // Second from setting recency
        isA<QueueHomeState>().having(
          (s) => s.settings.maxRecentAge,
          'maxRecent',
          const Duration(minutes: 3),
        ),
        // Third from refresh
        isA<QueueHomeState>(),
      ],
    );

    blocTest<QueueHomeBloc, QueueHomeState>(
      'When orders arrive but there are no UI slots, '
      'it should not try to show the orders',
      build: () {
        when(() => ordersRepository.toLattes(any())).thenAnswer(
          (_) async => [
            Latte(
              order: const LatteOrder(id: '3', name: 'order3'),
              metadata: LatteOrderMetadata(
                id: '3',
                status: LatteOrderStatus.inProgress,
                orderSubmittedTime: DateTime.now(),
              ),
            ),
          ],
        );
        return QueueHomeBloc(
          metadataRepository: metadataRepository,
          ordersRepository: ordersRepository,
          sharedPrefsRepository: sharedPrefsRepository,
          initialSettings: const QueueSettingsState(
            shardNumber: 1,
            shardTotal: 1,
          ),
        );
      },
      seed: () => const QueueHomeState(
        settings: QueueSettingsState(shardNumber: 1, shardTotal: 1),
        uiSlotCapacity: 0,
      ),
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));

        bloc.add(
          OrdersUpdated([
            LatteOrderMetadata(
              id: '3',
              status: LatteOrderStatus.inProgress,
              orderSubmittedTime: DateTime.now(),
            ),
          ]),
        );
        await Future<void>.delayed(const Duration(milliseconds: 10));
      },
      expect: () => <QueueHomeState>[],
    );

    blocTest<QueueHomeBloc, QueueHomeState>(
      'When there are no UI slots and orders arrive, '
      'a new SlotsCounted with non-zero slots should produce pages immediately',
      build: () {
        when(() => ordersRepository.toLattes(any())).thenAnswer(
          (_) async => [
            Latte(
              order: const LatteOrder(id: '4', name: 'order4'),
              metadata: LatteOrderMetadata(
                id: '4',
                status: LatteOrderStatus.inProgress,
                orderSubmittedTime: DateTime.now(),
              ),
            ),
          ],
        );
        return QueueHomeBloc(
          metadataRepository: metadataRepository,
          ordersRepository: ordersRepository,
          sharedPrefsRepository: sharedPrefsRepository,
          initialSettings: const QueueSettingsState(
            shardNumber: 1,
            shardTotal: 1,
          ),
        );
      },
      seed: () => const QueueHomeState(
        settings: QueueSettingsState(shardNumber: 1, shardTotal: 1),
        uiSlotCapacity: 0,
      ),
      act: (bloc) async {
        bloc.add(
          OrdersUpdated([
            LatteOrderMetadata(
              id: '4',
              status: LatteOrderStatus.inProgress,
              orderSubmittedTime: DateTime.now(),
            ),
          ]),
        );
        await Future<void>.delayed(const Duration(milliseconds: 10));

        bloc.add(const SlotsCounted(4));
      },
      expect: () => [
        const QueueHomeState(
          settings: QueueSettingsState(shardNumber: 1, shardTotal: 1),
          uiSlotCapacity: 4,
        ),
        isA<QueueHomeState>()
            .having((s) => s.uiSlotCapacity, 'capacity', 4)
            .having((s) => s.shownPages.length, 'pages length', 1),
      ],
    );

    test(
      'sharding splits all orders without duplicates or omissions',
      () async {
        when(() => ordersRepository.toLattes(any())).thenAnswer((inv) async {
          final metadatas =
              inv.positionalArguments.first as List<LatteOrderMetadata>;
          return metadatas
              .map(
                (m) => Latte(
                  order: LatteOrder(id: m.id ?? '', name: 'order'),
                  metadata: m,
                ),
              )
              .toList();
        });

        final metadatas = List.generate(
          100,
          (i) => LatteOrderMetadata(
            id: 'order_$i',
            status: LatteOrderStatus.inProgress,
            orderSubmittedTime: DateTime.now(),
          ),
        );

        final bloc1 =
            QueueHomeBloc(
                metadataRepository: metadataRepository,
                ordersRepository: ordersRepository,
                sharedPrefsRepository: sharedPrefsRepository,
                initialSettings: const QueueSettingsState(
                  shardNumber: 1,
                  shardTotal: 2,
                ),
              )
              ..add(const SlotsCounted(100))
              ..add(OrdersUpdated(metadatas));

        final bloc2 =
            QueueHomeBloc(
                metadataRepository: metadataRepository,
                ordersRepository: ordersRepository,
                sharedPrefsRepository: sharedPrefsRepository,
                initialSettings: const QueueSettingsState(
                  shardNumber: 2,
                  shardTotal: 2,
                ),
              )
              ..add(const SlotsCounted(100))
              ..add(OrdersUpdated(metadatas));

        await Future<void>.delayed(const Duration(milliseconds: 100));

        final orders1 = bloc1.state.shownPages
            .expand((p) => p.orders)
            .whereType<Latte>()
            .map((e) => e.metadata.id!)
            .toSet();

        final orders2 = bloc2.state.shownPages
            .expand((p) => p.orders)
            .whereType<Latte>()
            .map((e) => e.metadata.id!)
            .toSet();

        expect(
          orders1,
          isNotEmpty,
          reason: 'Should select at least one order from a hundred',
        );

        expect(
          orders1.intersection(orders2),
          isEmpty,
          reason: 'Shards should not share any orders',
        );

        expect(
          orders1.union(orders2).length,
          100,
          reason: 'Together, shards should show all orders without omission',
        );

        await bloc1.close();
        await bloc2.close();
      },
    );
  });
}

class FakeRequestDetails extends Fake implements RequestDetails {}

class MockLatteOrderMetadataRepository extends Mock
    implements Repository<LatteOrderMetadata> {}

class MockLatteOrdersRepository extends Mock implements LatteOrdersRepository {}

class MockSharedPreferencesRepository extends Mock
    implements SharedPreferencesRepository {}
