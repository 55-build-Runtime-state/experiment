// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:data_layer/data_layer.dart';
import 'package:genlatte_data/models.dart';
import 'package:test/test.dart';

void main() {
  group('LatteOptions Serialization', () {
    test('JSON serialization is correct for a LatteOptions', () {
      final json = {
        'id': 'milk',
        'values': <Json>[
          {'name': 'Oat'},
          {'name': 'Almond'},
          {'name': 'Whole'},
        ],
      };

      final options = LatteOptions.fromJson(json);

      expect(options.id, 'milk');
      expect(options.values, [
        const LatteOption(name: 'Oat'),
        const LatteOption(name: 'Almond'),
        const LatteOption(name: 'Whole'),
      ]);

      final serialized = options.toJson();
      expect(serialized['id'], 'milk');
      expect(
        serialized['values'],
        <Json>[
          {'name': 'Oat', 'isAvailable': true},
          {'name': 'Almond', 'isAvailable': true},
          {'name': 'Whole', 'isAvailable': true},
        ],
      );
    });
  });
}
