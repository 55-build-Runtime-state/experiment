// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:data_layer/data_layer.dart';
import 'package:genlatte/src/data/data.dart';
import 'package:genlatte_data/models.dart';
import 'package:logging/logging.dart';

/// Fake repository for testing purposes.
class FakeLatteOrdersMetadataRepository extends Repository<LatteOrderMetadata> {
  /// Creates a new instance of [FakeLatteOrdersMetadataRepository].
  FakeLatteOrdersMetadataRepository()
    : super(
        SourceList<LatteOrderMetadata>(
          bindings: LatteOrderMetadata.bindings,
          sources: <Source<LatteOrderMetadata>>[
            FakeSource<LatteOrderMetadata>(
              bindings: LatteOrderMetadata.bindings,
            ),
          ],
        ),
      );
}

/// Fake repository for testing purposes.
class FakeLatteOrdersRepository extends Repository<LatteOrder>
    implements LatteOrdersRepository {
  /// Creates a new instance of [FakeLatteOrdersRepository].
  FakeLatteOrdersRepository({
    AcceptImage acceptImage = _defaultAcceptImage,
    CompleteOrder completeOrder = _defaultCompleteOrder,
    GenerateRevisedImages generateRevisedImages = _defaultGenerateRevisedImages,
    RejectImageBatch rejectImageBatch = _defaultRejectImageBatch,
    SendToPrinters sendToPrinters = _defaultSendToPrinters,
    SubmitOrder submitOrder = _defaultSubmitOrder,
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
             FakeSource<LatteOrder>(
               bindings: LatteOrder.bindings,
             ),
           ],
         ),
       );

  static final Logger _logger = Logger('$FakeLatteOrdersRepository');

  @override
  Future<void> acceptImage({
    required String imageBatchId,
    required String imageIndex,
  }) => _acceptImage(imageBatchId: imageBatchId, imageIndex: imageIndex);
  final AcceptImage _acceptImage;

  @override
  Future<void> completeOrder({
    required String orderId,
    required String baristaId,
  }) => _completeOrder(orderId: orderId, baristaId: baristaId);
  final CompleteOrder _completeOrder;

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
  final GenerateRevisedImages _generateRevisedImages;

  @override
  Future<void> rejectImageBatch(String imageBatchId) =>
      _rejectImageBatch(imageBatchId);
  final RejectImageBatch _rejectImageBatch;

  @override
  Future<void> sendToPrinters({
    required String imagePath,
    required String machineName,
  }) => _sendToPrinters(imagePath: imagePath, machineName: machineName);
  final SendToPrinters _sendToPrinters;

  @override
  Future<void> submitOrder(String orderId) => _submitOrder(orderId);
  final SubmitOrder _submitOrder;

  /// Duplicated code from [LatteOrdersRepository].
  @override
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

  static Future<void> _defaultAcceptImage({
    required String imageBatchId,
    required String imageIndex,
  }) async {
    _logger.info('acceptImage: $imageBatchId - $imageIndex');
  }

  static Future<void> _defaultCompleteOrder({
    required String orderId,
    required String baristaId,
  }) async {
    _logger.info('completeOrder: $orderId - $baristaId');
  }

  static Future<void> _defaultGenerateRevisedImages({
    required String imageBatchId,
    required String imageIndex,
    required Map<String, Object?> answers,
  }) async {
    _logger.info(
      'generateRevisedImages: $imageBatchId - $imageIndex - $answers',
    );
  }

  static Future<void> _defaultSendToPrinters({
    required String imagePath,
    required String machineName,
  }) async {
    _logger.info('sendToPrinters: $imagePath, $machineName');
  }

  static Future<void> _defaultRejectImageBatch(String imageBatchId) async {
    _logger.info('rejectImageBatch: $imageBatchId');
  }

  static Future<void> _defaultSubmitOrder(String orderId) async {
    _logger.info('submitOrder: $orderId');
  }
}

/// Fake source for testing purposes.
class FakeSource<T> extends Source<T> with WatchableSource<T> {
  /// Creates a new instance of [FakeSource].
  FakeSource({required super.bindings});

  int _id = 1;

  final StreamController<void> _updateStream = StreamController.broadcast();

  final Map<String, T> _store = {};

  @override
  SourceType get sourceType => SourceType.local;

  @override
  Future<DeleteResult<T>> delete(DeleteOperation<T> operation) async {
    _store.remove(operation.itemId);
    _updateStream.add(null);
    return DeleteResult.success(operation.details);
  }

  @override
  Future<ReadResult<T>> getById(ReadOperation<T> operation) async {
    final item = _store[operation.itemId];
    return ReadResult.success(item, details: operation.details);
  }

  @override
  Future<ReadListResult<T>> getByIds(ReadByIdsOperation<T> operation) async {
    final items = operation.itemIds
        .map<T?>((id) => _store[id])
        .whereType<T>()
        .toList();
    return ReadListResult.fromList(
      items,
      operation.details,
      {}, // TODO(filiph): actually find missing ids.
      bindings.getId,
    );
  }

  @override
  Future<ReadListResult<T>> getItems(ReadListOperation<T> operation) async {
    final items = _store.values.toList();
    return ReadListResult.fromList(
      items,
      operation.details,
      {}, // TODO(filiph): actually find missing ids.
      bindings.getId,
    );
  }

  @override
  Future<WriteResult<T>> setItem(WriteOperation<T> operation) async {
    final existingId = bindings.getId(operation.item);
    final id = existingId ?? '${_id++}';
    _store[id] = operation.item;
    _updateStream.add(null);
    return WriteResult.success(operation.item, details: operation.details);
  }

  @override
  Future<WriteListResult<T>> setItems(WriteListOperation<T> operation) async {
    for (final item in operation.items) {
      final existingId = bindings.getId(item);
      final id = existingId ?? '${_id++}';
      _store[id] = item;
    }
    _updateStream.add(null);
    return WriteListResult.success(operation.items, details: operation.details);
  }

  @override
  Stream<ReadResult<T>> watch(ReadOperation<T> operation) async* {
    ReadResult<T> current = await getById(operation);
    yield current;
    await for (final _ in _updateStream.stream) {
      final next = await getById(operation);
      if (next.mapOrNull(success: (s) => s.item) !=
          current.mapOrNull(success: (s) => s.item)) {
        yield next;
        current = next;
      }
    }
  }

  @override
  Stream<ReadListResult<T>> watchByIds(ReadByIdsOperation<T> operation) async* {
    ReadListResult<T> current = await getByIds(operation);
    yield current;
    await for (final _ in _updateStream.stream) {
      final next = await getByIds(operation);
      if (next.mapOrNull((s) => s.items) != current.mapOrNull((s) => s.items)) {
        yield next;
        current = next;
      }
    }
  }

  @override
  Stream<ReadListResult<T>> watchList(ReadListOperation<T> operation) async* {
    ReadListResult<T> current = await getItems(operation);
    yield current;
    await for (final _ in _updateStream.stream) {
      final next = await getItems(operation);
      if (next.mapOrNull((s) => s.items) != current.mapOrNull((s) => s.items)) {
        yield next;
        current = next;
      }
    }
  }

  /// Disposes of the [FakeSource].
  void dispose() {
    _updateStream.close().ignore();
  }
}
