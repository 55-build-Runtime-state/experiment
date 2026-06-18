// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:data_layer/data_layer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genlatte/src/data/data.dart';
import 'package:genlatte/src/screens/moderator/home/moderator_home_bloc.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockBaristaRepository extends Mock implements Repository<Barista> {}

class MockLatteOrderMetadataRepository extends Mock
    implements Repository<LatteOrderMetadata> {}

class MockLatteOrdersRepository extends Mock implements LatteOrdersRepository {}

class FakeRequestDetails extends Fake implements RequestDetails {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRequestDetails());
    registerFallbackValue(const LatteOrderMetadata(id: 'fake'));
  });

  group('ModeratorHomeBloc', () {
    late MockBaristaRepository baristaRepository;
    late MockLatteOrderMetadataRepository metadataRepository;
    late MockLatteOrdersRepository ordersRepository;

    late StreamController<List<Barista>> baristasController;
    late StreamController<List<LatteOrderMetadata>> brewController;
    late StreamController<List<LatteOrderMetadata>> moderationController;

    setUp(() {
      baristaRepository = MockBaristaRepository();
      metadataRepository = MockLatteOrderMetadataRepository();
      ordersRepository = MockLatteOrdersRepository();

      baristasController = StreamController<List<Barista>>.broadcast();
      brewController = StreamController<List<LatteOrderMetadata>>.broadcast();
      moderationController =
          StreamController<List<LatteOrderMetadata>>.broadcast();

      when(
        () => baristaRepository.watchList(details: any(named: 'details')),
      ).thenAnswer((_) => baristasController.stream);

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

      when(
        () => metadataRepository.watchList(
          details: any(
            named: 'details',
            that: isA<RequestDetails>().having(
              (r) => r.filter,
              'filter',
              isA<LatteOrderMetadataModerationQueue>(),
            ),
          ),
        ),
      ).thenAnswer((_) => moderationController.stream);

      GetIt.I.registerSingleton<Repository<Barista>>(baristaRepository);
      GetIt.I.registerSingleton<Repository<LatteOrderMetadata>>(
        metadataRepository,
      );
      GetIt.I.registerSingleton<LatteOrdersRepository>(ordersRepository);
    });

    tearDown(() async {
      await baristasController.close();
      await brewController.close();
      await moderationController.close();
      await GetIt.I.reset();
    });

    test('initial state is correct', () async {
      final bloc = ModeratorHomeBloc();
      expect(bloc.state, ModeratorHomeState.initial());
      await bloc.close();
    });

    blocTest<ModeratorHomeBloc, ModeratorHomeState>(
      'NewModerateQueueOrders updates moderationQueue',
      build: () {
        when(() => ordersRepository.toLattes(any())).thenAnswer(
          (_) async => [
            const Latte(
              order: LatteOrder(id: '1', name: 'order1'),
              metadata: LatteOrderMetadata(id: '1'),
            ),
          ],
        );
        return ModeratorHomeBloc();
      },
      act: (bloc) => bloc.add(
        const NewModerateQueueOrders([LatteOrderMetadata(id: '1')]),
      ),
      expect: () => [
        ModeratorHomeState.initial().copyWith(
          moderationQueue: [
            const Latte(
              order: LatteOrder(id: '1', name: 'order1'),
              metadata: LatteOrderMetadata(id: '1'),
            ),
          ],
        ),
      ],
      verify: (_) {
        verify(() => ordersRepository.toLattes(any())).called(1);
      },
    );

    blocTest<ModeratorHomeBloc, ModeratorHomeState>(
      'NewBaristas updates baristas map',
      build: ModeratorHomeBloc.new,
      act: (bloc) => bloc.add(
        const NewBaristas([
          Barista(id: '1', persona: BaristaPersona.asianFemale, username: 'b1'),
        ]),
      ),
      expect: () => [
        ModeratorHomeState.initial().copyWith(
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

    blocTest<ModeratorHomeBloc, ModeratorHomeState>(
      'ApproveNameAndImage updates metadata correctly',
      build: () {
        when(
          () => metadataRepository.setItem(any()),
        ).thenAnswer((_) async => const LatteOrderMetadata(id: '1'));
        return ModeratorHomeBloc();
      },
      seed: () => ModeratorHomeState.initial().copyWith(
        moderationQueue: [
          const Latte(
            order: LatteOrder(id: '1', name: 'order1'),
            metadata: LatteOrderMetadata(id: '1'),
          ),
        ],
      ),
      act: (bloc) => bloc.add(const ApproveNameAndImage('1')),
      verify: (_) {
        verify(
          () => metadataRepository.setItem(
            any(
              that: isA<LatteOrderMetadata>()
                  .having((m) => m.isNameApproved, 'isNameApproved', true)
                  .having((m) => m.isImageApproved, 'isImageApproved', true)
                  .having(
                    (m) => m.status,
                    'status',
                    LatteOrderStatus.validated,
                  ),
            ),
          ),
        ).called(1);
      },
    );

    blocTest<ModeratorHomeBloc, ModeratorHomeState>(
      'RejectNameApproveImage updates metadata correctly',
      build: () {
        when(
          () => metadataRepository.setItem(any()),
        ).thenAnswer((_) async => const LatteOrderMetadata(id: '1'));
        return ModeratorHomeBloc();
      },
      seed: () => ModeratorHomeState.initial().copyWith(
        moderationQueue: [
          const Latte(
            order: LatteOrder(id: '1', name: 'order1'),
            metadata: LatteOrderMetadata(id: '1'),
          ),
        ],
      ),
      act: (bloc) => bloc.add(const RejectNameApproveImage('1')),
      verify: (_) {
        verify(
          () => metadataRepository.setItem(
            any(
              that: isA<LatteOrderMetadata>()
                  .having((m) => m.isNameApproved, 'isNameApproved', false)
                  .having((m) => m.isImageApproved, 'isImageApproved', true)
                  .having(
                    (m) => m.status,
                    'status',
                    LatteOrderStatus.validated,
                  ),
            ),
          ),
        ).called(1);
      },
    );

    blocTest<ModeratorHomeBloc, ModeratorHomeState>(
      'ApproveNameRejectImage updates metadata correctly',
      build: () {
        when(
          () => metadataRepository.setItem(any()),
        ).thenAnswer((_) async => const LatteOrderMetadata(id: '1'));
        return ModeratorHomeBloc();
      },
      seed: () => ModeratorHomeState.initial().copyWith(
        moderationQueue: [
          const Latte(
            order: LatteOrder(id: '1', name: 'order1'),
            metadata: LatteOrderMetadata(id: '1'),
          ),
        ],
      ),
      act: (bloc) => bloc.add(const ApproveNameRejectImage('1')),
      verify: (_) {
        verify(
          () => metadataRepository.setItem(
            any(
              that: isA<LatteOrderMetadata>()
                  .having((m) => m.isNameApproved, 'isNameApproved', true)
                  .having((m) => m.isImageApproved, 'isImageApproved', false)
                  .having(
                    (m) => m.status,
                    'status',
                    LatteOrderStatus.validated,
                  ),
            ),
          ),
        ).called(1);
      },
    );

    blocTest<ModeratorHomeBloc, ModeratorHomeState>(
      'RejectNameAndImage updates metadata correctly',
      build: () {
        when(
          () => metadataRepository.setItem(any()),
        ).thenAnswer((_) async => const LatteOrderMetadata(id: '1'));
        return ModeratorHomeBloc();
      },
      seed: () => ModeratorHomeState.initial().copyWith(
        moderationQueue: [
          const Latte(
            order: LatteOrder(id: '1', name: 'order1'),
            metadata: LatteOrderMetadata(id: '1'),
          ),
        ],
      ),
      act: (bloc) => bloc.add(const RejectNameAndImage('1')),
      verify: (_) {
        verify(
          () => metadataRepository.setItem(
            any(
              that: isA<LatteOrderMetadata>()
                  .having((m) => m.isNameApproved, 'isNameApproved', false)
                  .having((m) => m.isImageApproved, 'isImageApproved', false)
                  .having(
                    (m) => m.status,
                    'status',
                    LatteOrderStatus.validated,
                  ),
            ),
          ),
        ).called(1);
      },
    );
  });
}
