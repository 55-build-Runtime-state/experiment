// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:data_layer/data_layer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'latte_order.freezed.dart';
part 'latte_order.g.dart';

/// One person's coffee order. Only contains fields the user may freely update.
/// Once a person
@freezed
abstract class LatteOrder with _$LatteOrder {
  /// Creates a new [LatteOrder].
  const factory LatteOrder({
    /// Firestore-generated document Id. Not a user-friendly identifier.
    String? id,

    /// The name of the person ordering.
    String? name,

    /// The coffee's milk type.
    ///
    /// Null value for milk is not possible for a valid order, but is the
    /// default order because the user must select a milk (as opposed to having
    /// a default milk that they might overlook changing).
    String? milk,

    /// The coffee's sweetener type, if any.
    ///
    /// Null value for sweetener IS possible because no sweetener is allowed.
    String? sweetener,

    /// The prompt for the user's generated image.
    String? happyPlace,
  }) = _LatteOrder;

  const LatteOrder._();

  /// Json deserializer for [LatteOrder].
  factory LatteOrder.fromJson(Map<String, Object?> json) =>
      _$LatteOrderFromJson(json);

  /// Data Layer bindings for [LatteOrder].
  static Bindings<LatteOrder> bindings = Bindings<LatteOrder>(
    fromJson: LatteOrder.fromJson,
    toJson: (obj) => obj.toJson(),
    getId: (obj) => obj.id,
    getDetailUrl: (id) => ApiUrl(path: 'latteOrders/$id'),
    getListUrl: () => const ApiUrl(path: 'latteOrders'),
  );
}

/// Server-controlled information about a person's order which is not directly
/// editable by the user. Automated processes advance these values as the order
/// progresses through the pipeline.
///
/// Security rules prevent this document from being written to by the client.
@freezed
abstract class LatteOrderMetadata with _$LatteOrderMetadata {
  /// Creates a new [LatteOrderMetadata].
  const factory LatteOrderMetadata({
    /// Firestore-generated document Id. Not a user-friendly identifier.
    /// This value is guaranteed to be the same as the corresponding
    /// [LatteOrder.id].
    String? id,

    /// Sequential order number, set by the server and visible in the queue.
    int? orderNumber,

    /// Gemini sets this to false or true upon moderation. Baristas optionally
    /// set this to true when advancing an order's status to
    /// [LatteOrderStatus.validated]. Additionally, a value of `true` is
    /// required for this user's name to be shown on the big boards.
    bool? isNameApproved,

    /// Gemini sets this to false or true upon moderation. Image generation is
    /// gated by Gemini setting this value to `true`. Later, baristas may
    /// override this to `false` when advancing an order's status to
    /// [LatteOrderStatus.validated]. If a barista does this, the user will
    /// receive a fallback image on their latte.
    bool? isHappyPlaceApproved,

    /// The reason Gemini rejected the user's happy place prompt. If the image
    /// was moderated by the barista, then this value should say
    /// "barista_moderation".
    String? happyPlaceModerationReason,

    /// Set to true once a barista provides final manual approval of the image.
    /// This value must be true for an [LatteOrder] to advance to
    /// [LatteOrderStatus.inProgress].
    bool? isImageApproved,

    /// The active image batch.
    String? imageBatchId,

    /// Set once the user has committed to an image.
    String? imageUrl,

    /// The reason an order was sent back from [LatteOrderStatus.submitted] to
    /// [LatteOrderStatus.configuring] instead of being accepted and advanced to
    /// [LatteOrderStatus.validated].
    // LatteOrderValidationError? validationError,

    /// {@macro LatteOrderStatus}
    @Default(LatteOrderStatus.configuring) LatteOrderStatus status,

    /// Set to non-null once a barista claims the order.
    String? baristaId,

    /// Set once the order status reaches [LatteOrderStatus.submitted].
    DateTime? orderSubmittedTime,

    /// Set once the order status reaches [LatteOrderStatus.completed].
    DateTime? completionTime,
  }) = _LatteOrderMetadata;

  const LatteOrderMetadata._();

  /// Json deserializer for [LatteOrderMetadata].
  factory LatteOrderMetadata.fromJson(Map<String, Object?> json) =>
      _$LatteOrderMetadataFromJson(json);

  /// Data Layer bindings for [LatteOrderMetadata].
  static Bindings<LatteOrderMetadata> bindings = Bindings<LatteOrderMetadata>(
    fromJson: LatteOrderMetadata.fromJson,
    toJson: (obj) => obj.toJson(),
    getId: (obj) => obj.id,
    getDetailUrl: (id) => ApiUrl(path: 'latteOrderMetadata/$id'),
    getListUrl: () => const ApiUrl(path: 'latteOrderMetadata'),
  );

  /// Validates that the order and metadata are valid for the given status.
  ///
  /// The idea is that the Order and its metadata have just been updated,
  /// presumably including a new `metadata.status` value, and we want to make
  /// sure that everything is as expected before saving this new value. A
  /// non-null return value from this method should cause the calling code to
  /// abort any save operations and return to the previous [LatteOrder] object.
  LatteOrderValidationError? validate(LatteOrder order) {
    switch (status) {
      case .configuring:
        return null;
      case .submitted:
        if (order.milk == null) {
          return .missingMilk;
        }
        if (order.sweetener == null) {
          return .missingSweetener;
        }
        if (imageUrl == null) {
          return .imageNotSet;
        }
        return null;
      case .validated || .inProgress || .completed || .archived:
        return null;
    }
  }
}

/// Container for a [LatteOrder] and [LatteOrderMetadata]. This is not a
/// server-side construct and only exists on the client to pair a related order
/// and its metadata.
@freezed
abstract class Latte with _$Latte {
  /// Creates a new [Latte].
  const factory Latte({
    required LatteOrder order,
    required LatteOrderMetadata metadata,
  }) = _Latte;

  const Latte._();

  /// Json deserializer for [Latte].
  factory Latte.fromJson(Map<String, Object?> json) => _$LatteFromJson(json);
}

/// {@template LatteOrderStatus}
/// The delivery progress of an [LatteOrder].
/// {@endtemplate}
enum LatteOrderStatus {
  /// The order is in the database but not yet verified and submitted. These
  /// orders are not visible to baristas.
  configuring,

  /// Order now successfully submitted, but not yet validated.
  submitted,

  /// Order has been accepted by the server but is not yet picked up by a
  /// barista.
  validated,

  /// A barista has started working on the order.
  inProgress,

  /// The order has been completed and is ready for pickup.
  completed,

  /// The order has been completed a long time ago and we should not
  /// be downloading it from the repository in most cases.
  archived,
}

/// Ways an [LatteOrder] can fail validation.
enum LatteOrderValidationError {
  /// The order is missing a milk type but attempted to enter status
  /// [LatteOrderStatus.submitted].
  missingMilk,

  /// The latte order is missing a sweetener but attempted to enter status
  /// [LatteOrderStatus.submitted].
  missingSweetener,

  /// The order image has not been set but attempted to enter status
  /// [LatteOrderStatus.submitted].
  imageNotSet,
}

/// Operations for lists of [LatteOrderMetadata] objects.
extension LatteOrderMetadataList on List<LatteOrderMetadata> {
  /// Converts the list of orders into a map keyed by order id.
  Map<String, LatteOrderMetadata> toIdsMap() {
    return fold<Map<String, LatteOrderMetadata>>(
      {},
      (map, order) {
        map[order.id!] = order;
        return map;
      },
    );
  }
}
