// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:data_layer/data_layer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genlatte/src/data/data.dart' as repo;
import 'package:genlatte/src/screens/kiosk/home/kiosk_home_bloc.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';

class FakeRemoteSource<T> extends LocalMemorySource<T> with WatchableSource<T> {
  FakeRemoteSource({required super.bindings});

  final Map<String, StreamController<ReadResult<T>>> _watchControllers = {};

  void pushUpdate(String id, T? item) {
    final result = ReadResult<T>.success(
      item,
      details: RequestDetails.read(requestType: RequestType.refresh),
    );
    if (_watchControllers.containsKey(id)) {
      _watchControllers[id]!.add(result);
    } else {
      // Create it if it doesn't exist yet, so we can eagerly push
      _watchControllers[id] = StreamController<ReadResult<T>>.broadcast();
      _watchControllers[id]!.add(result);
    }
  }

  @override
  SourceType get sourceType => SourceType.remote;

  @override
  Stream<ReadResult<T>> watch(ReadOperation<T> operation) {
    final id = operation.itemId;
    if (!_watchControllers.containsKey(id)) {
      _watchControllers[id] = StreamController<ReadResult<T>>.broadcast();
    }
    return _watchControllers[id]!.stream;
  }

  @override
  Stream<ReadListResult<T>> watchList(ReadListOperation<T> operation) =>
      Stream<ReadListResult<T>>.empty();

  @override
  Stream<ReadListResult<T>> watchByIds(ReadByIdsOperation<T> operation) =>
      Stream<ReadListResult<T>>.empty();
}

class FakeRepository<T> extends Repository<T> {
  factory FakeRepository(Bindings<T> bindings) {
    final local = LocalMemorySource<T>(bindings: bindings);
    final remote = FakeRemoteSource<T>(bindings: bindings);
    final list = SourceList<T>(
      bindings: bindings,
      sources: [local, remote],
    );
    return FakeRepository._(
      bindings: bindings,
      localSource: local,
      remoteSource: remote,
      sourceList: list,
    );
  }
  FakeRepository._({
    required this.bindings,
    required this.localSource,
    required this.remoteSource,
    required SourceList<T> sourceList,
  }) : super(sourceList);

  final Bindings<T> bindings;
  // ignore: unreachable_from_main
  final LocalMemorySource<T> localSource;
  final FakeRemoteSource<T> remoteSource;

  @override
  Future<T?> setItem(T item, [RequestDetails? details]) async {
    T itemCopy = item;
    if (bindings.getId(itemCopy) == null) {
      if (item is LatteOrder) {
        itemCopy = item.copyWith(id: 'mock-assigned-id') as T;
      } else if (item is LatteOrderMetadata) {
        itemCopy = item.copyWith(id: 'mock-assigned-id') as T;
      }
    }
    return super.setItem(itemCopy, details);
  }
}

