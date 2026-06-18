// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:genlatte/src/widgets/widgets.dart';

@widgetbook.UseCase(name: 'Latte Image', type: LatteImageWidget)
Widget buildLatteImageUseCase(BuildContext context) {
  return GenLatteScaffold(
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(60),
        child: LatteImageWidget(
          imageUrl:
              "https://storage.googleapis.com/gcdemos-26-int-dd-latteart.firebasestorage.app/latteImages%2F0E4db620KWrbK3K5k13t%2F0.png",
          dimension: context.knobs.double.slider(
            label: 'Dimension',
            initialValue: 200,
            min: 100,
            max: 500,
          ),
        ),
      ),
    ),
  );
}
