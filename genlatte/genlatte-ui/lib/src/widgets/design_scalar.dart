// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// /// @docImport 'aspect_ratio_scalar.dart';
// library;

// import 'dart:math' as math;
// import 'package:flutter/widgets.dart';

// /// A widget that provides a [DesignScalar] widget to its descendants.
// class ResponsiveDesignRoot extends StatelessWidget {
//   /// Instantiates a new [ResponsiveDesignRoot].
//   const ResponsiveDesignRoot({
//     required this.designSize,
//     required this.child,
//     super.key,
//   });

//   /// Size of the original design, probably a tidy value like 1920x1080.
//   final Size designSize;

//   /// The widget to render.
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     // Get the total available screen size
//     final screenSize = MediaQuery.sizeOf(context);

//     // Calculate the scale factor (using 'contain' logic to prevent clipping)
//     final widthScale = screenSize.width / designSize.width;
//     final heightScale = screenSize.height / designSize.height;
//     final scaleFactor = math.min(widthScale, heightScale);

//     // Provide the calculated scale factor to the rest of the tree
//     return DesignScalar(
//       scaleFactor: scaleFactor,
//       child: child,
//     );
//   }
// }

// /// Tells descendant widgets how much to scale design system values by.
// /// This is useful for global rules like padding between elements. To
// /// responsively scale the internals of a complicated widget, use a
// /// [AspectRatioScalar].
// class DesignScalar extends InheritedWidget {
//   /// Instantiates a new [DesignScalar].
//   const DesignScalar({
//     required this.scaleFactor,
//     required super.child,
//     super.key,
//   });

//   /// The lesser of two ratios (height and width) between the design system's
//   /// dimensions and the available space.
//   final double scaleFactor;

//   /// Allows descendant widgets to easily grab the scale factor.
//   static double of(BuildContext context) {
//     final DesignScalar? result = context
//         .dependOnInheritedWidgetOfExactType<DesignScalar>();
//     assert(
//       result != null,
//       'No DesignScalar found in context. '
//       'Ensure you wrapped your app/screen in a DesignScalarRoot.',
//     );
//     return result!.scaleFactor;
//   }

//   @override
//   bool updateShouldNotify(DesignScalar oldWidget) {
//     return scaleFactor != oldWidget.scaleFactor;
//   }
// }
