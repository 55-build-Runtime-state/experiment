// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:genlatte/src/widgets/footer.dart';
import 'package:widgetbook/widgetbook.dart';

@widgetbook.UseCase(name: 'Footer', type: Footer)
Widget buildFooterUseCase(BuildContext context) {
  return Center(
    child: ColoredBox(
      color: Colors.black,
      child: SizedBox(
        width: context.knobs.double.slider(
          label: 'Width',
          initialValue: Footer.defaultWidth,
          min: 150,
          max: 2048,
        ),
        height: context.knobs.double.slider(
          label: 'Height',
          initialValue: Footer.defaultHeight,
          min: 12,
          max: 1536,
        ),
        child: Footer(),
      ),
    ),
  );
}
