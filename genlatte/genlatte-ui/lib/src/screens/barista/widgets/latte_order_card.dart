// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' show min, pi;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart'
    show ElevatedButton, IconButton, OutlinedButton;
import 'package:genlatte/src/role.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/barista/widgets/widgets.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide IconButton;
import 'package:text_responsive/text_responsive.dart';

/// A card representing a single latte order in the queue.
class LatteOrderCard extends StatefulWidget {
  /// Instantiates a [LatteOrderCard].
  const LatteOrderCard._({
    required this.activeBarista,
    required this.canClaimOrders,
    required this.claimedBy,
    required this.latte,
    required this.role,

    // Moderation callbacks
    required this.onApproveAll,
    required this.onRejectName,
    required this.onRejectImage,
    required this.onRejectBoth,

    // Brewing callbacks
    required this.onClaimPressed,
    required this.onCompletePressed,
    required this.onReprintPressed,

    super.key,
  });

  /// Instantiates a [LatteOrderCard] for a barista.
  ///
  /// [Role] is passed to the barista view of the card because moderators can
  /// see all submitted-but-not-completed orders, meaning some moderators will
  /// view the barista side of the card; and [role] represents the user's role;
  /// not the side of the card currently being shown.
  ///
  /// This is also why [onClaimPressed] and [onCompletePressed] are nullable;
  /// they are not operations that moderators can perform.
  factory LatteOrderCard.barista({
    required Barista? activeBarista,
    required bool canClaimOrders,
    required Barista? claimedBy,
    required Latte latte,
    required Role role,
    required void Function(String)? onApproveAll,
    required void Function(String)? onRejectName,
    required void Function(String)? onRejectImage,
    required void Function(String)? onRejectBoth,
    required void Function(String)? onClaimPressed,
    required void Function(String) onCompletePressed,
    required void Function(String)? onReprintPressed,
    Key? key,
  }) => LatteOrderCard._(
    activeBarista: activeBarista,
    canClaimOrders: canClaimOrders,
    claimedBy: claimedBy,
    latte: latte,
    role: role,
    onApproveAll: onApproveAll,
    onRejectName: onRejectName,
    onRejectImage: onRejectImage,
    onRejectBoth: onRejectBoth,
    onClaimPressed: onClaimPressed,
    onCompletePressed: onCompletePressed,
    onReprintPressed: onReprintPressed,
    key: key,
  );

