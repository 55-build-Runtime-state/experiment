// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:genlatte/src/widgets/responsive_sized_box.dart';
import 'package:provider/provider.dart';

/// A widget that provides [LayoutInformation] to its descendants.
class LayoutProvider extends StatelessWidget {
  /// Child pattern for [LayoutProvider].
  factory LayoutProvider({
    required Widget child,
    Key? key,
  }) => LayoutProvider._(
    key: key,
    child: child,
  );

  /// Creates a new [LayoutProvider].
  const LayoutProvider._({
    this.builder,
    this.child,
    super.key,
  }) : assert(
         child != null || builder != null,
         'Provide either child or builder',
       );

  /// Builder pattern for [LayoutProvider].
  factory LayoutProvider.builder({
    required Widget Function(BuildContext, LayoutInformation) builder,
    Key? key,
  }) => LayoutProvider._(
    key: key,
    builder: builder,
  );

  /// The child widget.
  final Widget? child;

  /// Builder function that receives the optimal size and returns the widget to
  /// display. Provide this or [child].
  final Widget Function(BuildContext, LayoutInformation)? builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final info = LayoutInformation.fromBoxConstraints(constraints);
        return Provider<LayoutInformation>.value(
          value: info,
          child: child ?? builder!(context, info),
        );
      },
    );
  }
}
