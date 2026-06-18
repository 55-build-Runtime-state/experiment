// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_functions/cloud_functions.dart';
import 'package:genlatte/src/core/core.dart';
import 'package:logging/logging.dart';

final _logger = Logger('FirebaseFunctionsClient');

/// A utility class for calling Firebase Functions with retry logic.
class FirebaseFunctionsClient {
  /// Creates a new [FirebaseFunctionsClient].
  FirebaseFunctionsClient(this._firebaseFunctions, {required this.appEnv});

  /// The Firebase Functions instance to use.
  final FirebaseFunctions _firebaseFunctions;

  /// The active application environment.
  final AppEnv appEnv;

  /// Calls 'sendToPrinters' to send an order to the printers.
  Future<void> sendToPrinters({
    required String imagePath,
    required String machineName,
  }) async {
    await _callWithRetry(
      functionName: 'sendToPrinter${appEnv.name}',
      parameters: <String, Object?>{
        'imagePath': imagePath,
        'machineName': machineName,
      },
    );
  }

  /// Calls 'selectImagestaging' to accept an image.
  Future<void> acceptImage({
    required String imageBatchId,
    required String imageIndex,
  }) async {
    await _callWithRetry(
      functionName: 'selectImage${appEnv.name}',
      parameters: <String, Object?>{
        'imageBatchId': imageBatchId,
        'imageIndex': imageIndex,
      },
    );
  }

  /// Calls 'completeOrder{env}' conclude the life cycle of an order.
  Future<void> completeOrder({
    required String orderId,
    required String baristaId,
  }) async {
    await _callWithRetry(
      functionName: 'completeOrder${appEnv.name}',
      parameters: <String, Object?>{
        'orderId': orderId,
        'baristaId': baristaId,
      },
    );
  }

  /// Calls 'generateRevisedImagesstaging' to revise an image batch.
  Future<void> generateRevisedImages({
    required String imageBatchId,
    required String imageIndex,
    required Map<String, Object?> answers,
  }) async {
    await _callWithRetry(
      functionName: 'generateRevisedImages${appEnv.name}',
      parameters: <String, Object?>{
        'imageBatchId': imageBatchId,
        'imageIndex': imageIndex,
        'answers': answers,
      },
    );
  }

  /// Calls 'rejectRevisionstaging' to reject an image batch.
  Future<void> rejectImageBatch(String imageBatchId) async {
    await _callWithRetry(
      functionName: 'rejectRevision${appEnv.name}',
      parameters: <String, Object?>{
        'imageBatchId': imageBatchId,
      },
    );
  }

  /// Calls 'submitOrderstaging' to submit an order.
  Future<void> submitOrder(String orderId) async {
    await _callWithRetry(
      functionName: 'submitOrder${appEnv.name}',
      parameters: <String, Object?>{
        'orderId': orderId,
      },
    );
  }

  Future<void> _callWithRetry({
    required String functionName,
    required Map<String, Object?> parameters,
    int maxRetries = 3,
  }) async {
    int attempt = 0;
    while (true) {
      try {
        _logger.info(
          'Calling Firebase Function $functionName with '
          'parameters: $parameters',
        );
        final callable = _firebaseFunctions.httpsCallable(functionName);
        await callable.call<void>(parameters);
        return;
      } catch (e) {
        attempt++;
        if (attempt >= maxRetries) {
          _logger.severe(
            'Failed to call Firebase Function $functionName for final time.',
            e,
          );
          rethrow;
        }
        _logger.warning(
          'Failed to call Firebase Function $functionName. Retrying...',
          e,
        );
        await Future<void>.delayed(Duration(milliseconds: 500 * attempt));
      }
    }
  }
}
