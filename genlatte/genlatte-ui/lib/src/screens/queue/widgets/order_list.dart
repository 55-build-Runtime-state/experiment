// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/queue/home/queue_home.dart';
import 'package:genlatte/src/screens/queue/widgets/order_list_item.dart';
import 'package:genlatte/src/widgets/triple_tap.dart';
import 'package:genlatte/src/widgets/typography.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OrderList extends StatefulWidget {
  const OrderList({
    required this.pages,
    required this.onSlotsCounted,
    required this.maxRecentAge,
    required this.targetRowHeight,
    required this.noOrdersInAnyShard,
    required this.pageUpdatePeriod,
    super.key,
  });

  /// Image used for latte orders whose images aren't approved (yet).
  ///
  /// Follows the example of
  /// https://github.com/GoogleCloudDemos/gcdemos-26-int-dd-latteart/pull/197.
  static const fallbackImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/gcdemos-26-int-dd-latteart.firebasestorage.app/o/latteImages%2FfallbackImage%2Ficon_flutter.png?alt=media&token=06a3ac7e-7929-4507-8105-9eddb4445892';

  final List<OrderPage> pages;

  final void Function(int) onSlotsCounted;

  final Duration maxRecentAge;

  final Duration pageUpdatePeriod;

  final double targetRowHeight;

  final bool noOrdersInAnyShard;

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList>
    with SingleTickerProviderStateMixin<OrderList> {
  static final Logger _logger = Logger('$_OrderListState');

  /// The amount of time before every tick when we preload images.
  static const Duration _preloadDuration = Duration(seconds: 1);

  /// The length of the transition of each row in the list.
  static const Duration _rowTransitionDuration = Duration(milliseconds: 250);

  late final _transitionController = AnimationController(vsync: this);

  /// The tick that fires every N seconds since midnight. This ensures that
  /// multiple displays all update at the same time.
  Timer? _tickTimer;

  /// To prevent ugly image loading flashes, we preload images
  /// a small amount of time ([_preloadDuration]) before every tick.
  Timer? _preloadTimer;

  int currentPageIndex = 0;

  List<OrderPage> currentPages = const [];

  List<OrderPage> nextPages = const [];

  @override
  Widget build(BuildContext context) {
    return _Padding(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              TripleTapDetector(
                semanticLabel: 'Screen headline',
                semanticHint: 'Triple tap to log out',
                onPressed: () => GetIt.I<FirebaseAuth>().signOut(),
                child: const Text('Order progress').h3,
              ),
              const Spacer(),
              _PageIndicator(
                currentPageIndex: currentPageIndex,
                pageOrderCounts: currentPages
                    .map((p) => p.orders.nonNulls.length)
                    .toList(growable: false),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const ColoredBox(
            color: AppColors.placeholderGrey,
            child: SizedBox(width: double.infinity, height: 6),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // TODO(filiph): add a heuristic that selects the best height
                //               according to orientation
                final slotsAvailable =
                    (constraints.maxHeight / widget.targetRowHeight).floor();
                widget.onSlotsCounted(slotsAvailable);

                if (currentPageIndex >= currentPages.length) {
                  if (widget.noOrdersInAnyShard) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: .center,
                        spacing: 16,
                        children: [
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Yes, you '),
                                TextSpan(
                                  text: 'need',
                                  style: TextStyle(decoration: .underline),
                                ),
                                TextSpan(text: ' coffee.'),
                              ],
                            ),
                          ).h2_,
                          const Text('Waiting for the first order.'),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.expand();
                  }
                }
                final page = currentPages[currentPageIndex];

                return Column(
                  crossAxisAlignment: .start,
                  children: [
                    for (final (index, item) in page.orders.indexed)
                      Expanded(
                        key: Key('position-$index'),
                        child: OrderListItem(
                          item,
                          positionInList: index,
                          listLength: page.orders.length,
                          transitionAnimation: _transitionController,
                          animationDuration: _rowTransitionDuration,
                          maxRecentAge: widget.maxRecentAge,
                          addBottomDivider:
                              item != null && index < page.orders.length - 1,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          const ColoredBox(
            color: AppColors.placeholderGrey,
            child: SizedBox(
              width: double.infinity,
              height: 6,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant OrderList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.pages != nextPages) {
      _logger.fine('nextPages updated in didUpdateWidget()');
      nextPages = widget.pages;
    }
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    _preloadTimer?.cancel();
    _transitionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    currentPages = widget.pages;
    nextPages = widget.pages;

    _startTransitionAnimation();
    _startTickTimer();
  }

  void _preloadImages() {
    if (!mounted) {
      _logger.info('_preloadImages() called after widget unmount, skipping');
      return;
    }

    // Extract image urls from the orders that are going to be shown next.
    // It's still possible for a new order to show up between now and the next
    // tick, but the chances are low.
    final urls = nextPages
        .expand((page) => page.orders)
        .nonNulls
        .map(
          (o) =>
              o.metadata.isImageApproved == true ? o.metadata.imageUrl : null,
        )
        .nonNulls
        .followedBy(const [OrderList.fallbackImageUrl]);

    for (final imageUrl in urls) {
      precacheImage(
        NetworkImage(imageUrl),
        context,
        onError: (e, s) => _logger.fine('Error when precaching image', e, s),
      ).then((_) => _logger.finest('Image preloaded: $imageUrl')).ignore();
    }

    precacheImage(
      const AssetImage('assets/latte-background-thumb.png'),
      context,
      onError: (e, s) =>
          _logger.fine('Error when precaching latte background image', e, s),
    ).then((_) => _logger.finest('Latte background image preloaded')).ignore();
  }

  void _startTickTimer() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    final timeInMs = now.difference(midnight).inMilliseconds;
    final periodInMs = widget.pageUpdatePeriod.inMilliseconds;
    final nextBoundaryInMs =
        // Round up.
        (timeInMs / periodInMs).ceil() * periodInMs;
    final delayMs = nextBoundaryInMs - timeInMs;
    final delay = Duration(milliseconds: delayMs);

    _tickTimer?.cancel();
    _tickTimer = Timer(delay, _tick);

    _preloadTimer?.cancel();
    if (delay > _preloadDuration) {
      // We have time to schedule preloading, too.
      _preloadTimer = Timer(delay - _preloadDuration, _preloadImages);
    }
  }

  void _startTransitionAnimation() {
    if (currentPages.isEmpty) return;
    final listLength = currentPages[currentPageIndex].orders.length;
    _transitionController.duration = _rowTransitionDuration * listLength;
    unawaited(_transitionController.forward(from: 0));
  }

  /// Each tick, we either go to the next page of [currentPages],
  /// or (if all pages have been shown), we switch to [nextPages] a start anew.
  ///
  /// Called periodically via [_tickTimer].
  void _tick() {
    if (!mounted) {
      _logger.info('_tick() called after widget unmount, skipping');
      return;
    }

    final bool hasFinishedWithCurrentPages;
    if (currentPages.isEmpty) {
      hasFinishedWithCurrentPages = true;
    } else {
      hasFinishedWithCurrentPages = currentPageIndex >= currentPages.length - 1;
    }

    if (hasFinishedWithCurrentPages) {
      setState(() {
        currentPageIndex = 0;
        currentPages = nextPages;
      });
      _logger.fine(
        'Switching to new list of pages, '
        'showing page 1 of ${currentPages.length}',
      );
    } else {
      setState(() => currentPageIndex += 1);
      _logger.fine(
        'Showing page ${currentPageIndex + 1} '
        'of ${currentPages.length}',
      );
    }

    _startTransitionAnimation();
    _startTickTimer();
  }
}

class _Padding extends StatelessWidget {
  const _Padding({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.placeholderGrey, width: 16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(64, 40, 64, 57),
        child: child,
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.pageOrderCounts,
    required this.currentPageIndex,
  });

  static const int minPages = 3;

  static const double width = 40;

  static const double height = 30;

  final List<int> pageOrderCounts;

  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    if (pageOrderCounts.isEmpty) {
      return const SizedBox(width: minPages * width, height: height);
    }

    final pageCount = pageOrderCounts.length;
    final orderCountMax = pageOrderCounts.fold(0, max);

    return SizedBox(
      width: max(pageOrderCounts.length, minPages) * width,
      height: height,
      child: Stack(
        fit: .expand,
        children: [
          for (final (index, count) in pageOrderCounts.indexed)
            Positioned(
              right: (pageCount - index - 1) * width,
              width: width,
              top: 0,
              bottom: 0,
              child: _PageIndicatorIcon(
                orderCount: count,
                orderCountMax: orderCountMax,
                width: width,
              ),
            ),
          AnimatedPositioned(
            right: (pageCount - currentPageIndex - 1) * width,
            width: width,
            top: 0,
            bottom: 0,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.placeholderGrey, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicatorIcon extends StatelessWidget {
  const _PageIndicatorIcon({
    required this.orderCountMax,
    required this.width,
    required this.orderCount,
  });

  final int orderCount;

  final int orderCountMax;

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: 1,
          children: [
            for (var i = 0; i < orderCountMax; i++)
              Expanded(
                child: ColoredBox(
                  color: i < orderCount
                      ? AppColors.placeholderGrey
                      : AppColors.transparent,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
