// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genlatte/src/widgets/responsive_sized_box.dart';

BoxConstraints _fromAspectRatio(double aspectRatio, {double width = 100}) {
  return BoxConstraints.tight(Size(width, width / aspectRatio));
}

void main() {
  group('ApsectRatioScalar.orientation should', () {
    test('return portrait when aspect ratio is less than 1', () {
      final scalar = AspectRatioScalar((
        null,
        0.5, // does not matter
        null,
      ), constraints: _fromAspectRatio(0.5));
      expect(scalar.constraintsOrientation, LayoutOrientation.portrait);
    });

    test('return constraints when no ideal is provided', () {
      final scalar = AspectRatioScalar((
        null,
        null,
        null,
      ), constraints: _fromAspectRatio(0.5));
      expect(scalar.constraintsOrientation, LayoutOrientation.portrait);
    });

    test('return landscape when aspect ratio is greater than 1', () {
      final scalar = AspectRatioScalar((
        null,
        0.5, // does not matter
        null,
      ), constraints: _fromAspectRatio(2));
      expect(scalar.constraintsOrientation, LayoutOrientation.landscape);
    });

    test('return landscape when aspect ratio is equal to 1', () {
      final scalar = AspectRatioScalar((
        null,
        0.5, // does not matter
        null,
      ), constraints: _fromAspectRatio(1));
      expect(scalar.constraintsOrientation, LayoutOrientation.square);
    });
  });

  group('AspectRatioScalar.clampedAspectRatio should', () {
    test('return the ideal aspect ratio when it is within bounds', () {
      final scalar = AspectRatioScalar((
        null,
        0.5,
        null,
      ), constraints: _fromAspectRatio(0.5));
      expect(scalar.optimalAspectRatio, 0.5);
    });

    test('return the minimum aspect ratio when it is below the minimum', () {
      final scalar = AspectRatioScalar((
        null,
        0.5,
        null,
      ), constraints: _fromAspectRatio(0.25));
      expect(scalar.optimalAspectRatio, 0.5);
    });

    test('return the maximum aspect ratio when it is above the maximum', () {
      final scalar = AspectRatioScalar((
        null,
        0.5,
        null,
      ), constraints: _fromAspectRatio(0.75));
      expect(scalar.optimalAspectRatio, 0.5);
    });

    test('return the actual aspect ratio when it is within range', () {
      final scalar = AspectRatioScalar((
        null,
        0.5,
        1,
      ), constraints: _fromAspectRatio(0.75));
      expect(scalar.optimalAspectRatio, 0.75);
    });

    test('return the maximum aspect ratio when it is above range with max', () {
      final scalar = AspectRatioScalar((
        null,
        0.5,
        1,
      ), constraints: _fromAspectRatio(1.5));
      expect(scalar.optimalAspectRatio, 1);
    });

    test(
      'return the minimum aspect ratio when it is below minimum with min',
      () {
        final scalar = AspectRatioScalar((
          0.25,
          0.5,
          1,
        ), constraints: _fromAspectRatio(0.1));
        expect(scalar.optimalAspectRatio, 0.25);
      },
    );
  });

  group('Given a landscape object, AspectRatioScalar.optimalSize should', () {
    test('fit into portrait space', () {
      final scalar = AspectRatioScalar(
        // Landscape object (e.g., 200x100)
        (null, 2, null),
        // Portrait space (exactly 100x300)
        constraints: _fromAspectRatio(0.333),
      );
      expect(scalar.optimalSize.width, closeTo(100, 0.0001));
      expect(scalar.optimalSize.height, closeTo(50, 0.0001));
    });

    test('fit into portrait space with max size constraining width', () {
      final scalar = AspectRatioScalar(
        // Landscape object (e.g., 200x100)
        (null, 2, null),
        // Portrait space (exactly 100x300)
        constraints: _fromAspectRatio(0.333),
        maxSize: const Size(75, 75),
      );
      expect(scalar.optimalSize.width, closeTo(75, 0.0001));
      expect(scalar.optimalSize.height, closeTo(37.5, 0.0001));
    });

    test('fit into portrait space with max size constraining height', () {
      final scalar = AspectRatioScalar(
        // Landscape object (e.g., 200x100)
        (null, 2, null),
        // Portrait space (exactly 100x300)
        constraints: _fromAspectRatio(0.333),
        maxSize: const Size(300, 25),
      );
      expect(scalar.optimalSize.width, closeTo(50, 0.0001));
      expect(scalar.optimalSize.height, closeTo(25, 0.0001));
    });

    test('fit into landscape space', () {
      final scalar = AspectRatioScalar(
        // Landscape object (e.g., 200x100)
        (null, 2, null),
        // Landscape space (exactly 300x100)
        constraints: _fromAspectRatio(3, width: 300),
      );
      expect(scalar.constraintsOrientation, LayoutOrientation.landscape);
      expect(scalar.optimalSize.width, closeTo(200, 0.0001), reason: 'width');
      expect(scalar.optimalSize.height, closeTo(100, 0.0001), reason: 'height');
    });

    test('fit into landscape space with max size constraining width', () {
      final scalar = AspectRatioScalar(
        // Landscape object (e.g., 200x100)
        (null, 2, null),
        // Landscape space (exactly 300x100)
        constraints: _fromAspectRatio(3, width: 300),
        maxSize: const Size(250, 250),
      );
      expect(scalar.optimalSize.width, closeTo(200, 0.0001), reason: 'width');
      expect(scalar.optimalSize.height, closeTo(100, 0.0001), reason: 'height');
    });

    test('fit into landscape space with max size constraining height', () {
      final scalar = AspectRatioScalar(
        // Landscape object (e.g., 200x100)
        (null, 2, null),
        // Landscape space (exactly 300x100)
        constraints: _fromAspectRatio(3, width: 300),
        maxSize: const Size(300, 100),
      );
      expect(scalar.optimalSize.width, closeTo(200, 0.0001), reason: 'width');
      expect(scalar.optimalSize.height, closeTo(100, 0.0001), reason: 'height');
    });

    test('fit into square space', () {
      final scalar = AspectRatioScalar(
        // Landscape object (e.g., 200x100)
        (null, 2, null),
        // Square space (exactly 100x100)
        constraints: _fromAspectRatio(1),
      );
      expect(scalar.optimalSize.width, closeTo(100, 0.0001), reason: 'width');
      expect(scalar.optimalSize.height, closeTo(50, 0.0001), reason: 'height');
    });

    test('fit into square space with max size constraining width', () {
      final scalar = AspectRatioScalar(
        // Landscape object (e.g., 200x100)
        (null, 2, null),
        // Square space (exactly 100x100)
        constraints: _fromAspectRatio(1),
        maxSize: const Size(90, 90),
      );
      expect(scalar.optimalSize.width, closeTo(90, 0.0001), reason: 'width');
      expect(scalar.optimalSize.height, closeTo(45, 0.0001), reason: 'height');
    });

    test('fit into square space with max size constraining height', () {
      final scalar = AspectRatioScalar(
        // Landscape object (e.g., 200x100)
        (null, 2, null),
        // Square space (exactly 100x100)
        constraints: _fromAspectRatio(1),
        maxSize: const Size(100, 40),
      );
      expect(scalar.optimalSize.width, closeTo(80, 0.0001), reason: 'width');
      expect(scalar.optimalSize.height, closeTo(40, 0.0001), reason: 'height');
    });

    test(
      'fit into landscape space with max size constraining both, '
      'width is stricter',
      () {
        final scalar = AspectRatioScalar(
          // Landscape object (e.g., 200x100)
          (null, 2, null),
          // Landscape space (exactly 300x100)
          constraints: _fromAspectRatio(3, width: 300),
          // Unconstrained size is 200x100.
          // We set max size to 50x50, so both dimensions constrain.
          // The scale to fit width is 50/200 = 0.25
          // The scale to fit height is 50/100 = 0.5
          // The width scale is stricter.
          maxSize: const Size(50, 50),
        );
        expect(scalar.optimalSize.width, closeTo(50, 0.0001));
        expect(scalar.optimalSize.height, closeTo(25, 0.0001));
      },
    );
  });

  group('Given a portrait object, AspectRatioScalar.optimalSize should', () {
    test('fit into portrait space', () {
      final scalar = AspectRatioScalar(
        // Portrait object (e.g., 50x100)
        (null, 0.5, null),
        // Portrait space (exactly 50x400)
        constraints: _fromAspectRatio(0.125, width: 50),
      );
      expect(scalar.constraintsOrientation, LayoutOrientation.portrait);
      expect(scalar.optimalSize.width, closeTo(50, 0.0001));
      expect(scalar.optimalSize.height, closeTo(100, 0.0001));
    });

    test('fit into portrait space with max size constraining width', () {
      final scalar = AspectRatioScalar(
        // Portrait object (e.g., 50x100)
        (null, 0.5, null),
        // Portrait space (exactly 50x400)
        constraints: _fromAspectRatio(0.125, width: 50),
        maxSize: const Size(25, 25),
      );
      expect(scalar.constraintsOrientation, LayoutOrientation.portrait);
      expect(scalar.optimalSize.width, closeTo(12.5, 0.0001));
      expect(scalar.optimalSize.height, closeTo(25, 0.0001));
    });

    test('fit into portrait space with max size constraining height', () {
      final scalar = AspectRatioScalar(
        // Portrait object (e.g., 50x100)
        (null, 0.5, null),
        // Portrait space (exactly 50x400)
        constraints: _fromAspectRatio(0.125, width: 50),
        maxSize: const Size(75, 75),
      );
      expect(scalar.constraintsOrientation, LayoutOrientation.portrait);
      expect(scalar.optimalSize.width, closeTo(37.5, 0.0001));
      expect(scalar.optimalSize.height, closeTo(75, 0.0001));
    });

    test('fit into landscape space', () {
      final scalar = AspectRatioScalar(
        // Portrait object (e.g., 50x100)
        (null, 0.5, null),
        // Portrait space (exactly 300x100)
        constraints: _fromAspectRatio(3, width: 300),
      );
      expect(scalar.constraintsOrientation, LayoutOrientation.landscape);
      expect(scalar.optimalSize.width, closeTo(50, 0.0001));
      expect(scalar.optimalSize.height, closeTo(100, 0.0001));
    });

    test(
      'fit into landscape space with max size constraining width',
      () {
        final scalar = AspectRatioScalar(
          // Portrait object (e.g., 50x100)
          (null, 0.5, null),
          // Portrait space (exactly 300x100)
          constraints: _fromAspectRatio(3, width: 300),
          maxSize: const Size(25, 100),
        );
        expect(scalar.constraintsOrientation, LayoutOrientation.landscape);
        expect(scalar.optimalSize.width, closeTo(25, 0.0001));
        expect(scalar.optimalSize.height, closeTo(50, 0.0001));
      },
    );

    test(
      'fit into landscape space with max size constraining height',
      () {
        final scalar = AspectRatioScalar(
          // Portrait object (e.g., 50x100)
          (null, 0.5, null),
          // Portrait space (exactly 300x100)
          constraints: _fromAspectRatio(3, width: 300),
          maxSize: const Size(75, 75),
        );
        expect(scalar.constraintsOrientation, LayoutOrientation.landscape);
        expect(scalar.optimalSize.width, closeTo(37.5, 0.0001));
        expect(scalar.optimalSize.height, closeTo(75, 0.0001));
      },
    );

    test('fit portrait object when available space is square', () {
      final scalar = AspectRatioScalar(
        // Portrait object (e.g., 50x100)
        (null, 0.5, null),
        // Portrait space (exactly 300x300)
        constraints: _fromAspectRatio(1, width: 300),
      );
      expect(scalar.constraintsOrientation, LayoutOrientation.square);
      expect(scalar.optimalSize.width, closeTo(150, 0.0001));
      expect(scalar.optimalSize.height, closeTo(300, 0.0001));
    });

    test(
      'fit into portrait space with max size constraining both, '
      'height is stricter',
      () {
        final scalar = AspectRatioScalar(
          // Portrait object (e.g., 50x100)
          (null, 0.5, null),
          // Portrait space (exactly 50x400)
          constraints: _fromAspectRatio(0.125, width: 50),
          // Unconstrained size is 50x100.
          // We set max size to 30x30, so both dimensions constrain.
          // The scale to fit width is 30/50 = 0.6
          // The scale to fit height is 30/100 = 0.3
          // The height scale is stricter.
          maxSize: const Size(30, 30),
        );
        expect(scalar.optimalSize.width, closeTo(15, 0.0001));
        expect(scalar.optimalSize.height, closeTo(30, 0.0001));
      },
    );
  });

  group('Given a square object, AspectRatioScalar.optimalSize should', () {
    test('fit into square space', () {
      final scalar = AspectRatioScalar(
        (null, 1.0, null),
        constraints: _fromAspectRatio(1),
      );
      expect(scalar.optimalSize.width, closeTo(100, 0.0001));
      expect(scalar.optimalSize.height, closeTo(100, 0.0001));
    });

    test('fit into landscape space', () {
      final scalar = AspectRatioScalar(
        (null, 1.0, null),
        constraints: _fromAspectRatio(2, width: 200),
      );
      expect(scalar.optimalSize.width, closeTo(100, 0.0001));
      expect(scalar.optimalSize.height, closeTo(100, 0.0001));
    });

    test('fit into portrait space', () {
      final scalar = AspectRatioScalar(
        (null, 1.0, null),
        constraints: _fromAspectRatio(0.5, width: 50),
      );
      expect(scalar.optimalSize.width, closeTo(50, 0.0001));
      expect(scalar.optimalSize.height, closeTo(50, 0.0001));
    });
  });
}