class FakeLatteOrdersRepository extends FakeRepository<LatteOrder>
    implements repo.LatteOrdersRepository {
  factory FakeLatteOrdersRepository(
    Bindings<LatteOrder> bindings, {
    repo.AcceptImage? acceptImage,
    repo.CompleteOrder? completeOrder,
    repo.GenerateRevisedImages? generateRevisedImages,
    repo.RejectImageBatch? rejectImageBatch,
    repo.SendToPrinters? sendToPrinters,
    repo.SubmitOrder? submitOrder,
  }) {
    final local = LocalMemorySource<LatteOrder>(bindings: bindings);
    final remote = FakeRemoteSource<LatteOrder>(bindings: bindings);
    final list = SourceList<LatteOrder>(
      bindings: bindings,
      sources: [local, remote],
    );
    return FakeLatteOrdersRepository._(
      bindings: bindings,
      localSource: local,
      remoteSource: remote,
      sourceList: list,
      acceptImage:
          acceptImage ??
          ({required String imageBatchId, required String imageIndex}) async {},
      completeOrder:
          completeOrder ??
          ({required String orderId, required String baristaId}) async {},
      generateRevisedImages:
          generateRevisedImages ??
          ({
            required String imageBatchId,
            required String imageIndex,
            required Map<String, Object?> answers,
          }) async {},
      rejectImageBatch: rejectImageBatch ?? (String id) async {},
      sendToPrinters:
          sendToPrinters ??
          ({required String imagePath, required String machineName}) async {},
      submitOrder: submitOrder ?? (String id) async {},
    );
  }

  FakeLatteOrdersRepository._({
    required super.bindings,
    required super.localSource,
    required super.remoteSource,
    required super.sourceList,
    required repo.AcceptImage acceptImage,
    required repo.CompleteOrder completeOrder,
    required repo.GenerateRevisedImages generateRevisedImages,
    required repo.RejectImageBatch rejectImageBatch,
    required repo.SendToPrinters sendToPrinters,
    required repo.SubmitOrder submitOrder,
  }) : _acceptImage = acceptImage,
       _completeOrder = completeOrder,
       _generateRevisedImages = generateRevisedImages,
       _rejectImageBatch = rejectImageBatch,
       _sendToPrinters = sendToPrinters,
       _submitOrder = submitOrder,
       super._();

  @override
  Future<void> acceptImage({
    required String imageBatchId,
    required String imageIndex,
  }) => _acceptImage(imageBatchId: imageBatchId, imageIndex: imageIndex);
  final repo.AcceptImage _acceptImage;

  @override
  Future<void> completeOrder({
    required String orderId,
    required String baristaId,
  }) => _completeOrder(orderId: orderId, baristaId: baristaId);
  final repo.CompleteOrder _completeOrder;

  @override
  Future<void> generateRevisedImages({
    required String imageBatchId,
    required String imageIndex,
    required Map<String, Object?> answers,
  }) => _generateRevisedImages(
    imageBatchId: imageBatchId,
    imageIndex: imageIndex,
    answers: answers,
  );
  final repo.GenerateRevisedImages _generateRevisedImages;

  @override
  Future<void> rejectImageBatch(String imageBatchId) =>
      _rejectImageBatch(imageBatchId);
  final repo.RejectImageBatch _rejectImageBatch;

  @override
  Future<void> sendToPrinters({
    required String imagePath,
    required String machineName,
  }) => _sendToPrinters(imagePath: imagePath, machineName: machineName);
  final repo.SendToPrinters _sendToPrinters;

  @override
  Future<void> submitOrder(String orderId) => _submitOrder(orderId);
  final repo.SubmitOrder _submitOrder;

  @override
  Future<List<Latte>> toLattes(List<LatteOrderMetadata> metadatas) async {
    return [];
  }
}

