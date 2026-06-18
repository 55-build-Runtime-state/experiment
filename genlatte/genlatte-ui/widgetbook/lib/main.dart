// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:genlatte/src/screens/app/theme.dart';

// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appBuilder: (context, child) {
        return ShadcnApp(
          debugShowCheckedModeBanner: false,
          theme: getThemeForOrientation(context),
          home: child,
        );
      },
      // The [directories] variable does not exist yet,
      // it will be generated in the next step
      directories: directories,
    );
  }
}
