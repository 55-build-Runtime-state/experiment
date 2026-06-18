// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:genlatte/src/screens/recent_orders/models/wobble_calculator.dart';

void main() {
  group('WobbleCalculator', () {
    const calculator = WobbleCalculator(wobblesPerContact: 3);
    test('should return 0 strength at 0 time', () {
      expect(calculator.getWobble(0 / 12).strength, closeTo(0, 0.001));
    });

    test('should return 0.5 strength while 1/4 of the way through phase 1', () {
      expect(calculator.getWobble(1 / 12).strength, closeTo(0.5, 0.001));
    });

    test('should return 1 strength at the peak of phase 1', () {
      expect(calculator.getWobble(2 / 12).strength, closeTo(1, 0.001));
    });

    test('should return 0.5 strength while 3/4 of the way through phase 1', () {
      expect(calculator.getWobble(3 / 12).strength, closeTo(0.5, 0.001));
    });

    test('should return 0 strength at the end of phase 1', () {
      expect(calculator.getWobble(4 / 12).strength, closeTo(0, 0.001));
    });

    test(
      'should return (0.5 * 3/4) strength while 1/4 of the way through phase 2',
      () {
        expect(
          calculator.getWobble(5 / 12).strength,
          closeTo(0.5 * 0.75, 0.001),
        );
      },
    );

    test('should return 0.75 strength at the peak of phase 2', () {
      expect(
        calculator.getWobble(6 / 12).strength,
        closeTo(0.75, 0.001),
      );
    });

    test(
      'should return 0.375 strength while 3/4 of the way through phase 2',
      () {
        expect(
          calculator.getWobble(7 / 12).strength,
          closeTo(0.5 * 0.75, 0.001),
        );
      },
    );

    test('should return 0 strength at the end of phase 2', () {
      expect(calculator.getWobble(8 / 12).strength, closeTo(0, 0.001));
    });
  });
}