void main() {
  late FakeLatteOrdersRepository orderRepo;
  late FakeRepository<LatteOrderMetadata> metadataRepo;
  late FakeRepository<LatteImageBatch> imagesRepo;
  late FakeRepository<LatteOptions> optionsRepo;

  const questions = <Question>[
    Question.multipleChoice(
      id: 'time-of-day',
      body: 'What time of day is it?',
      acceptableAnswers: ['Morning', 'Evening', 'Night'],
    ),
    Question(
      id: 'free-form',
      body: 'Any other changes you want to make?',
      helpText: 'This is optional',
    ),
    Question.zeroToOne(
      id: 'how-colorful',
      body: 'How colorful should the image be?',
      minValueLabel: 'Black and white',
      maxValueLabel: 'Technicolor',
    ),
    Question.negativeOneToOne(
      id: 'how-chaotic',
      body: 'How chaotic should the image be?',
      minValueLabel: 'Calm',
      maxValueLabel: 'Chaotic',
    ),
  ];

  const image1 = LatteImage(
    imageUrl: 'image-1.url',
    prompt: 'Gemini Gemini AI man, make me an image as fast as you can',
    questions: questions,
    description: 'A picture of a cat',
  );
  const image2 = LatteImage(
    imageUrl: 'image-2.url',
    prompt: 'Gemini Gemini AI man, make me an image as fast as you can',
    questions: questions,
    description: 'A picture of a dog',
  );
  const image3 = LatteImage(
    imageUrl: 'image-3.url',
    prompt: 'Gemini Gemini AI man, make me an image as fast as you can',
    questions: questions,
    description: 'A picture of a bird',
  );
  const image4 = LatteImage(
    imageUrl: 'image-4.url',
    prompt: 'Gemini Gemini AI man, make me an image as fast as you can',
    questions: questions,
    description: 'A picture of a fish',
  );

  setUp(() {
    orderRepo = FakeLatteOrdersRepository(LatteOrder.bindings);
    metadataRepo = FakeRepository<LatteOrderMetadata>(
      LatteOrderMetadata.bindings,
    );
    imagesRepo = FakeRepository<LatteImageBatch>(LatteImageBatch.bindings);
    optionsRepo = FakeRepository<LatteOptions>(LatteOptions.bindings);

    GetIt.I.registerSingleton<repo.LatteOrdersRepository>(orderRepo);
    GetIt.I.registerSingleton<Repository<LatteOrderMetadata>>(metadataRepo);
    GetIt.I.registerSingleton<Repository<LatteImageBatch>>(imagesRepo);
    GetIt.I.registerSingleton<Repository<LatteOptions>>(optionsRepo);
  });

  tearDown(() async {
    await GetIt.I.reset();
  });

  group('KioskHomeBloc Initialization', () {
    blocTest<KioskHomeBloc, KioskHomeState>(
      'loads initial data streams and attempts to load orders',
      build: KioskHomeBloc.new,
      act: (bloc) async {
        // allow streams to be fully subscribed
        await Future<void>.delayed(const Duration(milliseconds: 50));

        optionsRepo.remoteSource.pushUpdate(
          'milks',
          const LatteOptions(
            id: 'milks',
            values: [
              const LatteOption(name: 'Oat'),
              const LatteOption(name: 'Almond'),
            ],
          ),
        );
        optionsRepo.remoteSource.pushUpdate(
          'sweeteners',
          const LatteOptions(
            id: 'sweeteners',
            values: [const LatteOption(name: 'Vanilla')],
          ),
        );
      },
      expect: () => [
        KioskHomeState.initial().copyWith(
          milkOptions: [
            const LatteOption(name: 'Oat'),
            const LatteOption(name: 'Almond'),
          ],
        ),
        KioskHomeState.initial().copyWith(
          milkOptions: [
            const LatteOption(name: 'Oat'),
            const LatteOption(name: 'Almond'),
          ],
          sweetenerOptions: [const LatteOption(name: 'Vanilla')],
        ),
      ],
    );
  });

  group('KioskHomeBloc LoadPreExistingOrders Edge Cases', () {
    blocTest<KioskHomeBloc, KioskHomeState>(
      'Deletes all orders if multiple are returned from local cache',
      setUp: () async {
        await orderRepo.setItem(const LatteOrder(id: '1', name: 'Order 1'));
        await orderRepo.setItem(const LatteOrder(id: '2', name: 'Order 2'));
      },
      build: KioskHomeBloc.new,
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      verify: (bloc) async {
        final order1 = await orderRepo.getById(
          '1',
          RequestDetails.read(requestType: RequestType.local),
        );
        final order2 = await orderRepo.getById(
          '2',
          RequestDetails.read(requestType: RequestType.local),
        );
        expect(order1, isNull);
        expect(order2, isNull);
      },
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'Deletes order if a single order is returned but metadata is missing',
      setUp: () async {
        await orderRepo.setItem(
          const LatteOrder(id: 'only-one', name: 'But there is no metadata'),
        );
      },
      build: KioskHomeBloc.new,
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      verify: (bloc) async {
        final retrieved = await orderRepo.getById(
          'only-one',
          RequestDetails.read(requestType: RequestType.local),
        );
        expect(retrieved, isNull);
      },
    );
  });

  group('KioskHomeBloc ApplyPreExistingOrder Routing Edge Cases', () {
    blocTest<KioskHomeBloc, KioskHomeState>(
      'Routing to `.name` if name is null',
      setUp: () async {
        await orderRepo.setItem(const LatteOrder(id: 'valid-order'));
        await metadataRepo.setItem(const LatteOrderMetadata(id: 'valid-order'));
      },
      build: KioskHomeBloc.new,
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.name,
        ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'Routing to `.milkAndSweetener` if milk or sweetener is null',
      setUp: () async {
        await orderRepo.setItem(
          const LatteOrder(
            id: 'valid-order',
            name: 'Bob',
            // milk is null
          ),
        );
        await metadataRepo.setItem(const LatteOrderMetadata(id: 'valid-order'));
      },
      build: KioskHomeBloc.new,
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.milkAndSweetener,
        ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'Routing to `.happyPlace` if happyPlace is null',
      setUp: () async {
        await orderRepo.setItem(
          const LatteOrder(
            id: 'valid-order',
            name: 'Bob',
            milk: 'Oat',
            sweetener: 'Vanilla',
            // happyPlace is null
          ),
        );
        await metadataRepo.setItem(const LatteOrderMetadata(id: 'valid-order'));
      },
      build: KioskHomeBloc.new,
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.happyPlace,
        ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'Routing to `.submitOrder` if metadata has an imageUrl',
      setUp: () async {
        await orderRepo.setItem(
          const LatteOrder(
            id: 'valid-order',
            name: 'Bob',
            milk: 'Oat',
            sweetener: 'Vanilla',
            happyPlace: 'A beach',
          ),
        );
        await metadataRepo.setItem(
          const LatteOrderMetadata(
            id: 'valid-order',
            imageUrl: 'https://example.com/image.png',
          ),
        );
      },
      build: KioskHomeBloc.new,
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.submitOrder,
        ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'Routing to `.chooseAnImage` if imageBatchId exists but has no parent',
      setUp: () async {
        await orderRepo.setItem(
          const LatteOrder(
            id: 'valid-order',
            name: 'Bob',
            milk: 'Oat',
            sweetener: 'Vanilla',
            happyPlace: 'A beach',
          ),
        );
        await metadataRepo.setItem(
          const LatteOrderMetadata(
            id: 'valid-order',
            imageBatchId: 'batch-1',
          ),
        );
        await imagesRepo.setItem(
          const LatteImageBatch(
            id: 'batch-1',
            orderId: 'valid-order',
            image0: image1,
            image1: image2,
            image2: image3,
            image3: image4,
            // parent is null
          ),
        );
      },
      build: KioskHomeBloc.new,
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.chooseAnImage,
        ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'Routing to `.chooseATweakedImage` if imageBatchId exists and HAS a '
      'parent',
      setUp: () async {
        await orderRepo.setItem(
          const LatteOrder(
            id: 'valid-order',
            name: 'Bob',
            milk: 'Oat',
            sweetener: 'Vanilla',
            happyPlace: 'A beach',
          ),
        );
        await metadataRepo.setItem(
          const LatteOrderMetadata(
            id: 'valid-order',
            imageBatchId: 'batch-2',
          ),
        );
        await imagesRepo.setItem(
          const LatteImageBatch(
            id: 'batch-2',
            orderId: 'valid-order',
            image0: image1,
            image1: image2,
            image2: image3,
            image3: image4,
            parent: LatteImageBatchParent(
              id: 'batch-1',
              imageIndex: '0',
            ),
          ),
        );
      },
      build: KioskHomeBloc.new,
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.chooseATweakedImage,
        ),
      ],
    );
  });

  group('KioskHomeBloc GoBackKioskWizard Edge Cases', () {
    blocTest<KioskHomeBloc, KioskHomeState>(
      'From .submitOrder with parent -> goes to .chooseATweakedImage',
      build: KioskHomeBloc.new,
      seed: () => KioskHomeState.initial().copyWith(
        currentStep: KioskWizardStep.submitOrder,
        imagesBatch: const LatteImageBatch(
          id: 'batch-2',
          orderId: 'valid-order',
          image0: image1,
          image1: image2,
          image2: image3,
          image3: image4,
          parent: LatteImageBatchParent(
            id: 'batch-1',
            imageIndex: '0',
          ),
        ),
      ),
      act: (bloc) => bloc.add(const GoBackKioskWizard()),
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.chooseATweakedImage,
        ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'From .submitOrder without parent -> goes to .chooseAnImage',
      build: KioskHomeBloc.new,
      seed: () => KioskHomeState.initial().copyWith(
        currentStep: KioskWizardStep.submitOrder,
        imagesBatch: const LatteImageBatch(
          id: 'batch-1',
          orderId: 'valid-order',
          image0: image1,
          image1: image2,
          image2: image3,
          image3: image4,
          // parent is null
        ),
      ),
      act: (bloc) => bloc.add(const GoBackKioskWizard()),
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.chooseAnImage,
        ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'Normal steps -> navigates to previous step',
      build: KioskHomeBloc.new,
      seed: () => KioskHomeState.initial().copyWith(
        currentStep: KioskWizardStep.happyPlace,
      ),
      act: (bloc) => bloc.add(const GoBackKioskWizard()),
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.milkAndSweetener,
        ),
      ],
    );
  });

  group('KioskHomeBloc Server Updates & Subscriptions', () {
    blocTest<KioskHomeBloc, KioskHomeState>(
      'Transition from isHappyPlaceApproved true -> false fires '
      'HappyPlaceRejected',
      build: KioskHomeBloc.new,
      act: (bloc) async {
        bloc.add(
          const ApplyPreExistingOrder(
            LatteOrder(
              id: '1',
              name: 'Bob',
              milk: 'Oat',
              sweetener: 'Vanilla',
              happyPlace: 'beach',
            ),
            LatteOrderMetadata(id: '1', isHappyPlaceApproved: true),
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 50));

        metadataRepo.remoteSource.pushUpdate(
          '1',
          const LatteOrderMetadata(
            id: '1',
            isHappyPlaceApproved: false,
            happyPlaceModerationReason: 'Inappropriate',
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      skip: 2,
      expect: () => [
        isA<KioskHomeState>()
            .having(
              (s) => s.metadata?.isHappyPlaceApproved,
              'isHappyPlaceApproved',
              false,
            )
            .having((s) => s.order?.happyPlace, 'happyPlace', null)
            .having(
              (s) => s.happyPlaceModerationEvent?.reason,
              'reason',
              'Inappropriate',
            ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'Changing imageBatchId cancels previous subscription and starts watching '
      'new batch',
      build: KioskHomeBloc.new,
      act: (bloc) async {
        bloc.add(
          const ApplyPreExistingOrder(
            LatteOrder(id: '1'),
            LatteOrderMetadata(id: '1', imageBatchId: 'batch-1'),
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 50));

        // push update with new batch Id
        metadataRepo.remoteSource.pushUpdate(
          '1',
          const LatteOrderMetadata(id: '1', imageBatchId: 'batch-2'),
        );
        await Future<void>.delayed(const Duration(milliseconds: 50));

        // push to the new batch stream explicitly
        imagesRepo.remoteSource.pushUpdate(
          'batch-2',
          const LatteImageBatch(
            id: 'batch-2',
            orderId: '1',
            image0: image1,
            image1: image2,
            image2: image3,
            image3: image4,
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      skip: 2,
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.imagesBatch?.id,
          'imagesBatch.id',
          'batch-2',
        ),
      ],
    );
  });

  group('KioskHomeBloc Feature Commands', () {
    blocTest<KioskHomeBloc, KioskHomeState>(
      'SubmitUserName creates a brand new order if none exists',
      build: KioskHomeBloc.new,
      act: (bloc) => bloc.add(const SubmitUserName('Alice')),
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.isSubmitting,
          'isSubmitting',
          true,
        ),
        isA<KioskHomeState>()
            .having((s) => s.order?.name, 'order.name', 'Alice')
            .having((s) => s.order?.id, 'order.id', isNotNull)
            .having((s) => s.isSubmitting, 'isSubmitting', true),
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.milkAndSweetener,
        ),
        isA<KioskHomeState>().having(
          (s) => s.isSubmitting,
          'isSubmitting',
          false,
        ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'SubmitUserName updates existing order if one exists',
      build: KioskHomeBloc.new,
      seed: () => KioskHomeState.initial().copyWith(
        order: const LatteOrder(id: 'existing-id', name: 'Bob'),
      ),
      act: (bloc) => bloc.add(const SubmitUserName('Alice')),
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.isSubmitting,
          'isSubmitting',
          true,
        ),
        isA<KioskHomeState>()
            .having((s) => s.order?.name, 'order.name', 'Alice')
            .having((s) => s.order?.id, 'order.id', 'existing-id')
            .having((s) => s.isSubmitting, 'isSubmitting', true),
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.milkAndSweetener,
        ),
        isA<KioskHomeState>().having(
          (s) => s.isSubmitting,
          'isSubmitting',
          false,
        ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'AnswerQuestion correctly immutably updates the specific question',
      build: KioskHomeBloc.new,
      seed: () => KioskHomeState.initial().copyWith(
        questions: const [
          Question.multipleChoice(
            id: 'q1',
            body: 'Size?',
            acceptableAnswers: ['Small', 'Large'],
          ),
          Question(id: 'q2', body: 'Name?'),
        ],
      ),
      act: (bloc) => bloc.add(
        const AnswerQuestion(
          Question.multipleChoice(
            id: 'q1',
            body: 'Size?',
            acceptableAnswers: ['Small', 'Large'],
          ),
          'Large',
        ),
      ),
      expect: () => [
        isA<KioskHomeState>()
            .having(
              (s) => s.questions[0],
              'first question',
              isA<MultipleChoiceQuestion>().having(
                (q) => q.selectedValue,
                'selectedValue',
                'Large',
              ),
            )
            .having(
              (s) => s.questions[1],
              'second question',
              isA<TextQuestion>().having((q) => q.answer, 'answer', null),
            ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'GenerateRevisedImages sets isSubmitting to true and completes without '
      'error',
      build: KioskHomeBloc.new,
      seed: () => KioskHomeState.initial().copyWith(
        currentStep: KioskWizardStep.tweakImage,
        imagesBatch: const LatteImageBatch(
          id: 'batch-2',
          orderId: 'valid-order',
          image0: image1,
          image1: image2,
          image2: image3,
          image3: image4,
        ),
        selectedImageIndex: 1,
        questions: const [
          Question(id: 'q1', body: 'Q?'),
        ],
      ),
      act: (bloc) => bloc.add(const GenerateRevisedImages()),
      expect: () => [
        isA<KioskHomeState>().having(
          (s) => s.isSubmitting,
          'isSubmitting',
          true,
        ),
        isA<KioskHomeState>().having(
          (s) => s.imagesBatch,
          'imagesBatch',
          isNull,
        ),
        isA<KioskHomeState>().having(
          (s) => s.currentStep,
          'currentStep',
          KioskWizardStep.chooseATweakedImage,
        ),
        isA<KioskHomeState>().having(
          (s) => s.isSubmitting,
          'isSubmitting',
          false,
        ),
      ],
    );

    blocTest<KioskHomeBloc, KioskHomeState>(
      'RejectImageBatch sets isSubmitting to true and watches parent batch',
      build: KioskHomeBloc.new,
      seed: () => KioskHomeState.initial().copyWith(
        currentStep: KioskWizardStep.chooseATweakedImage,
        imagesBatch: const LatteImageBatch(
          id: 'batch-2',
          orderId: 'valid-order',
          image0: image1,
          image1: image2,
          image2: image3,
          image3: image4,
          parent: LatteImageBatchParent(
            id: 'batch-1',
            imageIndex: '0',
          ),
        ),
      ),
      act: (bloc) => bloc.add(const RejectImageBatch()),
      skip: 2,
      expect: () => [
        isA<KioskHomeState>()
            .having(
              (s) => s.currentStep,
              'currentStep',
              KioskWizardStep.chooseAnImage,
            )
            .having((s) => s.isSubmitting, 'isSubmitting', false),
      ],
    );
  });

  group('KioskHomeBloc Race Condition Protection', () {
    blocTest<KioskHomeBloc, KioskHomeState>(
      'Preserves local milk & sweetener choice if server update arrives with '
      'null values while at .milkAndSweetener step',
      build: KioskHomeBloc.new,
      seed: () => KioskHomeState.initial().copyWith(
        order: const LatteOrder(id: 'race-order', name: 'Bob'),
        currentStep: KioskWizardStep.milkAndSweetener,
      ),
      act: (bloc) async {
        // 1. Establish the stream by watching the order
        // In the real bloc, this happens in SubmitUserName or
        // ApplyPreExistingOrder.
        // We'll use the private _watchOrder if we can, or just trigger an
        // apply.
        bloc.add(
          const ApplyPreExistingOrder(
            LatteOrder(id: 'race-order', name: 'Bob'),
            LatteOrderMetadata(id: 'race-order'),
          ),
        );
        // Allow stream to be established
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // 2. User selects milk and sweetener locally
        bloc
          ..add(const SelectMilk('Oat'))
          ..add(const SelectSweetener('Vanilla'));

        // 3. Simulate server update arriving with null values for those fields
        orderRepo.remoteSource.pushUpdate(
          'race-order',
          const LatteOrder(
            id: 'race-order',
            name: 'Bob',
          ), // milk and sweetener are null
        );

        // Allow some time for the stream and microtasks
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      // Skip the initial ApplyPreExistingOrder states
      skip: 1,
      expect: () => [
        // Expect state from SelectMilk
        isA<KioskHomeState>().having((s) => s.order?.milk, 'milk', 'Oat'),
        // Expect state from SelectSweetener
        isA<KioskHomeState>()
            .having((s) => s.order?.milk, 'milk', 'Oat')
            .having((s) => s.order?.sweetener, 'sweetener', 'Vanilla'),
        // The server update should NOT emit a new state that changes these
        // back to null.
        // It might not emit any state if the resulting order is deemed
        // identical to current state.
      ],
      verify: (bloc) {
        expect(bloc.state.order?.milk, equals('Oat'));
        expect(bloc.state.order?.sweetener, equals('Vanilla'));
      },
    );
  });
}
