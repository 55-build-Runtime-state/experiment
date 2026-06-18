// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// @docImport 'package:genlatte/src/screens/kiosk/widgets/zip_item.dart';
library;

import 'dart:math' as math;
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Manages a series of pages with sub-items that animate in and out
/// one item at a time.
///
/// Individual sub-items are wrapped in a [ZipItem] widget, each of which
/// accepts an integer `index` parameter. These indicies must appear in
/// descending order within the wrapping widget's build method. Behavior is
/// undefined if they are registered in any other order. The reason for this
/// is that the [ZipPage] widget must immediately know the maximum number of
/// children so that the first widget to appear can receive an [Animation] with
/// the correct total duration.
class ZipPageView extends StatefulWidget {
  /// Instantiates a new [ZipPageView].
  const ZipPageView({
    required this.builder,
    required this.itemCount,
    required this.currentIndex,
    required this.onNewPage,
    super.key,
  });

  /// The pages to display.
  final IndexedWidgetBuilder builder;

  /// The number of pages to display.
  final int itemCount;

  /// The current index of the page.
  final int currentIndex;

  /// Callback for when a new page is about to be displayed. This is not called
  /// until after the previous page is gone, meaning it is safe to remove state
  /// associated with the previous page or to load data for the new page.
  final void Function(int) onNewPage;

  @override
  State<ZipPageView> createState() => _ZipPageViewState();
}

class _ZipPageViewState extends State<ZipPageView> {
  late PageController _pageController;
  late int _currentIndex;
  late int _previousIndex;

  // Updated to either reflect _previousIndex or _currentIndex depending on
  // whether we are in the first or second half of the transition animation.
  late int _indexToBuild;

  bool _isAnimating = false;

  // By default, all pages animate-in. However, that would cause the first page
  // to flicker; so this flag allows the first page to start fully in-place.
  bool _hasNavigated = false;

  final Map<int, GlobalKey<ZipPageState>> _pageKeys = {};

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _indexToBuild = _currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void didUpdateWidget(covariant ZipPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _previousIndex = _currentIndex;
      _currentIndex = widget.currentIndex;
      _handleTransition(widget.currentIndex - oldWidget.currentIndex).ignore();
    }
  }

  GlobalKey<ZipPageState> _getKey(int index) {
    return _pageKeys.putIfAbsent(index, GlobalKey<ZipPageState>.new);
  }

  Future<void> _handleTransition(int direction) async {
    if (_isAnimating) return;

    if (_currentIndex < 0 || _currentIndex >= widget.itemCount) {
      return;
    }

    setState(() {
      _isAnimating = true;
      _hasNavigated = true; // Mark that future builds should start hidden
    });

    // 1. Exit current page
    final animatingOutPageKey = _getKey(_previousIndex);
    if (animatingOutPageKey.currentState != null) {
      await animatingOutPageKey.currentState!._animateExit(direction);
      _indexToBuild = _currentIndex;
    }

    // 2. Move Controller
    _pageController.jumpToPage(_currentIndex);

    // 3. Wait for build (imperative vs declarative sync)
    // We need the new page to mount in its "hidden" state before we animate
    // it in.
    await Future<void>.delayed(const Duration(milliseconds: 50));

    // 4. Enter new page
    final nextPageKey = _getKey(_currentIndex);
    if (nextPageKey.currentState != null) {
      widget.onNewPage(_currentIndex);
      await nextPageKey.currentState!._animateEntrance(direction);
    }

    setState(() => _isAnimating = false);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        // Determine initial visibility
        final bool isInitialPage = index == 0 && !_hasNavigated;

        return ZipPage(
          key: _getKey(index),
          startVisible: isInitialPage,
          child: widget.builder(context, _indexToBuild),
        );
      },
    );
  }
}

/// A page that animates in and out one item at a time.
class ZipPage extends StatefulWidget {
  /// Instantiates a new [ZipPage].
  const ZipPage({
    required this.child,
    super.key,
    this.startVisible = true,
  });

  /// The child widget to display.
  final Widget child;

  /// Differentiates the initial page, which starts visible, from subsequent
  /// pages, which are invisible until animated-in.
  final bool startVisible;

  @override
  State<ZipPage> createState() => ZipPageState();

  /// Retrieves the [ZipPageState] for the nearest [ZipPage] ancestor.
  static ZipPageState? of(BuildContext context) {
    return context.findAncestorStateOfType<ZipPageState>();
  }
}

/// The state of a [ZipPage].
class ZipPageState extends State<ZipPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  int _childCount = 0;

  final Duration _itemDuration = const Duration(milliseconds: 400);
  final Duration _staggerDelay = const Duration(milliseconds: 100);

  // Default fly direction
  double _flyDirection = 1;

  int? _highestIndexRegistered;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: widget.startVisible ? 1 : 0,
      duration: const Duration(milliseconds: 1000),
    );
  }

  /// Allow dynamic updates to duration as items register
  void registerItem(int index) {
    _childCount++;
    _updateDuration(index);
  }

  void _updateDuration(int index) {
    if (_highestIndexRegistered == null) {
      _highestIndexRegistered = index;
    } else {
      _highestIndexRegistered = math.max(_highestIndexRegistered!, index);
    }
    final totalMs =
        (_highestIndexRegistered! * _staggerDelay.inMilliseconds) +
        _itemDuration.inMilliseconds;
    _controller.duration = Duration(milliseconds: totalMs);
  }

  Future<void> _animateExit(int swipeDirection) async {
    _flyDirection = -swipeDirection.toDouble();
    await _controller.reverse(); // Goes from 1.0 to 0.0
  }

  Future<void> _animateEntrance(int swipeDirection) async {
    _flyDirection = swipeDirection.toDouble();

    // Ensure we start at 0 (Hidden)
    _controller.value = 0.0;

    // Animate to 1 (Visible)
    await _controller.forward();
  }

  /// Retrieves the animation for the given item index.
  Animation<double> getItemAnimation(int index) {
    if (_childCount == 0) return const AlwaysStoppedAnimation(1);

    final totalMs = _controller.duration!.inMilliseconds;

    // EXITS (Reverse curve)
    // The current/original behavior: descending index order -> left-most out first.
    final exitStartMs = index * _staggerDelay.inMilliseconds;
    final exitEndMs = exitStartMs + _itemDuration.inMilliseconds;

    // ENTRANCES (Forward curve)
    // Invert the index so that left-most (highest index) animates in first,
    // then next right-most, etc.
    // _highestIndexRegistered is guaranteed to be correct here since indices
    // must be registered in descending order.
    final invertedIndex = (_highestIndexRegistered ?? index) - index;
    final entranceStartMs = invertedIndex * _staggerDelay.inMilliseconds;
    final entranceEndMs = entranceStartMs + _itemDuration.inMilliseconds;

    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          entranceStartMs / totalMs,
          math.min(1, entranceEndMs / totalMs),
          curve: Curves.easeOutExpo,
        ),
        reverseCurve: Interval(
          exitStartMs / totalMs,
          math.min(1, exitEndMs / totalMs),
          curve: Curves.easeOutExpo,
        ),
      ),
    );
  }

  /// The direction of the fly animation.
  double get flyDirection => _flyDirection;

  @override
  Widget build(BuildContext context) {
    _childCount = 0; // Reset count for rebuilds
    return widget.child;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
