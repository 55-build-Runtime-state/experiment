// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: use_if_null_to_convert_nulls_to_bools

import 'dart:async';

import 'package:data_layer/data_layer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genlatte/src/data/data.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

part 'kiosk_home_bloc.freezed.dart';

final _logger = Logger('KioskHomeBloc');

typedef _Emit = Emitter<KioskHomeState>;

/// State manager for the Kiosk home page.
class KioskHomeBloc extends Bloc<KioskHomeEvent, KioskHomeState> {
  /// {@macro KioskHomeBloc}
  KioskHomeBloc() : super(KioskHomeState.initial()) {
    on<KioskHomeEvent>((event, _Emit emit) {
      _logger.finer('Kiosk event: $event');
      return switch (event) {
        OnNewPage() => _onNewPage(event, emit),
        StartOver() => _onStartOver(event, emit),
        _EjectData() => _onEjectData(event, emit),
        LoadPreExistingOrders() => _onLoadPreExistingOrders(event, emit),
        ApplyPreExistingOrder() => _onApplyPreExistingOrder(event, emit),
        UpdateMilkOptions() => _onUpdateMilkOptions(event, emit),
        UpdateSweetenerOptions() => _onUpdateSweetenerOptions(event, emit),
        GoBackKioskWizard() => _onGoBackKioskWizard(event, emit),
        GoToStep() => _onGoToStep(event, emit),
        SubmitUserName() => _onSubmitUserName(event, emit),
        SelectMilk() => _onSelectMilk(event, emit),
        SelectSweetener() => _onSelectSweetener(event, emit),
        SubmitMilkAndSweetener() => _onSubmitMilkAndSweetener(event, emit),
        SubmitHappyPlace() => _onSubmitHappyPlace(event, emit),
        HappyPlaceRejected() => _onHappyPlaceRejected(event, emit),
        HappyPlaceModerationReasonShown() => _onHappyPlaceModerationReasonShown(
          event,
          emit,
        ),
        ServerOrderUpdate() => _onServerOrderUpdate(event, emit),
        ServerMetadataUpdate() => _onServerMetadataUpdate(event, emit),
        UpdateLatteImages() => _onUpdateLatteImages(event, emit),
        NewImageLatteBatch() => _onNewImageLatteBatch(event, emit),
        SelectImage() => _onSelectImage(event, emit),
        UpdateQuestions() => _onUpdateQuestions(event, emit),
        AnswerQuestion() => _onAnswerQuestion(event, emit),
        GenerateRevisedImages() => _onGenerateRevisedImages(event, emit),
        RejectImageBatch() => _onRejectImageBatch(event, emit),
        AcceptImage() => _onAcceptImage(event, emit),
        SubmitOrder() => _onSubmitOrder(event, emit),
      };
    });

    _orderRepository = GetIt.I<LatteOrdersRepository>();
    _metadataRepository = GetIt.I<Repository<LatteOrderMetadata>>();
    _imagesRepository = GetIt.I<Repository<LatteImageBatch>>();
    _optionsRepository = GetIt.I<Repository<LatteOptions>>();

    _orderRepository
        .getItems(
          details: RequestDetails.read(
            requestType: .allLocal,
          ),
        )
        .then((orders) {
          add(LoadPreExistingOrders(orders));
        })
        .ignore();

    _loadForStep(state.currentStep, null);
    _loadMilksAndSweeteners();
  }

  late final LatteOrdersRepository _orderRepository;
  late final Repository<LatteOrderMetadata> _metadataRepository;
  late final Repository<LatteImageBatch> _imagesRepository;
  late final Repository<LatteOptions> _optionsRepository;

  StreamSubscription<LatteOptions?>? _milkOptionsSubscription;
  StreamSubscription<LatteOptions?>? _sweetenerOptionsSubscription;
  StreamSubscription<LatteOrder?>? _orderSubscription;
  StreamSubscription<LatteOrderMetadata?>? _metadataSubscription;
  StreamSubscription<LatteImageBatch?>? _imageBatchSubscription;

  void _loadMilksAndSweeteners() {
    final milkOptionsStream = _optionsRepository.watch('milks');
    final sweetenerOptionsStream = _optionsRepository.watch('sweeteners');

    _milkOptionsSubscription ??= milkOptionsStream.listen(
      (milkOptions) {
        add(UpdateMilkOptions(milkOptions?.values));
      },
    );
    _sweetenerOptionsSubscription ??= sweetenerOptionsStream.listen(
      (sweetenerOptions) {
        add(UpdateSweetenerOptions(sweetenerOptions?.values));
      },
    );
  }

  Future<void> _onStartOver(StartOver event, _Emit emit) async {
    _logger.fine('_onStartOver() called');
    emit(state.copyWith(shouldClearData: true));
    _goToStep(.intro, emit);
  }

