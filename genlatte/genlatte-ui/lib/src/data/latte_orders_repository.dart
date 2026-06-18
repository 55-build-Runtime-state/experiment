// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:data_layer/data_layer.dart';
import 'package:data_layer_hive/data_layer_hive.dart';
import 'package:genlatte/src/sources/firestore_source.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';

/// {@template GenerateRevisedImages}
/// Signature to answer Gemini's questions and generate revised images.
/// {@endtemplate}
typedef GenerateRevisedImages =
    Future<void> Function({
      required String imageBatchId,
      required String imageIndex, // {image0, image1, image2, or image3}
      required Map<String, Object?> answers,
    });

/// {@template RejectImageBatch}
/// Signature to reject a revised image batch and return to its parent.
/// {@endtemplate}
typedef RejectImageBatch = Future<void> Function(String imageBatchId);

/// {@template AcceptImage}
/// Signature to accept an image.
/// {@endtemplate}
typedef AcceptImage =
    Future<void> Function({
      required String imageBatchId,
      required String imageIndex,
    });

/// {@template SubmitOrder}
/// Signature to advance an order to the "submitted" status.
/// {@endtemplate}
typedef SubmitOrder = Future<void> Function(String orderId);

/// {@template SendToPrinters}
/// Signature to send an image to the printers.
/// {@endtemplate}
typedef SendToPrinters =
    Future<void> Function({
      required String imagePath,
      required String machineName,
    });

/// {@template CompleteOrder}
/// Signature to complete an order.
/// {@endtemplate}
typedef CompleteOrder =
    Future<void> Function({
      required String orderId,
      required String baristaId,
    });

/// Repository for [LatteOrder].
class LatteOrdersRepository extends Repository<LatteOrder> {
  /// Creates a new [LatteOrdersRepository].
  LatteOrdersRepository({
    required AcceptImage acceptImage,
    required CompleteOrder completeOrder,
    required GenerateRevisedImages generateRevisedImages,
    required RejectImageBatch rejectImageBatch,
    required SendToPrinters sendToPrinters,
    required SubmitOrder submitOrder,
  }) : _acceptImage = acceptImage,
       _completeOrder = completeOrder,
       _generateRevisedImages = generateRevisedImages,
       _rejectImageBatch = rejectImageBatch,
       _sendToPrinters = sendToPrinters,
       _submitOrder = submitOrder,
       super(
         SourceList<LatteOrder>(
           bindings: LatteOrder.bindings,
           sources: <Source<LatteOrder>>[
             HiveSource<LatteOrder>(
               hiveInit: GetIt.I<HiveInitializer>().ready,
               bindings: LatteOrder.bindings,
             ),
             FirestoreSource<LatteOrder>(
               GetIt.I<FirebaseFirestore>(),
               bindings: LatteOrder.bindings,
             ),
           ],
         ),
       );

  /// {@macro AcceptImage}
  Future<void> acceptImage({
    required String imageBatchId,
    required String imageIndex,
  }) => _acceptImage(imageBatchId: imageBatchId, imageIndex: imageIndex);
  final AcceptImage _acceptImage;

  /// {@macro CompleteOrder}
  Future<void> completeOrder({
    required String orderId,
    required String baristaId,
  }) => _completeOrder(orderId: orderId, baristaId: baristaId);
  final CompleteOrder _completeOrder;

  /// {@macro GenerateRevisedImages}
  Future<void> generateRevisedImages({
    required String imageBatchId,
    required String imageIndex,
    required Map<String, Object?> answers,
  }) => _generateRevisedImages(
    imageBatchId: imageBatchId,
    imageIndex: imageIndex,
    answers: answers,
  );
  final GenerateRevisedImages _generateRevisedImages;

  /// {@macro RejectImageBatch}
  Future<void> rejectImageBatch(String imageBatchId) =>
      _rejectImageBatch(imageBatchId);
  final RejectImageBatch _rejectImageBatch;

  /// {@macro SendToPrinter}
  Future<void> sendToPrinters({
    required String imagePath,
    required String machineName,
  }) => _sendToPrinters(imagePath: imagePath, machineName: machineName);
  final SendToPrinters _sendToPrinters;

  /// {@macro SubmitOrder}
  Future<void> submitOrder(String orderId) => _submitOrder(orderId);
  final SubmitOrder _submitOrder;

  /// Converts a list of [LatteOrderMetadata] into a list of [Latte] objects.
  ///
  /// This method fetches the corresponding [LatteOrder] for each
  /// [LatteOrderMetadata] and bundles them into the container object, [Latte].
  ///
  /// Throws a [DataException] if any [LatteOrderMetadata] objects lack a
  /// corresponding [LatteOrder]. This should be caught by calling code.
  Future<List<Latte>> toLattes(List<LatteOrderMetadata> metadatas) async {
    final metadataMap = metadatas.toIdsMap();

    final (orders, missingIds) = await getByIds(
      metadataMap.keys.toSet(),
      // [RequestType.global] (the default value) is fine for this because
      // orders no longer change once they are on the Barista's screen; so
      // fetching any locally cached records is guaranteed to be fine.
    );

    if (missingIds.isNotEmpty) {
      throw DataException(
        'LatteMetaData Ids $missingIds lacked corresponding LatteOrders',
      );
    }

    final lattes = <Latte>[];

    // It is important to loop over [orders] as returned by [getByIds] and not
    // over [event.metadatas] because any records lost (as represented by
    // [missingIds]) will naturally be omitted in this way. This allows us to
    // guarantee that [metadataMap[order.id!]] below will not be null.
    for (final order in orders) {
      final metadata = metadataMap[order.id!]!;
      lattes.add(Latte(order: order, metadata: metadata));
    }

    return lattes;
  }
}

/// {@template DataException}
/// Exception thrown when data is corrupted and cannot be processed.
/// {@endtemplate}
class DataException implements Exception {
  /// {@macro DataException}
  DataException(this.message);

  /// Description of the corrupted data.
  final String message;

  @override
  String toString() => 'DataException($message)';
}
