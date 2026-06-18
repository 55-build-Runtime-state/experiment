// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:genlatte/src/widgets/chevron_button.dart';
import 'package:widgetbook/widgetbook.dart';

@widgetbook.UseCase(name: 'Vertical', type: ChevronButton)
Widget buildVerticalChevronButtonUseCase(BuildContext context) {
  return Center(
    child: ChevronButton.vertical(
      scale: context.knobs.double.slider(
        label: 'Scale',
        initialValue: 1.0,
        min: 0.1,
        max: 2.0,
        divisions: 19,
      ),
      builder: (context, scale, textColor) => WrappedText(
        style: (context, theme) => theme.typography.h1.copyWith(
          fontSize: theme.typography.h1.fontSize! * scale,
          color: textColor,
        ),
        child: Text(context.knobs.string(label: 'Text', initialValue: 'Next')),
      ),
      onPressed: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Flat', type: ChevronButton)
Widget buildFlatChevronButtonUseCase(BuildContext context) {
  return Center(
    child: ChevronButton.flat(
      scale: context.knobs.double.slider(
        label: 'Scale',
        initialValue: 1.0,
        min: 0.1,
        max: 2.0,
        divisions: 19,
      ),
      builder: (context, scale, textColor) => WrappedText(
        style: (context, theme) => theme.typography.h2.copyWith(
          fontSize: theme.typography.h2.fontSize! * scale,
          color: textColor,
        ),
        child: Text(context.knobs.string(label: 'Text', initialValue: 'Next')),
      ),
      onPressed: () {},
    ),
  );
}