  Future<void> _onEjectData(_EjectData event, _Emit emit) async {
    _logger.fine('_onEjectData() called');

    // // Cancel any existing subscriptions
    await _orderSubscription?.cancel();
    await _metadataSubscription?.cancel();
    await _imageBatchSubscription?.cancel();

    // // Delete the order from local memory
    await _orderRepository.delete(
      state.order!.id!,
      RequestDetails.write(requestType: .local),
    );

    // // Reset the state
    emit(
      KioskHomeState.initial().copyWith(
        milkOptions: state.milkOptions,
        sweetenerOptions: state.sweetenerOptions,
      ),
    );
  }

  Future<void> _onLoadPreExistingOrders(
    LoadPreExistingOrders event,
    _Emit emit,
  ) async {
    _logger.fine('_onLoadPreExistingOrders() called');

    if (event.orders.isEmpty) {
      // No problem, but also nothing to do
      return;
    }
    if (event.orders.length > 1) {
      // There should only ever be one order at a time for the kiosk.
      // If there are more than one, then something is wrong.
      // If there are none, then we should start from the beginning.
      final deleteFutures = <Future<void>>[];
      for (final order in event.orders) {
        deleteFutures.add(
          _orderRepository.delete(
            order.id!,
            RequestDetails.write(requestType: .local),
          ),
        );
      }
      await Future.wait(deleteFutures);
      return;
    }

    final order = event.orders.first;

    // Load the metadata for the order; locally first, or from Firebase if we
    // do not get a cache hit locally.
    final metadata = await _metadataRepository.getById(order.id!);

    if (metadata == null) {
      // A cached order survived. Un-good.
      // Delete it and start over.
      await _orderRepository.delete(
        order.id!,
        RequestDetails.write(requestType: .local),
      );
      return;
    }
    add(ApplyPreExistingOrder(order, metadata));
  }

  Future<void> _onApplyPreExistingOrder(
    ApplyPreExistingOrder event,
    _Emit emit,
  ) async {
    _logger.fine('_onApplyPreExistingOrder() called with order ${event.order}');

    late KioskWizardStep stepToJumpTo;

    if (event.metadata.status == .submitted) {
      add(const StartOver());
      return;
    }

    _watchOrder(event.order);

    if (event.metadata.imageBatchId != null) {
      _watchImageBatch(event.metadata.imageBatchId!);
    }

    if (event.order.name == null) {
      stepToJumpTo = .name;
    } else if (event.order.milk == null || event.order.sweetener == null) {
      stepToJumpTo = .milkAndSweetener;
    } else if (event.order.happyPlace == null ||
        event.order.happyPlace!.isEmpty) {
      stepToJumpTo = .happyPlace;
    } else if (event.metadata.imageUrl != null) {
      stepToJumpTo = .submitOrder;
    }
    // From here on down, the user could have fallen into odd cracks, like
    // having submitted their happy place but not having received notice of the
    // resulting [LatteImageBatch]
    else {
      if (event.metadata.imageBatchId == null) {
        // Let the user re-submit this and resume.
        stepToJumpTo = .happyPlace;
      } else {
        // We are already watching the image batch Id, but we also need to load
        // that value immediately to figure out whether the user had made it all
        // the way to image tweaking, or just original image selection.
        final imageBatch = await _imagesRepository.getById(
          event.metadata.imageBatchId!,
        );
        if (imageBatch == null || imageBatch.parent == null) {
          stepToJumpTo = .chooseAnImage;
        } else {
          stepToJumpTo = .chooseATweakedImage;
        }
      }
    }

    emit(
      state.copyWith(
        order: event.order,
        metadata: event.metadata,
        currentStep: stepToJumpTo,
      ),
    );
  }

  void _onUpdateMilkOptions(UpdateMilkOptions event, _Emit emit) {
    _logger.fine(
      '_onUpdateMilkOptions() called '
      'with [${event.milkOptions?.join(', ')}]',
    );
    emit(state.copyWith(milkOptions: event.milkOptions));
  }

  void _onUpdateSweetenerOptions(UpdateSweetenerOptions event, _Emit emit) {
    _logger.fine(
      '_onUpdateSweetenerOptions() called '
      'with [${event.sweetenerOptions?.join(', ')}]',
    );
    emit(state.copyWith(sweetenerOptions: event.sweetenerOptions));
  }

  Future<void> _onGoBackKioskWizard(GoBackKioskWizard event, _Emit emit) async {
    _logger.fine(
      '_onGoBackKioskWizard() called from step .${state.currentStep.name}',
    );

    // First, handle special cases; then fall back to default logic of
    // navigating to the N-1 step.

    // First special case: going back from the Accept Order screen
    if (state.currentStep == .submitOrder) {
      final KioskWizardStep stepToGoBackTo = state.imagesBatch!.parent != null
          // If the parent is set, then the person ultimately choose a
          ? .chooseATweakedImage
          : .chooseAnImage;
      return add(GoToStep(stepToGoBackTo));
    } else if (state.currentStep == .chooseATweakedImage) {
      // A special `isSubmitting` update to lock down the forward button while
      // the server switches around the Order's image batch and we prepare to
      // navigate backwards. This will be cleared upon arriving at the new
      // wizard step.
      emit(state.copyWith(isSubmitting: true));

      // And now reject.
      return add(const RejectImageBatch());
    }

    final previousStep = state.currentStep.previousStep;
    if (previousStep == null) {
      return;
    }
    add(GoToStep(previousStep));
  }

