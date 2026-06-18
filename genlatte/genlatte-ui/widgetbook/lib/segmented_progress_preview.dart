// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:genlatte/src/screens/kiosk/widgets/segmented_progress.dart';
import 'package:widgetbook/widgetbook.dart';

@widgetbook.UseCase(name: 'Default', type: SegmentedProgress)
Widget buildSegmentedProgressUseCase(BuildContext context) {
  return Center(
    child: SegmentedProgress(
      currentStep: context.knobs.int.input(
        label: 'Current Step',
        initialValue: 0,
      ),
      totalSteps: context.knobs.int.input(
        label: 'Total Steps',
        initialValue: 4,
      ),
    ),
  );
}
