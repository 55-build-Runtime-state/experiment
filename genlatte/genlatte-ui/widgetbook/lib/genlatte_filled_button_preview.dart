// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:genlatte/src/widgets/buttons.dart';

@widgetbook.UseCase(name: 'Icon & Text', type: GenLatteFilledButton)
Widget buildGenLatteFilledButtonDarkUseCase(BuildContext context) {
  return Center(
    child: Container(
      height: 200,
      width: 200,
      color: Colors.black,
      child: Center(
        child: GenLatteFilledButton(
          icon: Icons.arrow_back,
          label: 'Back',
          onPressed: () {},
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Icon Only', type: GenLatteFilledButton)
Widget buildGenLatteFilledButtonIconOnlyUseCase(BuildContext context) {
  return Center(
    child: Container(
      height: 200,
      width: 200,
      color: Colors.black,
      child: Center(
        child: GenLatteFilledButton(
          icon: Icons.arrow_back,
          onPressed: () {},
        ),
      ),
    ),
  );
}
