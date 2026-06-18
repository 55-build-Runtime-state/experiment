// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/queue/widgets/order_list.dart';
import 'package:genlatte/src/screens/queue/widgets/status_icon.dart';
import 'package:genlatte/src/widgets/latte_image.dart';
import 'package:genlatte_data/models.dart';
import 'package:logging/logging.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OrderListItem extends StatefulWidget {
  const OrderListItem(
    this.latte, {
    required this.positionInList,
    required this.listLength,
    required this.transitionAnimation,
    required this.animationDuration,
    required this.maxRecentAge,
    required this.addBottomDivider,
    super.key,
  });

  final Latte? latte;

  final int positionInList;

  final int listLength;

  final Animation<double> transitionAnimation;

  final Duration animationDuration;

  final Duration maxRecentAge;

  final bool addBottomDivider;

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  static final Logger _log = Logger('$_OrderListItemState');

  /// Keeps ahold of the latest order we showed so that we can properly
  /// transition to whatever is the current one.
  Latte? _previous;

  bool _previouslyNeededDivider = false;

  @override
  Widget build(BuildContext context) {
    final current = widget.latte;

    final animateIn = widget.transitionAnimation.drive(
      // Animating from the bottom up (the later the position, the sooner
      // we start animating).
      //
      // The sequence goes something like this, assuming this is order 2 of 4.
      //
      // 1                    ___________________
      //                  ___/
      //              ___/
      // 0  _________/
      //    ^        ^        ^        ^        ^
      //    Start    Order 2  Order 3  Order 4  End
      TweenSequence<double>([
        if (widget.positionInList < widget.listLength - 1)
          TweenSequenceItem(
            tween: ConstantTween(0),
            weight: widget.listLength - widget.positionInList - 1,
          ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: 1),
          weight: 1,
        ),
        if (widget.positionInList > 0)
          TweenSequenceItem(
            tween: ConstantTween(1),
            weight: widget.positionInList.toDouble(),
          ),
      ]),
    );
    late final animateOut = ReverseAnimation(animateIn);

    final now = DateTime.now();

    Widget widgetForLatte(Latte latte, bool needsDivider) {
      final String text;
      if (latte.metadata.isImageApproved == true && latte.order.name != null) {
        text = latte.order.name!;
      } else {
        final number = latte.metadata.orderNumber;
        if (number != null) {
          text = 'Order #$number';
        } else {
          text = 'Mysterious order';
        }
      }

      final OrderStatus state;
      final submittedTime = latte.metadata.orderSubmittedTime;
      final completionTime = latte.metadata.completionTime;
      final sinceCompletion = completionTime != null
          ? now.difference(completionTime)
          : null;
      if (sinceCompletion != null && sinceCompletion > widget.maxRecentAge) {
        state = .completed;
      } else if (sinceCompletion != null) {
        state = .recentlyCompleted;
      } else if (latte.metadata.status == .inProgress) {
        state = .atBarista;
      } else if (submittedTime != null) {
        state = .visible;
      } else {
        _log.warning(
          'Non-submitted item somehow made it into the queue: $latte',
        );
        return const SizedBox();
      }

      return Column(
        children: [
          Expanded(
            child: _OrderWidget(
              text: text,
              imageUrl: latte.metadata.isImageApproved == true
                  ? latte.metadata.imageUrl
                  : null,
              status: state,
            ),
          ),
          ColoredBox(
            color: needsDivider
                ? AppColors.placeholderGrey
                : AppColors.transparent,
            child: const SizedBox(
              width: double.infinity,
              height: 3,
            ),
          ),
        ],
      );
    }

    // TODO(filiph): this widget should try to have more stable children
    //               especially if we're going from same id to same id
    return switch ((_previous, current)) {
      (null, null) => const SizedBox.expand(),
      (final Latte previous, null) => SlideTransition(
        position:
            Tween<Offset>(
              begin: const Offset(0, -0.1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animateOut,
                curve: Curves.easeOutCubic,
              ),
            ),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: animateOut,
            curve: Curves.easeInCubic,
          ),
          child: widgetForLatte(previous, _previouslyNeededDivider),
        ),
      ),
      (null, final Latte current) => SlideTransition(
        position:
            Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animateIn,
                curve: Curves.easeOutCubic,
              ),
            ),
        child: FadeTransition(
          opacity: animateIn,
          child: widgetForLatte(current, widget.addBottomDivider),
        ),
      ),
      (final Latte previous, final Latte current) =>
        (previous.order.id == current.order.id)
            // A subtle fade when we're just updating an order.
            ? Stack(
                fit: .passthrough,
                children: [
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animateOut,
                      curve: Curves.easeOut,
                    ),
                    child: widgetForLatte(previous, _previouslyNeededDivider),
                  ),
                  FadeTransition(
                    opacity: animateIn,
                    child: widgetForLatte(current, widget.addBottomDivider),
                  ),
                ],
              )
            // A proper fly in / fly out when changing orders.
            : Stack(
                fit: .passthrough,
                children: [
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animateOut,
                      curve: Curves.easeIn,
                    ),
                    child: widgetForLatte(previous, _previouslyNeededDivider),
                  ),
                  SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0, 0.05),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animateIn,
                            curve: Curves.easeOut,
                          ),
                        ),
                    child: FadeTransition(
                      opacity: animateIn,
                      child: widgetForLatte(current, widget.addBottomDivider),
                    ),
                  ),
                ],
              ),
    };
  }

  @override
  void didUpdateWidget(covariant OrderListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.transitionAnimation != widget.transitionAnimation) {
      oldWidget.transitionAnimation.removeStatusListener(
        _onAnimationStatusChange,
      );
      widget.transitionAnimation.addStatusListener(_onAnimationStatusChange);
    }
  }

  @override
  void dispose() {
    widget.transitionAnimation.removeStatusListener(_onAnimationStatusChange);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.transitionAnimation.addStatusListener(_onAnimationStatusChange);
  }

  void _onAnimationStatusChange(AnimationStatus status) {
    if (status == .completed) {
      _previous = widget.latte;
      _previouslyNeededDivider = widget.addBottomDivider;
    }
  }
}

