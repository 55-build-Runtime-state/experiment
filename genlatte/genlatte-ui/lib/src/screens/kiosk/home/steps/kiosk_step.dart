// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte/src/widgets/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Generic layout wrapper for Kiosk steps.
class KioskStep extends StatelessWidget {
  /// Instantiates a new [KioskStep].
  const KioskStep({
    required this.child,
    this.header,
    super.key,
  });

  /// Optional header widget to exist below the segmented progress indicator.
  final Widget? header;

  /// The content of the step.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, info) {
        final verticalPadding =
            info.height * (info.orientation.isLandscape ? 0.07 : 0.035);
        return Stack(
          children: [
            if (header != null) ...[
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: info.height * 0.2,
                child: header!,
              ),
            ],
            Positioned(
              left: 0,
              right: 0,
              top: verticalPadding,
              bottom: verticalPadding,
              child: child,
            ),
          ],
        );
      },
    );
  }
}
