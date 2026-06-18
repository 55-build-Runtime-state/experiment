// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:data_layer/data_layer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genlatte/src/data/data.dart' hide CompleteOrder;
import 'package:genlatte/src/screens/barista/home/barista_home_bloc.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockBaristaRepository extends Mock implements Repository<Barista> {}

class MockLatteOrderMetadataRepository extends Mock
    implements Repository<LatteOrderMetadata> {}

class MockLatteOrdersRepository extends Mock implements LatteOrdersRepository {}

class MockMachineRepository extends Mock implements Repository<Machine> {}

class FakeRequestDetails extends Fake implements RequestDetails {}

class FakeBarista extends Fake implements Barista {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRequestDetails());
    registerFallbackValue(const LatteOrderMetadata(id: 'fake'));
    registerFallbackValue(FakeBarista());
  });

  group('BaristaHomeBloc', () {
    late MockBaristaRepository baristaRepository;
    late MockLatteOrderMetadataRepository metadataRepository;
    late MockLatteOrdersRepository ordersRepository;
    late MockMachineRepository machinesRepository;

    late StreamController<List<Barista>> baristasController;
    late StreamController<List<LatteOrderMetadata>> brewController;
    late StreamController<List<Machine>> machinesController;

    setUp(() {
      baristaRepository = MockBaristaRepository();
      metadataRepository = MockLatteOrderMetadataRepository();
      ordersRepository = MockLatteOrdersRepository();
      machinesRepository = MockMachineRepository();

      baristasController = StreamController<List<Barista>>.broadcast();
      brewController = StreamController<List<LatteOrderMetadata>>.broadcast();
      machinesController = StreamController<List<Machine>>.broadcast();

      when(
        () => ordersRepository.sendToPrinters(
          imagePath: any(named: 'imagePath'),
          machineName: any(named: 'machineName'),
        ),
      ).thenAnswer((_) async => {});

      when(
        () => baristaRepository.watchList(details: any(named: 'details')),
      ).thenAnswer((_) => baristasController.stream);

      // Default mock for initial Local fetch
      when(
        () => baristaRepository.getItems(details: any(named: 'details')),
      ).thenAnswer((_) async => []);

      when(
        () => machinesRepository.watchList(details: any(named: 'details')),
      ).thenAnswer((_) => machinesController.stream);

      // Default mock for initial Local fetch
      when(
        () => machinesRepository.getItems(details: any(named: 'details')),
      ).thenAnswer((_) async => []);

      when(
        () => metadataRepository.watchList(
          details: any(
            named: 'details',
            that: isA<RequestDetails>().having(
              (r) => r.filter,
              'filter',
              isA<LatteOrderMetadataBrewQueue>(),
            ),
          ),
        ),
      ).thenAnswer((_) => brewController.stream);

      GetIt.I.registerSingleton<Repository<Barista>>(baristaRepository);
      GetIt.I.registerSingleton<Repository<LatteOrderMetadata>>(
        metadataRepository,
      );
      GetIt.I.registerSingleton<LatteOrdersRepository>(ordersRepository);
      GetIt.I.registerSingleton<Repository<Machine>>(machinesRepository);
    });

    tearDown(() async {
      await baristasController.close();
      await brewController.close();
      await machinesController.close();
      await GetIt.I.reset();
    });

    test('initial state is correct', () async {
      final bloc = BaristaHomeBloc();
      expect(bloc.state, BaristaHomeState.initial());
      await bloc.close();
    });

    blocTest<BaristaHomeBloc, BaristaHomeState>(
      'NewBrewQueueOrders updates brewQueue',
      build: () {
        when(() => ordersRepository.toLattes(any())).thenAnswer(
          (_) async => [
            Latte(
              order: const LatteOrder(id: '1', name: 'order1'),
              metadata: LatteOrderMetadata(
                id: '1',
                orderSubmittedTime: DateTime(2024),
              ),
            ),
          ],
        );
        return BaristaHomeBloc();
      },
      act: (bloc) => bloc.add(
        NewBrewQueueOrders([
          LatteOrderMetadata(
            id: '1',
            orderSubmittedTime: DateTime(2024),
          ),
        ]),
      ),
      expect: () => [
        BaristaHomeState.initial().copyWith(
          brewQueue: [
            Latte(
              order: const LatteOrder(id: '1', name: 'order1'),
              metadata: LatteOrderMetadata(
                id: '1',
                orderSubmittedTime: DateTime(2024),
              ),
            ),
          ],
        ),
      ],
      verify: (_) {
        verify(() => ordersRepository.toLattes(any())).called(1);
      },
    );

    blocTest<BaristaHomeBloc, BaristaHomeState>(
      'NewBaristas updates baristas map',
      build: BaristaHomeBloc.new,
      act: (bloc) => bloc.add(
        const NewBaristas([
          Barista(id: '1', persona: BaristaPersona.asianFemale, username: 'b1'),
        ]),
      ),
      expect: () => [
        BaristaHomeState.initial().copyWith(
          baristas: {
            '1': const Barista(
              id: '1',
              persona: BaristaPersona.asianFemale,
              username: 'b1',
            ),
          },
        ),
      ],
    );

    blocTest<BaristaHomeBloc, BaristaHomeState>(
      'BaristaSignIn handles new barista',
      build: () {
        when(
          () => baristaRepository.getItems(details: any(named: 'details')),
        ).thenAnswer((_) async => []);
        when(() => baristaRepository.setItem(any())).thenAnswer(
          (_) async => const Barista(
            id: 'new-id',
            persona: BaristaPersona.asianFemale,
            username: 'b1',
          ),
        );
        when(
          () => baristaRepository.setItems(
            any(),
            any(
              that: isA<RequestDetails>().having(
                (r) => r.filter,
                'filter',
                isA<ActiveBaristaFilter>(),
              ),
            ),
          ),
        ).thenAnswer((_) async => []);

        return BaristaHomeBloc();
      },
      act: (bloc) => bloc.add(
        const BaristaSignIn(
          Barista(persona: BaristaPersona.asianFemale, username: 'b1'),
        ),
      ),
      expect: () => [
        BaristaHomeState.initial().copyWith(
          currentBarista: const Barista(
            id: 'new-id',
            persona: BaristaPersona.asianFemale,
            username: 'b1',
          ),
        ),
      ],
      verify: (_) {
        verify(() => baristaRepository.setItem(any())).called(1);
        verify(() => baristaRepository.setItems(any(), any())).called(1);
      },
    );

    blocTest<BaristaHomeBloc, BaristaHomeState>(
      'ClaimOrder updates metadata correctly',
      build: () {
        when(
          () => metadataRepository.setItem(any()),
        ).thenAnswer((_) async => const LatteOrderMetadata(id: '1'));
        return BaristaHomeBloc();
      },
      seed: () => BaristaHomeState.initial().copyWith(
        selectedMachine: const Machine(id: 'm-id', name: 'm1'),
        currentBarista: const Barista(
          id: 'b-id',
          persona: BaristaPersona.asianFemale,
          username: 'b1',
        ),
        brewQueue: [
          Latte(
            order: const LatteOrder(id: 'O-1', name: 'order1'),
            metadata: LatteOrderMetadata(
              id: '1',
              imageUrl: 'abc',
              orderSubmittedTime: DateTime(2024),
            ),
          ),
        ],
      ),
      act: (bloc) => bloc.add(const ClaimOrder('O-1')),
      verify: (_) {
        verify(
          () => metadataRepository.setItem(
            any(
              that: isA<LatteOrderMetadata>()
                  .having((m) => m.baristaId, 'baristaId', 'b-id')
                  .having(
                    (m) => m.status,
                    'status',
                    LatteOrderStatus.inProgress,
                  ),
            ),
          ),
        ).called(1);
      },
    );

    blocTest<BaristaHomeBloc, BaristaHomeState>(
      'CompleteOrder calls OrderRepository.completeOrder',
      build: () {
        when(
          () => ordersRepository.completeOrder(
            orderId: any(named: 'orderId'),
            baristaId: any(named: 'baristaId'),
          ),
        ).thenAnswer((_) async {});
        return BaristaHomeBloc();
      },
      seed: () => BaristaHomeState.initial().copyWith(
        currentBarista: const Barista(
          id: 'b-id',
          persona: BaristaPersona.asianFemale,
          username: 'barista1',
        ),
        brewQueue: [
          Latte(
            order: const LatteOrder(id: 'O-1', name: 'order1'),
            metadata: LatteOrderMetadata(
              id: '1',
              imageUrl: 'abc',
              orderSubmittedTime: DateTime(2024),
            ),
          ),
        ],
      ),
      act: (bloc) => bloc.add(const CompleteOrder('O-1')),
      verify: (_) {
        verify(
          () => ordersRepository.completeOrder(
            orderId: 'O-1',
            baristaId: 'b-id',
          ),
        ).called(1);
      },
    );
  });
}
