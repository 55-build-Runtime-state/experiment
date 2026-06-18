// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:data_layer/data_layer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';

part 'recent_orders_home_bloc.freezed.dart';

typedef _Emit = Emitter<RecentOrdersHomeState>;

/// {@template RecentOrdersHomeBloc}
/// {@endtemplate}
class RecentOrdersHomeBloc
    extends Bloc<RecentOrdersHomeEvent, RecentOrdersHomeState> {
  /// {@macro RecentOrdersHomeBloc}
  RecentOrdersHomeBloc({required this.numberOfImages})
    : super(RecentOrdersHomeState.initial()) {
    on<RecentOrdersHomeEvent>(
      (event, _Emit emit) => switch (event) {
        UpdatedRecentImages() => _onUpdatedRecentImages(event, emit),
        SetActiveImage() => _onSetActiveImage(event, emit),
      },
    );

    _recentImagesRepository = GetIt.I<Repository<RecentLatteImage>>();

    // TODO(craiglabenz): add server timestamps to ensure pulling the N newest
    // images
    // TODO(craiglabenz): add a limit to only pull N (probably 13 based on
    // Figma) most recent images
    final stream = _recentImagesRepository.watchList();

    _recentImagesSubscription = stream.listen((recentImages) {
      add(RecentOrdersHomeEvent.updatedRecentImages(recentImages));
    });
  }

  /// The number of recent images to display.
  final int numberOfImages;

  late final Repository<RecentLatteImage> _recentImagesRepository;
  late final StreamSubscription<List<RecentLatteImage>>
  _recentImagesSubscription;

  Future<void> _onUpdatedRecentImages(
    UpdatedRecentImages event,
    _Emit emit,
  ) async {
    List<RecentLatteImage> sortedImages = List<RecentLatteImage>.from(
      event.images,
    )..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    sortedImages = sortedImages.length > numberOfImages
        ? sortedImages.sublist(0, numberOfImages)
        : sortedImages;

    emit(state.copyWith(images: sortedImages));
  }

  void _onSetActiveImage(SetActiveImage event, _Emit emit) =>
      emit(state.copyWith(activeImage: event.activeImage));

  @override
  Future<void> close() {
    _recentImagesSubscription.cancel().ignore();
    return super.close();
  }
}

/// Actions that can be taken on the RecentOrdersHome page.
@Freezed()
sealed class RecentOrdersHomeEvent with _$RecentOrdersHomeEvent {
  /// New recent images have arrived from the server.
  const factory RecentOrdersHomeEvent.updatedRecentImages(
    List<RecentLatteImage> images,
  ) = UpdatedRecentImages;

  /// The user has toggled the active image. If the user has de-selected the
  /// active image, this value will be null.
  const factory RecentOrdersHomeEvent.setActiveImage(
    RecentLatteImage? activeImage,
  ) = SetActiveImage;
}

/// {@template RecentOrdersHomeState}
/// Complete representation of the RecentOrdersHome page's state.
/// {@endtemplate
@Freezed()
sealed class RecentOrdersHomeState with _$RecentOrdersHomeState {
  /// {@macro RecentOrdersHomeState}
  const factory RecentOrdersHomeState({
    @Default(<RecentLatteImage>[]) List<RecentLatteImage> images,
    RecentLatteImage? activeImage,
  }) = _RecentOrdersHomeState;
  const RecentOrdersHomeState._();

  /// Starter state fed to the [RecentOrdersHomeBloc].
  factory RecentOrdersHomeState.initial() => const RecentOrdersHomeState();
}
