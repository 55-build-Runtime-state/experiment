// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:genlatte/src/widgets/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

@widgetbook.UseCase(
  name: 'Outlined',
  type: ChevronButton,
)
Widget buildChevronButtonUseCase(BuildContext context) {
  return Center(
    child: ColoredBox(
      color: Colors.black,
      child: SizedBox(
        width: context.knobs.double.slider(
          label: 'Width',
          initialValue: 300,
          min: 150,
          max: 2048,
        ),
        height: context.knobs.double.slider(
          label: 'Height',
          initialValue: 500,
          min: 12,
          max: 1536,
        ),
        child: LayoutProvider(
          child: ResponsiveChevronButton(
            onPressed: () {},
            color: Colors.transparent,
            borderColor: const Color(0xFFFBBC04),
            textColor: const Color(0xFFFBBC04),
            text: context.knobs.string(label: 'Text', initialValue: 'Next'),
          ),
        ),
      ),
    ),
  );
}