  Future<void> _onGoToStep(GoToStep event, _Emit emit) async {
    _logger.fine('Explicitly navigating to .${event.step.name}');
    _goToStep(event.step, emit);
  }

  void _goToStep(KioskWizardStep step, _Emit emit) {
    _logger.fine('_goToStep() called with .${step.name}');
    emit(state.copyWith(currentStep: step));
    _loadForStep(step, emit);
  }

  Future<void> _onSubmitUserName(SubmitUserName event, _Emit emit) async {
    _logger.fine('_onSubmitUserName() called with name: "${event.name}"');

    if (event.name.isEmpty) {
      return;
    }

    if (event.name == state.order?.name) {
      _goToStep(.milkAndSweetener, emit);
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    final order =
        // The Order may already exist if moderation kicked the user back
        // to this step.
        state.order?.copyWith(name: event.name) ??
        // But if it does not already exist, which is the most common
        // scenario, then create one.
        LatteOrder(name: event.name);

    final savedOrder = await _orderRepository.setItem(order);
    emit(state.copyWith(order: savedOrder));
    _watchOrder(savedOrder);
    add(const GoToStep(.milkAndSweetener));
  }

  Future<void> _onSelectMilk(SelectMilk event, _Emit emit) async {
    _logger.fine('_onSelectMilk() called with milk: "${event.milk}"');
    assert(state.order != null, 'Order must exist when selecting milk');
    emit(state.copyWith(order: state.order!.copyWith(milk: event.milk)));
  }

  Future<void> _onSelectSweetener(SelectSweetener event, _Emit emit) async {
    _logger.fine(
      '_onSelectSweetener() called with sweetener: "${event.sweetener}"',
    );
    assert(state.order != null, 'Order must exist when selecting sweetener');
    emit(
      state.copyWith(order: state.order!.copyWith(sweetener: event.sweetener)),
    );
  }

  Future<void> _onSubmitMilkAndSweetener(
    SubmitMilkAndSweetener event,
    _Emit emit,
  ) async {
    _logger.fine('_onSubmitMilkAndSweetener() called');
    assert(
      state.order != null,
      'Order must exist when submitting milk and sweetener',
    );
    emit(state.copyWith(isSubmitting: true));
    final savedOrder = await _orderRepository.setItem(state.order!);
    emit(state.copyWith(order: savedOrder));
    add(const GoToStep(.happyPlace));
  }

  Future<void> _onSubmitHappyPlace(SubmitHappyPlace event, _Emit emit) async {
    _logger.fine(
      '_onSubmitHappyPlace() called with happy place: "${event.happyPlace}"',
    );
    assert(state.order != null, 'Order must exist when submitting happy place');

    // Check whether we're passing through again with an already-moderated
    // happy place.
    final isSameHappyPlace =
        state.metadata!.isHappyPlaceApproved == true &&
        event.happyPlace.isNotEmpty &&
        state.order!.happyPlace == event.happyPlace;

    if (!isSameHappyPlace) {
      emit(state.copyWith(isSubmitting: true));
      _imageBatchSubscription?.cancel().ignore();
      final order = state.order!.copyWith(happyPlace: event.happyPlace);
      emit(
        state.copyWith(
          imagesBatch: null,
          selectedImageIndex: null,
          imageGenerationStartTime: DateTime.now(),
        ),
      );
      final savedOrder = await _orderRepository.setItem(order);
      emit(state.copyWith(order: savedOrder));
    }

    return add(const GoToStep(.chooseAnImage));
  }

  void _onHappyPlaceRejected(HappyPlaceRejected event, _Emit emit) {
    _logger.info('Happy place rejected for reason: "${event.reason}"');
    emit(
      state.copyWith(
        order: state.order?.copyWith(happyPlace: null),
        happyPlaceModerationEvent: ModerationEvent(event.reason),
      ),
    );
    add(const GoToStep(.happyPlace));
  }

  void _onHappyPlaceModerationReasonShown(
    HappyPlaceModerationReasonShown event,
    _Emit emit,
  ) {
    _logger.finer('_onHappyPlaceModerationReasonShown() called');
    emit(state.copyWith(happyPlaceModerationEvent: null));
  }

  /// Opens a stream with Firebase to watch for changes to the [LatteOrder].
  void _watchOrder(LatteOrder? order) {
    _logger.fine('_watchOrder() called for order ${order?.id}');
    _orderSubscription?.cancel().ignore();
    _metadataSubscription?.cancel().ignore();
    if (order != null) {
      _logger.info('Watching Order Id ${order.id}');
      final orderStream = _orderRepository.watch(order.id!);
      _orderSubscription = orderStream.listen(_onNewOrderFromServer);

      // Order and Metadata share the same Id
      final metadataStream = _metadataRepository.watch(order.id!);
      _metadataSubscription = metadataStream.listen(_onNewMetadataFromServer);
    }
  }

  Future<void> _onNewOrderFromServer(LatteOrder? order) async {
    LatteOrder? serverOrder = order;
    _logger.finer('New LatteOrder from server: $serverOrder');

    if (serverOrder != null && state.currentStep == .milkAndSweetener) {
      // Catch a potential race condition where users progressing quickly from
      // the .name step and into the .milkAndSweetener step and immediately
      // setting a milk or sweetener value can sometimes have that value
      // overridden by the server if the initial value from the LatteOrder watch
      // stream is slow, and specifically, arrives after the user has already
      // begun modifying local state.
      //
      // There are no other known scenarios where this race condition can occur
      // because it is dependent on the relationship between initializing the
      // stream and then modifying local state before the first payload, which
      // is only known to be possible in this specific scenario.
      if (state.order?.milk != null && serverOrder.milk == null) {
        serverOrder = serverOrder.copyWith(milk: state.order!.milk);
      }
      if (state.order?.sweetener != null && serverOrder.sweetener == null) {
        serverOrder = serverOrder.copyWith(sweetener: state.order!.sweetener);
      }
    }

    add(ServerOrderUpdate(serverOrder));
    if (order == null) {
      _onNewMetadataFromServer(null).ignore();
    }
  }

  /// Handler for when [LatteOrderMetadata] objects arrive from the server.
  ///
  /// This function applies fields expected to spontaneously change from the
  /// server (typically moderation results). It does not meticulously examine
  /// every field (like `questions`), which are expected to be set in advance
  /// by the server and not randomly updated thereafter.
  Future<void> _onNewMetadataFromServer(LatteOrderMetadata? metadata) async {
    _logger.finer('New LatteOrderMetadata from server: $metadata');
    if (metadata != null) {
      if (metadata.imageBatchId != state.metadata?.imageBatchId) {
        _watchImageBatch(metadata.imageBatchId!);
      }
      if (state.metadata != null) {
        if (state.metadata!.isHappyPlaceApproved != true &&
            metadata.isHappyPlaceApproved == true) {
          _logger.fine('Happy place APPROVED by moderation');
        } else if (state.metadata!.isHappyPlaceApproved != false &&
            metadata.isHappyPlaceApproved == false) {
          _logger.fine('Happy place REJECTED by moderation');
          add(
            HappyPlaceRejected(
              metadata.happyPlaceModerationReason ??
                  'This value did not pass moderation.',
            ),
          );
        } else if (metadata.imageUrl != null &&
            state.metadata!.imageUrl != metadata.imageUrl) {
          _logger.fine('Image URL has been accepted for Order ${metadata.id}');
          add(const GoToStep(.submitOrder));
        } else if (state.metadata!.status != .submitted &&
            metadata.status == .submitted) {
          _logger.fine('Order ${metadata.id} submitted');
          add(const GoToStep(.confirmation));
        }
      }
    }
    add(ServerMetadataUpdate(metadata));
  }

  void _watchImageBatch(String imageBatchId) {
    _logger.fine('_watchImageBatch() called with imageBatchId=$imageBatchId');
    if (imageBatchId == state.imagesBatch?.id) {
      _logger.fine('Already watching LatteImageBatch $imageBatchId');
      return;
    }
    _imageBatchSubscription?.cancel().ignore();
    _logger.fine('Watching ImageBatch Id: $imageBatchId');
    final imagesStream = _imagesRepository.watch(imageBatchId);
    _imageBatchSubscription = imagesStream.listen((batch) {
      add(UpdateLatteImages(batch));
    });

    // Finally add the event for broader reactions to this change.
    add(NewImageLatteBatch(imageBatchId));
  }

  void _onServerOrderUpdate(ServerOrderUpdate event, _Emit emit) {
    _logger.finer(
      '_onServerOrderUpdate() called with order.id=${event.order?.id}',
    );
    if (event.order != null) {
      emit(state.copyWith(order: event.order));
    } else {
      add(const StartOver());
    }
  }

  void _onServerMetadataUpdate(ServerMetadataUpdate event, _Emit emit) {
    _logger.finer('_onServerMetadataUpdate() called');
    emit(state.copyWith(metadata: event.metadata));
  }

  void _onUpdateLatteImages(UpdateLatteImages event, _Emit emit) {
    _logger.finer(
      '_onUpdateLatteImages() called with batch.id=${event.batch?.id}',
    );
    if (state.awaitingQuestions) {
      final questionsUsedToBeMissing =
          state.imagesBatch?[state.selectedImageIndex!]!.questions == null;
      final questionsAreNowAvailable =
          event.batch?[state.selectedImageIndex!]!.questions != null;

      if (questionsUsedToBeMissing && questionsAreNowAvailable) {
        _logger.fine(
          'Questions are now available for Image ${state.selectedImageIndex}',
        );
        _loadQuestions(event.batch);
      }
    }
    emit(state.copyWith(imagesBatch: event.batch));
  }

  void _onNewImageLatteBatch(NewImageLatteBatch event, _Emit emit) {
    _logger.finer(
      '_onNewImageLatteBatch() called with id: ${event.latteImageBatchId}',
    );
    if (state.currentStep == .tweakImage) {
      _logger.fine(
        'Navigating to .chooseATweakedImage after answering questions',
      );
      emit(state.copyWith(isSubmitting: false, selectedImageIndex: null));
      add(const GoToStep(.chooseATweakedImage));
    } else if (state.currentStep == .chooseATweakedImage) {
      emit(state.copyWith(selectedImageIndex: null));
    }
  }

  void _onUpdateQuestions(UpdateQuestions event, _Emit emit) {
    _logger.info(
      'Loaded questions for index ${state.selectedImageIndex} :: '
      '${event.questions.length} questions',
    );
    emit(
      state.copyWith(
        questions: event.questions,
        awaitingQuestions: event.questions.isEmpty,
      ),
    );
  }

  void _onAnswerQuestion(AnswerQuestion event, _Emit emit) {
    _logger.fine(
      '_onAnswerQuestion() called for question ${event.question.id} '
      'with answer: ${event.answer}',
    );
    for (final (index, question) in state.questions.indexed) {
      if (question.id == event.question.id) {
        final questions = List<Question>.from(
          state.questions,
        );
        questions[index] = questions[index].copyWithAnswer(event.answer);
        emit(state.copyWith(questions: questions));
        return;
      }
    }
    _logger.warning('Question not found: ${event.question.id}');
  }

  Future<void> _onGenerateRevisedImages(
    GenerateRevisedImages event,
    _Emit emit,
  ) async {
    _logger.finer('_onGenerateRevisedImages() called');
    emit(
      state.copyWith(
        isSubmitting: true,
        imageGenerationStartTime: DateTime.now(),
      ),
    );

    final answers = state.questions.fold(
      <String, Object?>{},
      (acc, question) {
        acc[question.id] = question.answer;
        return acc;
      },
    );
    final imageIndex = switch (state.selectedImageIndex!) {
      0 => 'image0',
      1 => 'image1',
      2 => 'image2',
      3 => 'image3',
      _ => throw Exception(
        'Unexpected image index: ${state.selectedImageIndex}',
      ),
    };
    _logger.info(
      'Generating revised images for ${state.imagesBatch!.id}.$imageIndex with '
      'answers: $answers',
    );
    _orderRepository
        .generateRevisedImages(
          imageBatchId: state.imagesBatch!.id,
          imageIndex: imageIndex,
          answers: answers,
        )
        .then((_) {})
        .catchError((Object error) {
          _logger.severe('Failed to generate revised images: $error');
          emit(state.copyWith(isSubmitting: false));
          if (state.currentStep != .tweakImage) {
            // If the function fails, return to this step should we have
            // navigated forward.
            add(const GoToStep(.tweakImage));
          }
        })
        .ignore();

    emit(state.copyWith(imagesBatch: null));
    // Optimistically navigate forward.
    add(const GoToStep(.chooseATweakedImage));
  }

  Future<void> _onRejectImageBatch(RejectImageBatch event, _Emit emit) async {
    _logger.finer('_onRejectImageBatch() called');
    assert(
      state.imagesBatch?.parent != null,
      'Should not be reverting images without an ImageBatch with a parent',
    );

    emit(state.copyWith(isReverting: true));
    await _orderRepository.rejectImageBatch(state.imagesBatch!.id);
    _watchImageBatch(state.imagesBatch!.parent!.id);
    add(const GoToStep(.chooseAnImage));
  }

  void _onAcceptImage(AcceptImage event, _Emit emit) {
    _logger.finer('_onAcceptImage() called');
    assert(
      state.selectedImageIndex != null,
      'Should not be accepting images without a selected image',
    );

    // Check whether we're passing through again with an already-accepted
    // image.
    if (state.metadata!.imageUrl != null &&
        state.metadata!.imageUrl ==
            state.imagesBatch![state.selectedImageIndex!]?.imageUrl) {
      return add(const GoToStep(.submitOrder));
    }

    emit(state.copyWith(isSubmitting: true));
    _orderRepository
        .acceptImage(
          imageBatchId: state.imagesBatch!.id,
          imageIndex: switch (state.selectedImageIndex!) {
            0 => 'image0',
            1 => 'image1',
            2 => 'image2',
            3 => 'image3',
            _ => throw Exception(
              'Unexpected image index: ${state.selectedImageIndex}',
            ),
          },
        )
        .then((_) {
          _logger.fine('Image accepted and order submitted for moderation');
        })
        .catchError((Object error) {
          _logger.severe('Failed to accept image and submit order: $error');
          emit(state.copyWith(isSubmitting: false));
        })
        .ignore();
  }

  Future<void> _onSubmitOrder(SubmitOrder event, _Emit emit) async {
    _logger.finer('_onSubmitOrder() called');
    assert(
      state.metadata?.imageUrl != null,
      'Should not be submitting order without an image',
    );
    emit(state.copyWith(isSubmitting: true));
    await _orderRepository
        .submitOrder(state.metadata!.id!)
        .then((_) {
          _logger.fine('Order ${state.metadata!.id} submitted');
        })
        .catchError((Object error) {
          _logger.severe('Failed to submit order: $error');
          emit(state.copyWith(isSubmitting: false));
        });
  }

  void _onNewPage(OnNewPage event, _Emit emit) {
    _logger.finer('_onNewPage() called with .${event.newStep.name}');
    switch (event.newStep) {
      case KioskWizardStep.intro:
        if (state.shouldClearData) {
          add(const _EjectData());
        }
      case KioskWizardStep.name ||
          KioskWizardStep.milkAndSweetener ||
          KioskWizardStep.happyPlace ||
          KioskWizardStep.chooseAnImage ||
          KioskWizardStep.tweakImage ||
          KioskWizardStep.chooseATweakedImage ||
          KioskWizardStep.submitOrder ||
          KioskWizardStep.confirmation:
        // TODO(craiglabenz): Uncomment this after testing milk resetting bug
        // (https://github.com/GoogleCloudDemos/gcdemos-26-int-dd-latteart/issues/198)
        // if (state.shouldClearData) {
        //   emit(state.copyWith(shouldClearData: false));
        // }
        break;
    }
  }

  /// [emit] is nullable because when this is called during absolute
  /// initialization, an emitter function is both unavailable and we do not need
  /// to worry about clearing the `isSubmitting` field.
  void _loadForStep(KioskWizardStep step, _Emit? emit) {
    if (state.isSubmitting || state.isReverting) {
      // The one thing we know is that, upon arriving at a new step, we are no
      // longer submitting whatever data concluded the previous step.
      emit?.call(state.copyWith(isSubmitting: false, isReverting: false));
    }
    switch (step) {
      case KioskWizardStep.intro:
        break;
      case KioskWizardStep.name:
        break;
      case KioskWizardStep.milkAndSweetener:
        break;
      case KioskWizardStep.happyPlace:
        break;
      case KioskWizardStep.chooseAnImage:
        break;
      case KioskWizardStep.tweakImage:
        _loadQuestions();
      case KioskWizardStep.chooseATweakedImage:
        break;
      case KioskWizardStep.submitOrder:
        break;
      case KioskWizardStep.confirmation:
        break;
    }
  }

  /// Sends questions from the selected image to the UI.
  ///
  /// Optionally pass a specific batch to use if the server has just sent an
  /// updated version of the image batch which we know freshly contains these
  /// very questions that we care about. Otherwise, read from the existing
  /// state variable.
  void _loadQuestions([LatteImageBatch? batch]) {
    final batchToUse = batch ?? state.imagesBatch;
    if (batchToUse != null && state.selectedImageIndex != null) {
      final images = batchToUse.images.toList();
      final selectedImage = images[state.selectedImageIndex!];
      if (selectedImage?.questions != null) {
        add(UpdateQuestions(selectedImage!.questions!));
        return;
      }
    }
    add(const UpdateQuestions([]));
  }

  void _onSelectImage(SelectImage event, _Emit emit) {
    _logger.fine('_onSelectImage() called with index: ${event.index}');
    emit(state.copyWith(selectedImageIndex: event.index));
  }

  @override
  Future<void> close() {
    _milkOptionsSubscription?.cancel().ignore();
    _sweetenerOptionsSubscription?.cancel().ignore();
    _orderSubscription?.cancel().ignore();
    _metadataSubscription?.cancel().ignore();
    _imageBatchSubscription?.cancel().ignore();
    return super.close();
  }
}

/// Actions that can be taken on the KioskHome page.
@Freezed()
sealed class KioskHomeEvent with _$KioskHomeEvent {
  /// A new page is being shown. Called once at the beginning of a new page's
  /// animation into the screen.
  const factory KioskHomeEvent.onNewPage(KioskWizardStep newStep) = OnNewPage;

