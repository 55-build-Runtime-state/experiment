// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Horizontal carousel that shows a sneak peek of the next and previous items.
class SneakPeakCarousel extends StatefulWidget {
  /// Instantiates a new [SneakPeakCarousel].
  const SneakPeakCarousel({
    required this.children,
    this.previewPercentage = 0.35,
    this.activeIndex,
    this.onIndexChanged,
    super.key,
  });

  /// The widgets to show in the carousel
  final List<Widget> children;

  /// The percentage of total width to show for adjacent items
  final double previewPercentage;

  /// The currently active index
  final int? activeIndex;

  /// Called when the active index changes
  final ValueChanged<int>? onIndexChanged;

  @override
  State<SneakPeakCarousel> createState() => _SneakPeakCarouselState();
}

class _SneakPeakCarouselState extends State<SneakPeakCarousel> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  late int _currentIndex;

  double? _lastCardWidth;
  double? _lastTotalWidth;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.activeIndex ?? 0;
  }

  @override
  void didUpdateWidget(SneakPeakCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeIndex != null &&
        widget.activeIndex != oldWidget.activeIndex) {
      _currentIndex = widget.activeIndex!;
      if (_lastCardWidth != null && _lastTotalWidth != null) {
        _scrollToIndex(
          _currentIndex,
          _lastCardWidth!,
          _lastTotalWidth!,
        );
      }
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(
    int targetIndex,
    double cardWidth,
    double totalWidth, {
    bool animate = true,
  }) {
    if (targetIndex < 0 || targetIndex >= widget.children.length) return;

    if (!_scrollController.hasClients) return;

    final offset = targetIndex * cardWidth;

    if (animate) {
      _scrollController
          .animateTo(
            offset,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
          )
          .then((_) {
            if (mounted) {
              setState(() {
                _currentIndex = targetIndex;
              });
            }
          })
          .ignore();
    } else {
      _scrollController.jumpTo(offset);
      setState(() {
        _currentIndex = targetIndex;
      });
    }
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    final dx = details.delta.dx;
    _scrollController.jumpTo(_scrollController.offset - dx);
  }

  void _handlePanEnd(
    DragEndDetails details,
    double cardWidth,
    double totalWidth,
  ) {
    if (!_scrollController.hasClients) return;

    final velocity = details.primaryVelocity ?? 0;
    int targetIndex = _currentIndex;

    if (velocity < -150) {
      targetIndex = _currentIndex + 1;
    } else if (velocity > 150) {
      targetIndex = _currentIndex - 1;
    } else {
      // Snap to nearest index based on offset.
      targetIndex = (_scrollController.offset / cardWidth).round();
    }

    // Bounds check
    targetIndex = targetIndex.clamp(0, widget.children.length - 1);

    if (targetIndex != _currentIndex) {
      widget.onIndexChanged?.call(targetIndex);
      setState(() {
        _currentIndex = targetIndex;
      });
    }

    _scrollToIndex(targetIndex, cardWidth, totalWidth);
  }

  void _handleArrowKeyEvent(int delta, double cardWidth, double totalWidth) {
    final targetIndex = (_currentIndex + delta).clamp(
      0,
      widget.children.length - 1,
    );

    if (targetIndex != _currentIndex) {
      widget.onIndexChanged?.call(targetIndex);
      setState(() {
        _currentIndex = targetIndex;
      });
      _scrollToIndex(targetIndex, cardWidth, totalWidth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        // The card takes the remaining width
        final cardWidth = totalWidth * (1 - widget.previewPercentage);

        if (_lastTotalWidth == null && _currentIndex != 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToIndex(
              _currentIndex,
              cardWidth,
              totalWidth,
              animate: false,
            );
          });
        }

        _lastTotalWidth = totalWidth;
        _lastCardWidth = cardWidth;

        return Focus(
          focusNode: _focusNode,
          autofocus: true,
          onKeyEvent: (node, event) {
            if (event is KeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                _handleArrowKeyEvent(-1, cardWidth, totalWidth);
                return KeyEventResult.handled;
              } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                _handleArrowKeyEvent(1, cardWidth, totalWidth);
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: GestureDetector(
            onHorizontalDragUpdate: _handlePanUpdate,
            onHorizontalDragEnd: (details) =>
                _handlePanEnd(details, cardWidth, totalWidth),
            child: ListView.builder(
              controller: _scrollController,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: (totalWidth - cardWidth) / 2,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: widget.children.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: cardWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: widget.children[index],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
