// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte/src/screens/kiosk/widgets/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// An item that animates in or out on its own timing based on its [index].
class ZipItem extends StatefulWidget {
  /// Instantiates a new [ZipItem].
  const ZipItem({
    required this.index,
    required this.child,
    super.key,
  });

  /// Order of this item's animation in or out.
  final int index;

  /// Child widget to animate.
  final Widget child;

  @override
  State<ZipItem> createState() => _ZipItemState();
}

class _ZipItemState extends State<ZipItem> {
  Animation<double>? _animation;
  ZipPageState? _pageState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Register with parent to get staggered timing
    _pageState = ZipPage.of(context);
    if (_pageState != null) {
      _pageState!.registerItem(widget.index);
      _animation = _pageState!.getItemAnimation(widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_animation == null || _pageState == null) return widget.child;

    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        // Value 0.0 = Offscreen
        // Value 1.0 = OnScreen

        final screenWidth = MediaQuery.sizeOf(context).width;

        // When value is 0, we want to be at offset (screenWidth * direction)
        // When value is 1, we want to be at 0

        // Invert value for translation calculation
        final value = _animation!.value;
        final double translation =
            (_pageState!.flyDirection * screenWidth) * (1 - value);

        // Add a slight opacity fade for smoothness
        final double opacity = value.clamp(0, 1);

        return Transform.translate(
          offset: Offset(translation, 0),
          child: Opacity(opacity: opacity, child: child),
        );
      },
      child: widget.child,
    );
  }
}