  /// Instantiates a [LatteOrderCard] for a moderator.
  ///
  /// The moderator view of a card is more straightforward than its barista
  /// counterpart because only moderators ever view cards in the `.submitted`
  /// state (which could have been called "needsModeration").
  factory LatteOrderCard.moderator({
    required Latte latte,
    required Barista? claimedBy,
    required void Function(String) onApproveAll,
    required void Function(String) onRejectName,
    required void Function(String) onRejectImage,
    required void Function(String) onRejectBoth,
    required void Function(String) onCompletePressed,
    Key? key,
  }) => LatteOrderCard._(
    activeBarista: null,
    canClaimOrders: false,
    claimedBy: claimedBy,
    latte: latte,
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

  /// The order to display.
  final Latte latte;

  /// The role of the user viewing the card. Note that this is potentially
  /// separate from which side of the card is being displayed; specifically in
  /// the instance of a moderator viewing the barista side of the card.
  final Role role;

  /// The barista who has claimed the order, if the order is that far along.
  final Barista? claimedBy;

  /// Non-null if the user is a barista.
  final Barista? activeBarista;

  /// Whether the active barista can claim orders.
  ///
  /// Irrelevant for moderators.
  final bool canClaimOrders;

  /// MODERATION CALLBACKS ///

  /// Callback for when the user approves all.
  ///
  /// Guaranteed to be non-null when [role] == .moderator.
  final void Function(String)? onApproveAll;

  /// Callback for when the user rejects the name.
  ///
  /// Guaranteed to be non-null when [role] == .moderator.
  final void Function(String)? onRejectName;

  /// Callback for when the user rejects the image.
  ///
  /// Guaranteed to be non-null when [role] == .moderator.
  final void Function(String)? onRejectImage;

  /// Callback for when the user rejects both.
  ///
  /// Guaranteed to be non-null when [role] == .moderator.
  final void Function(String)? onRejectBoth;

  /// END MODERATION CALLBACKS ///

  ///
  ///

  /// BREWING CALLBACKS ///

  /// Callback for when the claim button is pressed.
  final void Function(String)? onClaimPressed;

  /// Callback for when the complete button is pressed.
  final void Function(String) onCompletePressed;

  /// Callback for when the reprint button is pressed.
  final void Function(String)? onReprintPressed;

  /// END BREWING CALLBACKS ///

  @override
  State<LatteOrderCard> createState() => _LatteOrderCardState();
}

class _LatteOrderCardState extends State<LatteOrderCard>
    with SingleTickerProviderStateMixin {
  bool _isFlipped = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
      value: needsModeration ? 0.0 : 1.0,
    );
  }

  bool get needsModeration => widget.latte.metadata.status == .submitted;

  void _toggleCard() {
    if (_isFlipped) {
      _controller.forward().ignore();
    } else {
      _controller.reverse().ignore();
    }
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Calculate the rotation value (0 to pi)
        final double rotationValue = _controller.value * pi;

        // Determine which side to show based on the 50% (pi/2) threshold.
        //
        // Note that this is different from `needsModeration`, which is a fact
        // about the state of an order, not a fact about the UI showing that
        // order.
        final bool showingModerationSide = rotationValue < (pi / 2);

        assert(
          () {
            if (showingModerationSide) {
              if (widget.onApproveAll == null ||
                  widget.onRejectName == null ||
                  widget.onRejectImage == null ||
                  widget.onRejectBoth == null) {
                throw Exception(
                  'Moderation callbacks are required for moderation side',
                );
              }
            }

            // If we are not on the moderation side, we are of course on the
            // brewing side. But, brewing callbacks are not required because
            // moderators have read-only access to the brew queue to gain a full
            // picture of the latte bar without actually fulfilling orders
            // directly.

            return true;
          }(),
          'Attempted to show Moderator side of card from Barista view',
        );

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Adds perspective/depth
            ..rotateY(rotationValue),
          alignment: Alignment.center,
          // If we are on the back side, we must flip the content
          // horizontally so it isn't mirrored.
          child: showingModerationSide
              ? _LatteOrderCardInner.moderate(
                  latte: widget.latte,
                  onApproveAll: () =>
                      widget.onApproveAll!(widget.latte.order.id!),
                  onRejectName: () =>
                      widget.onRejectName!(widget.latte.order.id!),
                  onRejectImage: () =>
                      widget.onRejectImage!(widget.latte.order.id!),
                  onRejectBoth: () =>
                      widget.onRejectBoth!(widget.latte.order.id!),
                  // Cards *requiring* moderation cannot be flipped to their
                  // brewing side, as brewing is not available until *after*
                  // moderation is completed.
                  onComplete: () =>
                      widget.onCompletePressed(widget.latte.order.id!),
                  onFlipPressed: widget.role.isModerator ? _toggleCard : null,
                )
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(pi),
                  child: _LatteOrderCardInner.brew(
                    activeBarista: widget.activeBarista,
                    canClaimOrders: widget.canClaimOrders,
                    claimedBy: widget.claimedBy,
                    latte: widget.latte,
                    onClaimPressed: widget.onClaimPressed != null
                        ? () => widget.onClaimPressed!(widget.latte.order.id!)
                        : null,
                    onCompletePressed: () =>
                        widget.onCompletePressed(widget.latte.order.id!),
                    onReprintPressed: widget.onReprintPressed != null
                        ? () => widget.onReprintPressed!(widget.latte.order.id!)
                        : null,
                    // Conversely, cards *not* requiring moderation can always
                    role: widget.role,
                    // be flipped to their moderation side to change past
                    // be flipped to their moderation side to change past
                    // decisions, and then of course back again.
                    onFlipPressed: widget.role.isModerator ? _toggleCard : null,
                  ),
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _LatteOrderCardInner extends StatelessWidget {
  const _LatteOrderCardInner._({
    required this.activeBarista,
    required this.canClaimOrders,
    required this.claimedBy,
    required this.latte,
    required this.onApproveAll,
    required this.onRejectName,
    required this.onRejectImage,
    required this.onRejectBoth,
    required this.onClaimPressed,
    required this.onCompletePressed,
    required this.onReprintPressed,
    required this.onFlipPressed,
    required this.role,
  });

  /// Creates the moderation side of the card.
  factory _LatteOrderCardInner.moderate({
    required Latte latte,
    required VoidCallback onApproveAll,
    required VoidCallback onRejectName,
    required VoidCallback onRejectImage,
    required VoidCallback onRejectBoth,
    required VoidCallback? onFlipPressed,
    required VoidCallback onComplete,
  }) => _LatteOrderCardInner._(
    activeBarista: null,
    canClaimOrders: false,
    claimedBy: null,
    latte: latte,
    onApproveAll: onApproveAll,
    onRejectName: onRejectName,
    onRejectImage: onRejectImage,
    onRejectBoth: onRejectBoth,
    onClaimPressed: null,
    onCompletePressed: onComplete,
    onReprintPressed: null,
    onFlipPressed: onFlipPressed,
    role: .moderator,
  );

  /// Creates the brewing side of the card.
  factory _LatteOrderCardInner.brew({
    required Barista? activeBarista,
    required bool canClaimOrders,
    required Barista? claimedBy,
    required Latte latte,
    required VoidCallback? onClaimPressed,
    required VoidCallback onCompletePressed,
    required VoidCallback? onReprintPressed,
    required VoidCallback? onFlipPressed,
    required Role role,
  }) => _LatteOrderCardInner._(
    activeBarista: activeBarista,
    canClaimOrders: canClaimOrders,
    claimedBy: claimedBy,
    latte: latte,
    onApproveAll: null,
    onRejectName: null,
    onRejectImage: null,
    onRejectBoth: null,
    onClaimPressed: onClaimPressed,
    onCompletePressed: onCompletePressed,
    onReprintPressed: onReprintPressed,
    onFlipPressed: onFlipPressed,
    role: role,
  );

  final Latte latte;
  final Barista? claimedBy;
  final bool canClaimOrders;

  /// Non-null if the user is a barista.
  final Barista? activeBarista;

  // Moderation callbacks.

  final VoidCallback? onApproveAll;
  final VoidCallback? onRejectName;
  final VoidCallback? onRejectImage;
  final VoidCallback? onRejectBoth;

  // Brewing callbacks.

  final VoidCallback? onClaimPressed;
  final VoidCallback onCompletePressed;
  final VoidCallback? onReprintPressed;
  final Role role;

  // UI callbacks.

  final VoidCallback? onFlipPressed;

  bool get _isActive =>
      _isMe && latte.metadata.status == LatteOrderStatus.inProgress;

  bool get _isMe =>
      activeBarista != null &&
      claimedBy != null &&
      activeBarista?.id == claimedBy?.id;

  /// Arbitrary numbers picked by fair die roll.
  static const _idealSize = Size(230, 420);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizedBox.builder(
      aspectRatioClamp: (null, _idealSize.aspectRatio, null),
      builder: (context, size) {
        final heightScaleFactor = size.height / _idealSize.height;
        final scaleFactor = min(
          size.width / _idealSize.width,
          heightScaleFactor,
        );

        final padding = 20 * scaleFactor;

        final bool isActive = _isActive;

        return Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16 * scaleFactor),
            border: isActive
                ? Border.all(
                    color: const Color(0xFF3B82F6),
                    width: 8 * scaleFactor,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: isActive
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.25)
                    : Colors.black.withValues(alpha: 0.08),
                blurRadius: isActive ? 40 * scaleFactor : 25 * scaleFactor,
                spreadRadius: isActive ? 4 * scaleFactor : 0,
                offset: Offset(0, 10 * scaleFactor),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: .stretch,
            children: [
              // Context Header
              Expanded(
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      'Order #${latte.metadata.orderNumber}',
                      style: TextStyle(
                        fontSize: 11 * scaleFactor,
                        color: const Color(0xFF444444),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    HumanizedCountdown(
                      label: 'Submitted',
                      timestamp: latte.metadata.orderSubmittedTime!,
                      textStyle: TextStyle(
                        fontSize: 11 * scaleFactor,
                        color: const Color(0xFF444444),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: ImageStack(latte: latte, scaleFactor: scaleFactor),
              ),

              SizedBox(height: 16 * scaleFactor),

              // Action Buttons
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: onApproveAll != null
                      ? _buildModerationButtons(
                          scaleFactor,
                          heightScaleFactor,
                        )
                      : _buildBrewButtons(scaleFactor, canClaimOrders),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: kDebugMode || role == .moderator
                          ? ClipboardValue(
                              '${latte.order.id}',
                              label: 'Order Id',
                            )
                          : const SizedBox.shrink(),
                    ),
                    const Spacer(),
                    if (onFlipPressed != null &&
                        // Don't show flip button on submitted orders. Order
                        // cards are only flippable *after* moderation is
                        // complete.
                        latte.metadata.status != .submitted)
                      IconButton(
                        onPressed: onFlipPressed,
                        icon: const Icon(Icons.flip),
                      ),
                    if (onFlipPressed == null) //
                      const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildBrewButtons(double scaleFactor, bool canClaimOrders) {
    return <Widget>[
      Row(
        children: <Widget>[
          Expanded(child: _buildStatusBadge(scaleFactor)),
          const SizedBox(width: 8),
          Expanded(
            child: _buildButtonOrAssigneBanner(scaleFactor, canClaimOrders),
          ),
        ],
      ),
      SizedBox(height: 16 * scaleFactor),
      OrderDetailsWidget(
        scaleFactor: scaleFactor,
        details: <OrderDetailItem>[
          OrderDetailItem(
            icon: const Icon(Icons.local_drink),
            label: 'Milk:',
            value: latte.order.milk!,
          ),
          OrderDetailItem(
            icon: const Icon(Icons.cookie),
            label: 'Sweetener:',
            value: latte.order.sweetener!,
          ),

          /// Always the same for Cloud Next, but will vary at I/O and beyond.
          OrderDetailItem(
            icon: const Icon(Icons.coffee),
            label: 'Drink type:',
            value: 'Latte',
          ),
        ],
      ),
      SizedBox(height: 16 * scaleFactor),
    ];
  }

  List<Widget> _buildModerationButtons(
    double scaleFactor,
    double heightScaleFactor,
  ) => [
    _buildModerateButton(
      label: '✓ Approve All',
      shortcut: 'A',
      backgroundColor: const Color(0xFF10B981),
      textColor: Colors.white,
      shortcutColor: Colors.white.withValues(alpha: 0.3),
      onPressed: onApproveAll!,
      scaleFactor: scaleFactor,
      heightScaleFactor: heightScaleFactor,
    ),
    SizedBox(height: 12 * scaleFactor),
    Row(
      children: [
        Expanded(
          child: _buildModerateButton(
            label: '⚠️ Reject Name',
            shortcut: 'N',
            backgroundColor: const Color(0xFFFFFBEB),
            textColor: const Color(0xFFD97706),
            borderColor: const Color(0xFFFCD34D),
            shortcutColor: Colors.black.withValues(
              alpha: 0.05,
            ),
            onPressed: onRejectName!,
            scaleFactor: scaleFactor,
            heightScaleFactor: heightScaleFactor,
          ),
        ),
        SizedBox(width: 12 * scaleFactor),
        Expanded(
          child: _buildModerateButton(
            label: '⚠️ Reject Image',
            shortcut: 'I',
            backgroundColor: const Color(0xFFFFFBEB),
            textColor: const Color(0xFFD97706),
            borderColor: const Color(0xFFFCD34D),
            shortcutColor: Colors.black.withValues(
              alpha: 0.05,
            ),
            onPressed: onRejectImage!,
            scaleFactor: scaleFactor,
            heightScaleFactor: heightScaleFactor,
          ),
        ),
      ],
    ),
    SizedBox(height: 12 * scaleFactor),
    _buildModerateButton(
      label: '❌ Reject Both',
      shortcut: 'R',
      backgroundColor: const Color(0xFFFEE2E2),
      textColor: const Color(0xFFDC2626),
      borderColor: const Color(0xFFFECACA),
      shortcutColor: Colors.black.withValues(alpha: 0.05),
      onPressed: onRejectBoth!,
      scaleFactor: scaleFactor,
      heightScaleFactor: heightScaleFactor,
    ),
  ];

  Widget _buildButtonOrAssigneBanner(double scaleFactor, bool canClaimOrders) {
    if (claimedBy == null && onClaimPressed != null) {
      if (!canClaimOrders) {
        return const Text(
          'Choose a Printer',
          textAlign: .end,
          style: TextStyle(color: AppColors.googleIntroRed),
        ).bold;
      }
      return ElevatedButton(
        onPressed: onClaimPressed,
        style: ElevatedButton.styleFrom(
          // minimumSize: Size.zero,
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          // elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 6 * scaleFactor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Claim Order',
          style: TextStyle(
            fontSize: 12 * scaleFactor,
          ),
        ),
      );
    } else if (_isMe) {
      return ElevatedButton(
        onPressed: onCompletePressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 6 * scaleFactor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Complete',
          style: TextStyle(
            fontSize: 12 * scaleFactor,
          ),
        ),
      );
    } else if (role.isModerator &&
        latte.metadata.status == LatteOrderStatus.inProgress) {
      return ElevatedButton(
        onPressed: onCompletePressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 6 * scaleFactor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Complete',
          style: TextStyle(
            fontSize: 12 * scaleFactor,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildStatusBadge(double scaleFactor) {
    if (_isActive && onReprintPressed != null) {
      return _ReprintButton(
        onReprintPressed: onReprintPressed!,
        scaleFactor: scaleFactor,
      );
    } else if (_isActive) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14 * scaleFactor,
        vertical: 4 * scaleFactor,
      ),
      decoration: BoxDecoration(
        color: claimedBy != null
            ? const Color(0xFFF3E8FF)
            : const Color(0xFFE0F2FE),
        borderRadius: BorderRadius.circular(20 * scaleFactor),
      ),
      child: ParagraphTextWidget(
        claimedBy != null ? claimedBy!.username : 'PENDING',
        maxLines: 1,
        textAlign: .center,
        style: TextStyle(
          fontSize: 10 * scaleFactor,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          color: claimedBy != null
              ? const Color(0xFF7E22CE)
              : const Color(0xFF0369A1),
        ),
      ),
    );
  }

  Widget _buildAssigneeBanner(double scaleFactor) {
    // Claimed State Banner
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3 * scaleFactor,
        vertical: 3 * scaleFactor,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8 * scaleFactor),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: ParagraphTextWidget(
          claimedBy!.username,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      ),
    );
  }

  // Helper method to keep button styling consistent and code DRY
  Widget _buildModerateButton({
    required String label,
    required String shortcut,
    required Color backgroundColor,
    required Color textColor,
    required Color shortcutColor,
    required VoidCallback onPressed,
    required double scaleFactor,
    required double heightScaleFactor,
    Color? borderColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 12 * heightScaleFactor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8 * scaleFactor),
          side: borderColor != null
              ? BorderSide(color: borderColor)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: .center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10 * scaleFactor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReprintButton extends StatefulWidget {
  const _ReprintButton({
    required this.onReprintPressed,
    required this.scaleFactor,
  });

  final VoidCallback onReprintPressed;
  final double scaleFactor;

  @override
  State<_ReprintButton> createState() => _ReprintButtonState();
}

class _ReprintButtonState extends State<_ReprintButton> {
  bool _isPrinting = false;

  Future<void> _handlePress() async {
    if (_isPrinting) return;

    setState(() => _isPrinting = true);
    widget.onReprintPressed();

    await Future<void>.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() => _isPrinting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _isPrinting ? null : _handlePress,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF3B82F6),
        disabledForegroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.5),
        side: BorderSide(
          color: _isPrinting
              ? const Color(0xFF3B82F6).withValues(alpha: 0.5)
              : const Color(0xFF3B82F6),
        ),
        padding: EdgeInsets.symmetric(vertical: 6 * widget.scaleFactor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: _isPrinting
          ? SizedBox(
              width: 14 * widget.scaleFactor,
              height: 14 * widget.scaleFactor,
              child: const CircularProgressIndicator(),
            )
          : Text(
              '⬆️ Printer',
              style: TextStyle(
                fontSize: 10 * widget.scaleFactor,
              ),
            ),
    );
  }
}