  /// Sends the user back to the intro screen and sets a flag which will
  /// cause any existing orders to be ejected from memory when the user arrives
  /// there.
  const factory KioskHomeEvent.startOver() = StartOver;

  /// An internal event thrown after [StartOver].
  const factory KioskHomeEvent.ejectData() = _EjectData;

  /// Possibly triggered on start-up if an existing, partially finished
  /// [LatteOrder] is found locally. This allows a restarted browser to not lose
  /// progress.
  const factory KioskHomeEvent.loadPreExistingOrders(
    List<LatteOrder> orders,
  ) = LoadPreExistingOrders;

  /// Overwrites all state for a given order; used to resume progress after
  /// [LoadPreExistingOrders] has succeeded.
  const factory KioskHomeEvent.applyPreExistingOrder(
    LatteOrder order,
    LatteOrderMetadata metadata,
  ) = ApplyPreExistingOrder;

  /// Refreshed milk options have arrived from the server.
  const factory KioskHomeEvent.updateMilkOptions(
    List<LatteOption>? milkOptions,
  ) = UpdateMilkOptions;

  /// Refreshed sweetener options have arrived from the server.
  const factory KioskHomeEvent.updateSweetenerOptions(
    List<LatteOption>? sweetenerOptions,
  ) = UpdateSweetenerOptions;

