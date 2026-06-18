// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A widget that takes a string and, if it overflows its horizontal
/// constraints, smoothly scrolls it in place to reveal the hidden text.
class OverflowMarquee extends StatefulWidget {
  /// Creates an [OverflowMarquee].
  const OverflowMarquee({
    required this.text,
    super.key,
    this.style,
    this.scrollVelocity = 35.0,
    this.pauseDuration = const Duration(seconds: 5),
    this.loop = false,
  });

  /// The text to display.
  final String text;

  /// The style of the text.
  final TextStyle? style;

  /// The scrolling velocity in logical pixels per second.
  final double scrollVelocity;

  /// The pause duration at the beginning and the end of the scroll.
  final Duration pauseDuration;

  /// Whether to instantly jump to the start after reaching the end (true),
  /// or to scroll back to the start (false). Default is false (ping-pong).
  final bool loop;

  @override
  State<OverflowMarquee> createState() => _OverflowMarqueeState();
}

class _OverflowMarqueeState extends State<OverflowMarquee> {
  late ScrollController _scrollController;
  bool _isAnimating = false;
  int _runToken = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => unawaited(_checkAndStart()),
    );
  }

  @override
  void didUpdateWidget(OverflowMarquee oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text || widget.style != oldWidget.style) {
      unawaited(_checkAndStart());
    }
  }

  @override
  void dispose() {
    _runToken++;
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _checkAndStart() async {
    final currentToken = ++_runToken;
    if (!_scrollController.hasClients) return;

    // Reset position to 0 if the text or constraints updated.
    _scrollController.jumpTo(0);

    // Give the layout a frame to calculate the new maxScrollExtent.
    await Future<void>.delayed(Duration.zero);

    if (!mounted ||
        _runToken != currentToken ||
        !_scrollController.hasClients) {
      return;
    }

    final maxExtent = _scrollController.position.maxScrollExtent;
    if (maxExtent > 0) {
      unawaited(_runLoop(currentToken));
    }
  }

  Future<void> _runLoop(int token) async {
    if (_isAnimating) return;
    _isAnimating = true;

    try {
      while (mounted && _runToken == token && _scrollController.hasClients) {
        // Pause at the start
        await Future<void>.delayed(widget.pauseDuration);
        if (!mounted || _runToken != token || !_scrollController.hasClients) {
          break;
        }

        final maxExtent = _scrollController.position.maxScrollExtent;
        if (maxExtent <= 0) break; // Stop if text no longer overflows

        // Animate to the end
        final duration = Duration(
          milliseconds: (maxExtent / widget.scrollVelocity * 1000).toInt(),
        );

        await _scrollController.animateTo(
          maxExtent,
          duration: duration,
          curve: Curves.linear,
        );

        if (!mounted || _runToken != token || !_scrollController.hasClients) {
          break;
        }

        // Pause at the end
        await Future<void>.delayed(widget.pauseDuration);
        if (!mounted || _runToken != token || !_scrollController.hasClients) {
          break;
        }

        // Return to start
        if (widget.loop) {
          _scrollController.jumpTo(0);
        } else {
          await _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    } finally {
      if (_runToken == token) {
        _isAnimating = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView automatically respects the Directionality of the
    // context, scrolling properly based on text direction (LTR vs RTL).
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Text(
        widget.text,
        style: widget.style,
        maxLines: 1,
      ),
    );
  }
}
