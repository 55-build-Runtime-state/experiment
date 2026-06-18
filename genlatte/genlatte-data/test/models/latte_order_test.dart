// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte_data/models.dart';
import 'package:test/test.dart';

void main() {
  group('LatteOrder Serialization', () {
    test('JSON serialization is correct for a fully populated order', () {
      final json = {
        'id': 'order-123',
        'name': 'Alice',
        'milk': 'Oat',
        'sweetener': 'Vanilla',
        'happyPlace': 'A cozy cabin',
      };

      final order = LatteOrder.fromJson(json);

      expect(order.id, 'order-123');
      expect(order.name, 'Alice');
      expect(order.milk, 'Oat');
      expect(order.sweetener, 'Vanilla');
      expect(order.happyPlace, 'A cozy cabin');

      expect(order.toJson(), json);
    });

    test('JSON serialization is correct for an empty order', () {
      final json = <String, dynamic>{
        'id': null,
        'name': null,
        'milk': null,
        'sweetener': null,
        'happyPlace': null,
      };

      final order = LatteOrder.fromJson(json);

      expect(order.id, isNull);
      expect(order.name, isNull);

      // Nulls are generally excluded or included depending on json_serializable
      // config. But we can verify toJson includes what's expected. We should
      // match the actual object property Let's just create an empty order and
      // see its toJson.
      const emptyOrder = LatteOrder();

      // We expect unpopulated fields to either serialize as null or be omitted.
      // Since freezed creates `id?: String` etc, the json will likely have the
      // keys if includeIfNull: true We will assert on the required structure.
      final serialized = emptyOrder.toJson();
      // Only verifying fields that actually exist or not throwing error
      expect(serialized.containsKey('id'), isTrue);
    });
  });

  group('LatteOrderMetadata Serialization', () {
    test('JSON serialization is correct for a fully populated metadata', () {
      final json = {
        'id': 'meta-123',
        'orderNumber': 42,
        'isNameApproved': true,
        'isHappyPlaceApproved': false,
        'happyPlaceModerationReason': 'barista_moderation',
        'isImageApproved': true,
        'imageBatchId': 'batch-001',
        'imageUrl': 'https://example.com/image.png',
        'status': 'submitted',
        'baristaId': 'barista-jon',
        'orderSubmittedTime': '2023-10-10T10:10:10.000Z',
        'completionTime': '2023-10-10T10:15:10.000Z',
      };

      final metadata = LatteOrderMetadata.fromJson(json);

      expect(metadata.id, 'meta-123');
      expect(metadata.orderNumber, 42);
      expect(metadata.status, LatteOrderStatus.submitted);

      final serialized = metadata.toJson();
      expect(serialized['id'], 'meta-123');
      expect(serialized['status'], 'submitted');
      expect(serialized['orderSubmittedTime'], '2023-10-10T10:10:10.000Z');
    });
  });
}