  /// Locally set the user's preferred milk.
  const factory KioskHomeEvent.selectMilk(String milk) = SelectMilk;

  /// Locally set the user's preferred sweetener.
  const factory KioskHomeEvent.selectSweetener(String sweetener) =
      SelectSweetener;

  /// Submit the user's milk and sweetener preferences.
  const factory KioskHomeEvent.submitMilkAndSweetener() =
      SubmitMilkAndSweetener;

  /// Submit the user's happy place.
  const factory KioskHomeEvent.submitHappyPlace(String happyPlace) =
      SubmitHappyPlace;

  /// Gemini has rejected the user's happy place.
  const factory KioskHomeEvent.happyPlaceRejected(String reason) =
      HappyPlaceRejected;

  /// The user has been shown the happy place moderation reason, meaning we can
  /// clear it from the state so it isn't shown on every subsequent change.
  const factory KioskHomeEvent.happyPlaceModerationReasonShown() =
      HappyPlaceModerationReasonShown;

  /// The [LatteOrder] has been updated by the server.
  const factory KioskHomeEvent.serverOrderUpdate(LatteOrder? order) =
      ServerOrderUpdate;

  /// The [LatteOrderMetadata] has been updated by the server.
  const factory KioskHomeEvent.serverMetadataUpdate(
    LatteOrderMetadata? metadata,
  ) = ServerMetadataUpdate;

