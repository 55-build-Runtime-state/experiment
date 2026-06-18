// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte_data/models.dart';
import 'package:test/test.dart';

void main() {
  group('Barista Serialization', () {
    test('JSON serialization is correct for a Barista', () {
      final json = {
        'id': 'b123',
        'username': 'jon_doe',
        'persona': 'asianMale',
      };

      final barista = Barista.fromJson(json);

      expect(barista.id, 'b123');
      expect(barista.username, 'jon_doe');
      expect(barista.persona, BaristaPersona.asianMale);

      final serialized = barista.toJson();
      expect(serialized['id'], 'b123');
      expect(serialized['username'], 'jon_doe');
      expect(serialized['persona'], 'asianMale');
    });

    test('JSON serialization for Barista without id', () {
      final json = {
        'username': 'jane_doe',
        'persona': 'caucasianFemale',
      };

      final barista = Barista.fromJson(json);

      expect(barista.id, isNull);
      expect(barista.username, 'jane_doe');
      expect(barista.persona, BaristaPersona.caucasianFemale);
    });
  });
}
