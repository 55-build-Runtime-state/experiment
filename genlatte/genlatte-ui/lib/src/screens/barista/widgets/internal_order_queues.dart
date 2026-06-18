// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte/src/role.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/barista/widgets/widgets.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Renders cards for all orders ready for either moderation or brewing.
///
/// Baristas only see orders ready for brewing, but moderators see both queues
/// to better manage the entire latte bar.
class InternalOrderQueues extends StatelessWidget {
  /// Instantiates a [InternalOrderQueues] widget.
  const InternalOrderQueues._({
    required this.activeBarista,
    required this.canClaimOrders,
    required this.baristas,
    required this.orders,
    required this.role,

    // Moderation callbacks.
    required this.onApproveAll,
    required this.onRejectName,
    required this.onRejectImage,
    required this.onRejectBoth,

    // Brewing callbacks.
    required this.onClaimPressed,
    required this.onCompletePressed,
    required this.onReprintPressed,
    super.key,
  });

  /// Instantiates a [InternalOrderQueues] widget for a barista.
  factory InternalOrderQueues.barista({
    required Barista activeBarista,
    required bool canClaimOrders,
    required Map<String, Barista> baristas,
    required List<Latte> orders,
    required void Function(String) onClaimPressed,
    required void Function(String) onCompletePressed,
    required void Function(String) onReprintPressed,
    Key? key,
  }) => InternalOrderQueues._(
    activeBarista: activeBarista,
    baristas: baristas,
    canClaimOrders: canClaimOrders,
    orders: orders,
    role: .barista,
    onApproveAll: null,
    onRejectName: null,
    onRejectImage: null,
    onRejectBoth: null,
    onClaimPressed: onClaimPressed,
    onCompletePressed: onCompletePressed,
    onReprintPressed: onReprintPressed,
    key: key,
  );

  /// Instantiates a [InternalOrderQueues] widget for a barista.
  factory InternalOrderQueues.moderator({
    required Map<String, Barista> baristas,
    required List<Latte> orders,
    required void Function(String) onApproveAll,
    required void Function(String) onRejectName,
    required void Function(String) onRejectImage,
    required void Function(String) onRejectBoth,
    required void Function(String) onCompletePressed,
    Key? key,
  }) => InternalOrderQueues._(
    activeBarista: null,
    canClaimOrders: false,
    baristas: baristas,
    orders: orders,
    role: .moderator,
    onApproveAll: onApproveAll,
    onRejectName: onRejectName,
    onRejectImage: onRejectImage,
    onRejectBoth: onRejectBoth,
    onClaimPressed: null,
    onCompletePressed: onCompletePressed,
    onReprintPressed: null,
    key: key,
  );

  /// Non-null if the user is a barista.
  final Barista? activeBarista;

  /// Whether the barista can claim orders. If this is false, the "Claim" button
  /// should not be rendered.
  ///
  /// Irrelevant for moderators, who can never claim orders.
  final bool canClaimOrders;

  /// All baristas, used to look up barista info for brew queue.
  final Map<String, Barista> baristas;

  /// The role of the user viewing the queues. Must be either [Role.barista] or
  /// [Role.moderator].
  final Role role;

  /// Orders ready to be displayed.
  final List<Latte> orders;

  /// The barista has approved both the name and image for an order.
  final void Function(String)? onApproveAll;

  /// The barista has rejected the name for an order.
  final void Function(String)? onRejectName;

  /// The barista has rejected the image for an order.
  final void Function(String)? onRejectImage;

  /// The barista has rejected both the name and image for an order.
  final void Function(String)? onRejectBoth;

  /// The barista has claimed an order.
  final void Function(String)? onClaimPressed;

  /// The barista has completed an order.
  final void Function(String) onCompletePressed;

  /// The barista has requested to reprint an order.
  final void Function(String)? onReprintPressed;

  static const _whiteText = TextStyle(color: AppColors.white);

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, layoutInfo) {
        bool hasShownBrewLable = false;
        bool hasShownModerationLabel = false;

        Widget getModerationQueueLabelOnce() {
          final label = SizedBox(
            height: (layoutInfo.height * 0.1).clamp(50, 100),
            child: !hasShownModerationLabel
                ? Center(
                    child: const Text(
                      'Moderation Queue',
                      style: InternalOrderQueues._whiteText,
                    ).h3,
                  )
                : null,
          );
          hasShownModerationLabel = true;

          return label;
        }

        Widget getBrewQueueLabelOnce() {
          final label = SizedBox(
            height: (layoutInfo.height * 0.1).clamp(50, 100),
            child: !hasShownBrewLable
                ? Center(
                    child: const Text(
                      'Brew Queue',
                      style: InternalOrderQueues._whiteText,
                    ).h3,
                  )
                : null,
          );
          hasShownBrewLable = true;

          return label;
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: layoutInfo.width * 0.05),
          child: ListView.separated(
            scrollDirection: .horizontal,
            itemBuilder: (context, index) {
              final latte = orders[index];
              return Column(
                crossAxisAlignment: .start,
                children: <Widget>[
                  if (latte.metadata.status == LatteOrderStatus.submitted)
                    getModerationQueueLabelOnce(),
                  if (latte.metadata.status != LatteOrderStatus.submitted)
                    getBrewQueueLabelOnce(),
                  Expanded(
                    child:
                        role.isBarista ||
                            latte.metadata.status != LatteOrderStatus.submitted
                        ? LatteOrderCard.barista(
                            activeBarista: activeBarista,
                            canClaimOrders: canClaimOrders,
                            claimedBy: latte.metadata.baristaId != null
                                ? baristas[latte.metadata.baristaId]
                                : null,
                            latte: latte,
                            onApproveAll: onApproveAll,
                            onRejectName: onRejectName,
                            onRejectImage: onRejectImage,
                            onRejectBoth: onRejectBoth,
                            onClaimPressed: onClaimPressed,
                            onCompletePressed: onCompletePressed,
                            onReprintPressed: onReprintPressed,
                            role: role,
                            key: ValueKey(
                              '${latte.order.id}--${latte.metadata.status}',
                            ),
                          )
                        : LatteOrderCard.moderator(
                            latte: latte,
                            claimedBy: latte.metadata.baristaId != null
                                ? baristas[latte.metadata.baristaId]
                                : null,
                            onApproveAll: onApproveAll!,
                            onRejectName: onRejectName!,
                            onRejectImage: onRejectImage!,
                            onRejectBoth: onRejectBoth!,
                            onCompletePressed: onCompletePressed,
                            key: ValueKey(
                              '${latte.order.id}--${latte.metadata.status}',
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemCount: orders.length,
          ),
        );
      },
    );
  }
}