  /// Go back to the previous step in the wizard.
  const factory KioskHomeEvent.goBack() = GoBackKioskWizard;

  /// Go to a specific step in the wizard.
  const factory KioskHomeEvent.goToStep(KioskWizardStep step) = GoToStep;

  /// Submit the user's name.
  const factory KioskHomeEvent.submitUserName(String name) = SubmitUserName;

  /// The user has selected an image from within the batch. Note that
  /// this only amounts to tapping on the image. It does not mean the image
  /// has been fully accepted for a submitted order.
  const factory KioskHomeEvent.selectImage(int index) = SelectImage;

  /// The server has updated the [LatteImageBatch] that is being watched. Note
  /// that this is different from the server changing *which* [LatteImageBatch]
  /// is being watched. For that event, see [NewImageLatteBatch].
  const factory KioskHomeEvent.updateLatteImages(LatteImageBatch? batch) =
      UpdateLatteImages;

  /// An update to the watched [LatteOrderMetadata] object has returned a new
  /// [LatteImageBatch] id. This is different from changes to the currently
  /// watched [LatteImageBatch] id. For that, see [UpdateLatteImages].
  const factory KioskHomeEvent.newImageLatteBatch(String latteImageBatchId) =
      NewImageLatteBatch;

  /// Update the list of available questions from a selected image. This fires
  /// when the user selects an image to tweak.
  const factory KioskHomeEvent.updateQuestions(List<Question> questions) =
      UpdateQuestions;