class _OrderWidget extends StatelessWidget {
  const _OrderWidget({
    required this.text,
    required this.imageUrl,
    required this.status,
  });

  final String text;

  final String? imageUrl;

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // The available height functions as a "unit of measurement"
        // so that the proportions of the design are constant no matter
        // how big or small the layout is.
        final height = constraints.maxHeight;

        return Row(
          children: [
            SizedBox(
              width: height * 0.64,
              child: imageUrl == null
                  ? const LatteImageWidget(
                      imageUrl: OrderList.fallbackImageUrl,
                      topScaleRatio: 0.50,
                      thumbnailSize: true,
                    )
                  : LatteImageWidget(
                      // Adding a key here makes sure the circle avatar
                      // gets replaced as soon as the image url changes.
                      // Otherwise, there's a short glitch when new image shows
                      // up before the transition.
                      key: Key(imageUrl!),
                      imageUrl: imageUrl!,
                      thumbnailSize: true,
                    ),
            ),
            SizedBox(width: height * 0.20),
            Expanded(
              child: WrappedText(
                style: (context, theme) => theme.typography.h1.copyWith(
                  fontSize: height * 0.44,
                ),
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
                // TODO(filiph): This should say "Your latte is ready!"
                //               when recentlyCompleted or above.
              ),
            ),
            if (status == .recentlyCompleted || status == .completed)
              const Text('Your latte is ready!').h3
            else
              const SizedBox.shrink(),
            SizedBox(
              width: height * 0.36,
            ),
            StatusIcon(
              icon: Symbols.schedule,
              size: height * 0.52,
              status: switch (status) {
                .visible => .active,
                .atBarista => .done,
                .recentlyCompleted => .done,
                .completed => .done,
              },
            ),
            SizedBox(
              width: height * 0.26,
            ),
            StatusIcon(
              icon: Icons.image,
              size: height * 0.52,
              status: switch (status) {
                .visible => .notYet,
                .atBarista => .active,
                .recentlyCompleted => .done,
                .completed => .done,
              },
            ),
            SizedBox(
              width: height * 0.26,
            ),
            StatusIcon(
              icon: Icons.local_cafe,
              size: height * 0.52,
              status: switch (status) {
                .visible => .notYet,
                .atBarista => .notYet,
                .recentlyCompleted => .active,
                .completed => .done,
              },
            ),
            SizedBox(
              width: height * 0.06,
            ),
          ],
        );
      },
    );
  }
}
