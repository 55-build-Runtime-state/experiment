// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:genlatte/src/screens/recent_orders/widgets/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook/widgetbook.dart';

@widgetbook.UseCase(name: 'Icon & Text', type: SquishedWidget)
Widget squishWidgetPreviewUseCase(BuildContext context) {
  return Center(
    child: SquishedWidget(
      direction: context.knobs.double.slider(
        label: 'Direction',
        initialValue: 0,
        min: -pi,
        max: pi,
      ),
      effectStrength: context.knobs.double.slider(
        label: 'Effect Strength',
        initialValue: 0,
        min: -1,
        max: 10,
      ),
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          children: [
            Positioned(
              left: 50,
              top: 50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