  /// Saves a user's answer to a question.
  const factory KioskHomeEvent.answerQuestion(
    Question question,
    Object? answer,
  ) = AnswerQuestion;

  /// Sends the user's answers to the questions to the backend to generate
  /// new images. If this call to the server is successful, a
  /// [NewImageLatteBatch] event is expected in short order.
  const factory KioskHomeEvent.generateRevisedImages() = GenerateRevisedImages;

  /// The user has rejected the revised images.
  const factory KioskHomeEvent.rejectImageBatch() = RejectImageBatch;

  /// The user has accepted their selected image.
  const factory KioskHomeEvent.acceptImage() = AcceptImage;

  /// The user has submitted their finalized order.
  const factory KioskHomeEvent.submitOrder() = SubmitOrder;
}

/// {@template KioskHomeState}
/// Complete representation of the KioskHome page's state.
/// {@endtemplate
@Freezed()
abstract class KioskHomeState with _$KioskHomeState {
  /// {@macro KioskHomeState}
  const factory KioskHomeState({
    required KioskWizardStep currentStep,
    LatteOrder? order,
    LatteOrderMetadata? metadata,
    ModerationEvent? happyPlaceModerationEvent,
    @Default(false) bool isSubmitting,
    @Default(false) bool isReverting,

    /// When the user submits a happy place, or a tweak,
    /// the clock starts ticking on image generation.
    /// We want to track this time. If for nothing else, it helps us show
    /// a progress bar that doesn't depend on widget states being mounted
    /// throughout the image generation without gaps.
    DateTime? imageGenerationStartTime,

    /// When an image's questions are requested before they exist, we store the
    /// need here so that we add them to the state once they arrive.
    @Default(false) bool awaitingQuestions,

    /// The current batch of 4 images to choose from. This is deduced by the
    /// [LatteOrderMetadata]'s `latteBatchId` field.
    LatteImageBatch? imagesBatch,

    /// Copy of the active [LatteImage]'s questions, only set once the user
    /// chooses an image and clicks the "tweak image" button. This copy is used
    /// instead of the questions in the [LatteImage] to isolate the user's
    /// answers from changes to the [LatteImageBatch]. The critical detail is
    /// that answers are not persisted to Firebase, which means anything that
    /// overwrites the [LatteImageBatch] would clobber the user's answers.
    @Default([]) List<Question> questions,

    /// Values loaded straight from Firebase.
    @LatteOptionConverter() List<LatteOption>? milkOptions,

    /// Values loaded straight from Firebase.
    @LatteOptionConverter() List<LatteOption>? sweetenerOptions,

    /// True if the user is starting over and we want to eject data upon
    /// returning to the .intro screen.
    @Default(false) bool shouldClearData,

    int? selectedImageIndex,
  }) = _KioskHomeState;
  const KioskHomeState._();

