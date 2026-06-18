// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:genlatte/src/widgets/widgets.dart';

@widgetbook.UseCase(name: 'Loading Dash', type: LoadingDash)
Widget buildLoadingDashUseCase(BuildContext context) {
  return GenLatteScaffold(
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(
          context.knobs.double.slider(
            label: 'Padding',
            initialValue: 20,
            min: 20,
            max: 320,
          ),
        ),
        child: LoadingDash(),
      ),
    ),
  );
}
