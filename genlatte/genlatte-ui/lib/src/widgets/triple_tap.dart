// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Widget which calls its [onPressed] callback after three taps within the
/// [duration].
class TripleTapDetector extends StatefulWidget {
  /// Instantiates a TripleTapDetector.
  const TripleTapDetector({
    required this.child,
    required this.onPressed,
    this.semanticLabel,
    this.semanticHint,
    this.duration = const Duration(milliseconds: 800),
    super.key,
  });

  /// Descendant widget to display.
  final Widget child;

  /// The callback to invoke after 3 rapid taps.
  final VoidCallback onPressed;

  /// A description of what the widget is (e.g., "Developer Menu").
  final String? semanticLabel;

  /// A description of what happens when activated (e.g., "Triple tap to open").
  final String? semanticHint;

  /// The maximum amount of time allowed from the first tap to the third tap.
  final Duration duration;

  @override
  State<TripleTapDetector> createState() => _TripleTapDetectorState();
}

class _TripleTapDetectorState extends State<TripleTapDetector> {
  int _tapCount = 0;
  DateTime? _firstTapTime;

  void _handleTap() {
    final now = DateTime.now();

    // If it's the first tap or the state was reset
    if (_tapCount == 0 || _firstTapTime == null) {
      _firstTapTime = now;
      _tapCount = 1;
    } else {
      // Check if the current tap is within the allowed duration window
      if (now.difference(_firstTapTime!) <= widget.duration) {
        _tapCount++;

        if (_tapCount == 3) {
          widget.onPressed(); // Fire the callback
          _tapCount = 0; // Reset the counter for the next sequence
        }
      } else {
        // The time window expired. Treat this tap as the first tap of a new
        // sequence.
        _firstTapTime = now;
        _tapCount = 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      // Identifies this widget as an interactive button to screen readers
      button: true,
      label: widget.semanticLabel,
      hint: widget.semanticHint ?? 'Triple tap to activate',
      onTap: widget.onPressed,
      child: GestureDetector(
        // We use behavior: HitTestBehavior.opaque to ensure the GestureDetector
        // catches taps even if the child doesn't fill the entire space or is
        // transparent.
        behavior: HitTestBehavior.opaque,
        onTap: _handleTap,
        child: widget.child,
      ),
    );
  }
}