  /// Starter state fed to the [KioskHomeBloc].
  factory KioskHomeState.initial() => KioskHomeState(
    currentStep: KioskWizardStep.values.first,
  );
}

/// The steps in the kiosk wizard.
enum KioskWizardStep {
  /// Establishing expectations / describing the process.
  intro,

  /// Collecting the user's name.
  name,

  /// Collecting the user's milk / sweetener preferences.
  milkAndSweetener,

  /// Collecting the user's happy place.
  happyPlace,

  /// The user's first time choosing 1 of 4 images
  chooseAnImage,

  /// Answer Gemini's questions to configure the image
  tweakImage,

  /// Similar to [chooseAnImage], but with extra awareness that this is a forked
  /// image batch which the user could outright reject
  chooseATweakedImage,

  /// Order review screen where the user submits their order.
  submitOrder,

  /// Post-submission confirmation screen to conclude the user's journey.
  confirmation,
  ;

  /// The current step's place in line.
  int get stepIndex => values.indexOf(this);

  /// Returns the given step's next step.
  KioskWizardStep? get nextStep {
    final index = stepIndex;
    if (index >= totalSteps) {
      return null;
    }
    return fromIndex(index + 1);
  }

  /// Returns the given step's previous step.
  KioskWizardStep? get previousStep {
    final index = stepIndex;
    if (index <= 0) {
      return null;
    }
    return fromIndex(index - 1);
  }

  /// The step at the given index.
  static KioskWizardStep fromIndex(int index) => values[index];

  /// True if this is the first step.
  bool get isFirstStep => this == values.first;

  /// True if this is the last step.
  bool get isLastStep => this == values.last;

  /// The total number of steps in the wizard.
  int get totalSteps => values.length;

  /// The index to use for the progress indicator.
  int get progressIndicatorIndex => switch (this) {
    KioskWizardStep.intro => 0,
    KioskWizardStep.name => 0,
    KioskWizardStep.milkAndSweetener => 1,
    KioskWizardStep.happyPlace => 2,
    KioskWizardStep.chooseAnImage => 2,
    KioskWizardStep.tweakImage => 2,
    KioskWizardStep.chooseATweakedImage => 2,
    KioskWizardStep.submitOrder => 3,
    KioskWizardStep.confirmation => 3,
  };
}

/// Bundles a server moderation reason with a Uuidv4 which is used to help
/// the UI display only 1 toast per moderation event.
@immutable
class ModerationEvent {
  /// Instantiates a [ModerationEvent].
  ModerationEvent(this.reason) : id = const Uuid().v4();

  /// The moderation reason.
  final String reason;

  /// Unique Id.
  final String id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModerationEvent &&
          runtimeType == other.runtimeType &&
          reason == other.reason &&
          id == other.id;

  @override
  int get hashCode => reason.hashCode ^ id.hashCode;
}
