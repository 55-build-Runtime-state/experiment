// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/recent_orders/home/recent_orders_home.dart';
import 'package:genlatte/src/screens/recent_orders/models/models.dart';
import 'package:genlatte/src/screens/recent_orders/widgets/widgets.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide OverflowMarquee;

/// {@template RecentOrdersHomeScreen}
/// Initial RecentOrdersHome screen.
/// {@endtemplate}
class RecentOrdersHomeScreen extends StatefulWidget {
  /// {@macro RecentOrdersHomeScreen}
  const RecentOrdersHomeScreen({super.key});

  @override
  State<RecentOrdersHomeScreen> createState() => _RecentOrdersHomeScreenState();
}

class _RecentOrdersHomeScreenState extends State<RecentOrdersHomeScreen> {
  final RecentOrdersHomeBloc bloc = RecentOrdersHomeBloc(
    numberOfImages: _startingLattePositions.length,
  );

  // TODO(craiglabenz): DELETE THIS.
  // This is only for testing the arrival of new images.
  // final _recentImagesRepo = RecentLatteImagesRepository();

  static const _basePortraitSize = Size(720, 1200);
  static const _baseLandscapeSize = Size(1200, 720);

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, layoutInfo) {
        final scale = layoutInfo.orientation.isLandscape
            ? layoutInfo.width / _baseLandscapeSize.width
            : layoutInfo.height / _basePortraitSize.height;

        final genLatteBannerTopPadding = 30 * scale;
        final genLatteBannerHeight = 50 * scale;
        final totalGenLatteHeight =
            genLatteBannerTopPadding + genLatteBannerHeight;
        return BlocBuilder<RecentOrdersHomeBloc, RecentOrdersHomeState>(
          bloc: bloc,
          builder: (context, state) {
            return SafeArea(
              top: !kIsWeb,
              left: false,
              bottom: false,
              right: false,
              child: Scaffold(
                backgroundColor: AppColors.white,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _LatteImagesInner(
                        activeImage: state.activeImage,
                        clearActiveImage: () =>
                            bloc.add(const SetActiveImage(null)),
                        images: state.images,
                        layoutInfo: layoutInfo,
                        setActiveImage: (image) =>
                            bloc.add(SetActiveImage(image)),
                      ),
                    ),
                    Positioned(
                      top: genLatteBannerTopPadding,
                      width: layoutInfo.width,
                      height: genLatteBannerHeight,
                      child: Center(
                        child: TripleTapDetector(
                          semanticLabel: 'Header',
                          semanticHint: 'Triple tap to sign out',
                          onPressed: () => GetIt.I<FirebaseAuth>().signOut(),
                          child: Text(
                            'GenLatte',
                            style: TextStyle(fontSize: 48 * scale),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: totalGenLatteHeight + genLatteBannerTopPadding,
                      height: genLatteBannerHeight,
                      width: layoutInfo.width,
                      child: Center(
                        child: Footer(
                          fontColor: AppColors.black,
                          uiScale: layoutInfo.width / 560,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   right: 20,
                    //   bottom: 20,
                    //   height: 45,
                    //   width: 150,
                    //   child: GenLatteOutlinedButton.dark(
                    //     label: 'Add new image',
                    //     onPressed: _recentImagesRepo.addRandomRecentImage,
                    //   ),
                    // ),
                    if (state.activeImage != null)
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () => bloc.add(const SetActiveImage(null)),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Future<void> dispose() async {
    await bloc.close();
    super.dispose();
  }
}

/// The inner widget that manages the floating latte images, their physics,
/// and the transition between list and detail views.
class _LatteImagesInner extends StatefulWidget {
  const _LatteImagesInner({
    required this.activeImage,
    required this.clearActiveImage,
    required this.images,
    required this.layoutInfo,
    required this.setActiveImage,
  });

  final RecentLatteImage? activeImage;
  final VoidCallback clearActiveImage;
  final List<RecentLatteImage> images;
  final LayoutInformation layoutInfo;
  final void Function(RecentLatteImage) setActiveImage;

  @override
  State<_LatteImagesInner> createState() => _LatteImagesInnerState();
}

class _LatteImagesInnerState extends State<_LatteImagesInner>
    with TickerProviderStateMixin {
  /// The current physics state of all latte "slots" on the screen.
  List<LattePosition> _lattePositions = [];

  /// The timer that drives the 60fps physics simulation.
  Timer? _timer;

  /// The images that are currently playing their Thanos snap animation.
  final List<_SnappingImage> _snappingImages = [];

  /// The URLs of images that have arrived but are waiting for a Thanos snap
  /// to complete before they fade in.
  final Set<String> _pendingImageUrls = {};

  /// A value of 0 means the UI is in the list view, with floating bubbles.
  /// Any value between 0 and 1 means the UI is transitioning, and a value of 1
  /// means the UI is in the detail view.
  double _selectedLatteImageAnimationProgress = 0;

  /// The image that is currently being showcased in the detail view, or is
  /// in the process of animating in or out.
  RecentLatteImage? _heroImage;

  /// Controls the transition animation between the grid and detail views.
  late AnimationController _selectedLatteImageController;

  /// The number of indices each image has shifted by through the
  /// [_startingLattePositions] list. This allows images to rotate through
  /// stable positions while looking like they are constantly arriving.
  int _imageIndexShift = 0;

  static const double _halfPi = pi / 2;

  @override
  void initState() {
    super.initState();
    _lattePositions = List<LattePosition>.from(_startingLattePositions);
    _selectedLatteImageController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 600),
        )..addListener(() {
          setState(() {
            _selectedLatteImageAnimationProgress =
                _selectedLatteImageController.value;

            if (_selectedLatteImageAnimationProgress == 0 &&
                widget.activeImage == null) {
              _heroImage = null;
            }
          });
        });

    _startTimer();
  }

  void _startTimer() {
    _stopTimer();

    /// 60 fps
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _updateLattePositions();
    });
  }

  void _stopTimer() => _timer?.cancel();

  @override
  void didUpdateWidget(covariant _LatteImagesInner oldWidget) {
    super.didUpdateWidget(oldWidget);

    final didListGrow = widget.images.length != oldWidget.images.length;
    final didListShift =
        widget.images.firstOrNull?.imageUrl !=
        oldWidget.images.firstOrNull?.imageUrl;

    if (didListGrow || didListShift) {
      // Logic for handling "new image arrival":
      // 1. Identify which "slot" in the physics engine will receive the new
      //    image.
      // 2. Take a snapshot of the image currently in that slot.
      // 3. Move that image into the "snapping images" list to play its exit
      //    animation.
      // 4. Update the _imageIndexShift so the new image correctly maps to that
      //    slot.

      final oldShift = _imageIndexShift;
      final newShift = (oldShift + 1) % _startingLattePositions.length;

      // The physical slot mapped to index 0 (newest image) after the shift.
      final pIndex =
          (_startingLattePositions.length - newShift) %
          _startingLattePositions.length;

      final newImageUrl = widget.images[0].imageUrl;
      final isAddition = widget.images.length > oldWidget.images.length;

      // Find the image index that previously occupied this physical slot.
      final oldIndex = (pIndex + oldShift) % _startingLattePositions.length;

      if (!isAddition &&
          oldIndex < oldWidget.images.length &&
          oldWidget.images[oldIndex].imageUrl != newImageUrl) {
        final removedImage = oldWidget.images[oldIndex];
        final layoutSize = Size(
          widget.layoutInfo.width,
          widget.layoutInfo.height,
        );

        // Capture the position and velocity of the image exactly at the moment
        // it is swapped out to ensure the ghost continues its momentum.
        final absPos = _lattePositions[pIndex].toAbsolute(layoutSize);

        final velocity = Offset(
          cos(absPos.direction) * absPos.speed,
          sin(absPos.direction) * absPos.speed,
        );

        // Track this image as "pending" so it stays invisible until the snap
        // finishes.
        _pendingImageUrls.add(newImageUrl);

        _snappingImages.add(
          _SnappingImage(
            image: removedImage,
            position: absPos,
            associatedNewImageUrl: newImageUrl,
            velocity: velocity,
            startTime: DateTime.now(),
          ),
        );
      }

      _calculateImageIndexShift();
    }

    // Handle transitions between the interactive bubble grid and the focused
    // detail view.
    if (widget.activeImage != oldWidget.activeImage) {
      if (widget.activeImage == null) {
        _animateToListView();
      } else {
        // Prepare image for hero transition.
        _heroImage = widget.activeImage;

        // Pause physics for better performance/focus in detail view.
        _stopTimer();
        _animateToDetailView();
      }
    }
  }

  /// The list has changed, which requires us to sort out where the newest
  /// image is in the list.
  void _calculateImageIndexShift() {
    _imageIndexShift++;
    if (_imageIndexShift >= _startingLattePositions.length) {
      _imageIndexShift = 0;
    }
  }

  /// The main physics loop: handles movement, repulsion from other lattes,
  /// and wall bouncing.
  void _updateLattePositions() {
    if (widget.layoutInfo.width <= 0 || widget.layoutInfo.height <= 0) return;

    // No need to animate anything while we're in detail mode.
    if (_selectedLatteImageAnimationProgress == 1) return;

    final layoutSize = Size(widget.layoutInfo.width, widget.layoutInfo.height);
    final updatedPositions = _lattePositions.indexed.map((indexAndPos) {
      final i = indexAndPos.$1;
      final pos = indexAndPos.$2;

      final index = (i + _imageIndexShift) % _startingLattePositions.length;
      if (index >= widget.images.length) {
        return pos.toAbsolute(layoutSize);
      }

      double targetRadius = pos.radius;
      final imageUrl = widget.images[index].imageUrl;
      if (_pendingImageUrls.contains(imageUrl)) {
        // If the image at this position is still pending its appearance,
        // we force it to target its current radius, thus avoiding
        // any expansion until it is ready to be shown.
        targetRadius = pos.radius;
      } else {
        targetRadius = _startingLattePositions[index].radius;
      }

      final newRadius = pos.radius + (targetRadius - pos.radius) * 0.1;

      return pos.copyWith(radius: newRadius).toAbsolute(layoutSize);
    }).toList();

    // Step 2: Wall Bouncing and Movement
    _lattePositions = updatedPositions.indexed.map((indexAndAbs) {
      final i = indexAndAbs.$1;
      final absPosition = indexAndAbs.$2;

      final index = (i + _imageIndexShift) % _startingLattePositions.length;
      if (index >= widget.images.length) {
        return absPosition.toRelative(layoutSize);
      }

      double direction = absPosition.direction;
      double? squishAngle = absPosition.squishAngle;
      double speed = absPosition.speed;

      bool horizontalBounce = false;

      // -------- HORIZONTAL BOUNCE (LEFT / RIGHT WALLS) --------
      if ((absPosition.center.dx - absPosition.radius <= 0 &&
              cos(direction) < 0) ||
          (absPosition.center.dx + absPosition.radius >= layoutSize.width &&
              cos(direction) > 0)) {
        direction = pi - direction;
        horizontalBounce = true;
      }

      bool verticalBounce = false;

      // -------- VERTICAL BOUNCE (TOP / BOTTOM WALLS) --------
      if ((absPosition.center.dy - absPosition.radius <= 0 &&
              sin(direction) < 0) ||
          (absPosition.center.dy + absPosition.radius >= layoutSize.height &&
              sin(direction) > 0)) {
        direction = -direction;
        verticalBounce = true;
      }

      // If we bounced against either wall, configure the new squish angle
      if (horizontalBounce || verticalBounce) {
        squishAngle = horizontalBounce ? pi / 2 : 0;

        // Return speed to absolute representation of default speed.
        final vx =
            LattePosition.defaultSpeed * cos(direction) * layoutSize.width;
        final vy =
            LattePosition.defaultSpeed * sin(direction) * layoutSize.height;
        speed = sqrt(vx * vx + vy * vy);
      }

      final mappedPos = absPosition.copyWith(
        center: absPosition.center.copyWith(
          dx: absPosition.center.dx + cos(direction) * speed,
          dy: absPosition.center.dy + sin(direction) * speed,
        ),
        direction: direction,
        squishAngle: squishAngle,
        speed: speed,
        lastCollidedWith: horizontalBounce || verticalBounce
            ? null
            : absPosition.lastCollidedWith,
        lastCollisionAt: (horizontalBounce || verticalBounce)
            ? DateTime.now()
            : null,
      );

      return mappedPos.toRelative(layoutSize);
    }).toList();

    // Step 3: Inter-bubble collisions
    // We convert all positions to absolute pixel coordinates once for this pass
    final absPositions = _lattePositions
        .map((p) => p.toAbsolute(layoutSize))
        .toList();

    for (int i = 0; i < absPositions.length; i++) {
      final indexI = (i + _imageIndexShift) % 13;
      if (indexI >= widget.images.length) continue;

      for (int j = i + 1; j < absPositions.length; j++) {
        final indexJ = (j + _imageIndexShift) % 13;
        if (indexJ >= widget.images.length) continue;

        final a = absPositions[i];
        final b = absPositions[j];

        // Ensure these two objects didn't just bounce off each other
        if (a.lastCollidedWith == b.id && b.lastCollidedWith == a.id) {
          continue;
        }

        final dx = b.center.dx - a.center.dx;
        final dy = b.center.dy - a.center.dy;

        // Use length squared to avoid computing square root prematurely
        final lengthSquared = (dx * dx) + (dy * dy);
        final minDistance = a.radius + b.radius;
        final minDistanceSquared = minDistance * minDistance;

        if (lengthSquared < minDistanceSquared) {
          // Calculate the pixel overlap
          final distance = sqrt(lengthSquared);
          final safeDistance = distance == 0 ? 0.0001 : distance;
          final overlap = minDistance - safeDistance;

          final nx = dx / safeDistance;
          final ny = dy / safeDistance;

          // Convert pixel separation back to percentages
          final moveX = nx * overlap / 2.0;
          final moveY = ny * overlap / 2.0;

          // Create translated copies for positional correction
          final correctedA = a.copyWith(
            center: a.center.translate(-moveX, -moveY),
          );
          final correctedB = b.copyWith(
            center: b.center.translate(moveX, moveY),
          );

          // Phase 2: Elastic resolution
          final vAx = a.speed * cos(a.direction);
          final vAy = a.speed * sin(a.direction);
          final vBx = b.speed * cos(b.direction);
          final vBy = b.speed * sin(b.direction);

          final dotProduct = ((vAx - vBx) * dx) + ((vAy - vBy) * dy);

          if (dotProduct > 0) {
            final collision = Collision(correctedA, correctedB);
            final result = collision.resolve();

            // Store the resolved state back into the absolute list
            absPositions[i] = correctedA.copyWith(
              direction: result.latte1Direction,
              squishAngle: result.latte1Squish.direction + _halfPi,
              speed: result.latte1Speed,
              lastCollisionAt: DateTime.now(),
              lastCollidedWith: b.id,
            );
            absPositions[j] = correctedB.copyWith(
              direction: result.latte2Direction,
              squishAngle: result.latte2Squish.direction + _halfPi,
              speed: result.latte2Speed,
              lastCollisionAt: DateTime.now(),
              lastCollidedWith: a.id,
            );
          } else {
            // Only update positions if we didn't resolve a new velocity
            absPositions[i] = correctedA;
            absPositions[j] = correctedB;
          }
        }
      }
    }

    // Convert back to relative coordinates for the next frame
    _lattePositions = absPositions
        .map((abs) => abs.toRelative(layoutSize))
        .toList();

    setState(() {});
  }

  void _toggleActiveImage(RecentLatteImage? image) {
    if (widget.activeImage == null) {
      assert(image != null, 'Cannot set an active image when none is selected');
      widget.setActiveImage(image!);
    } else {
      widget.clearActiveImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const SizedBox.shrink();
    }
    final heroImageUrl = _heroImage?.imageUrl;
    AbsoluteLattePosition? heroGridPos;

    final heightScale = widget.layoutInfo.height / 800;

    final showOnListViewOpacity = _selectedLatteImageAnimationProgress;

    // The layout for recent orders uses a 3-layer rendering strategy to handle
    // live physics, list changes, and hero transitions simultaneously.
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        // Layer 0: Background circles. Decorative elements that fade based on
        // whether the detail view (activeImage) is visible.
        ..._filledCircleData.map(
          (circle) => circle.toWidget(
            widget.layoutInfo,
            isDetail: widget.activeImage != null,
          ),
        ),

        // Layer 1: Stable floating bubbles.
        // These represent the images in the actual grid as managed by the
        // physics engine. We map physical slots (0-12) to these bubbles.
        ..._lattePositions.indexed.expand<Widget>(
          (indexAndPosition) sync* {
            final position = indexAndPosition.$2;
            final slotIndex = indexAndPosition.$1;

            final index =
                (slotIndex + _imageIndexShift) % _startingLattePositions.length;

            if (index >= widget.images.length) {
              yield const SizedBox.shrink();
              return;
            }

            final image = widget.images[index];
            final isHero = image.imageUrl == heroImageUrl;

            final absPos = position.toAbsolute(
              Size(widget.layoutInfo.width, widget.layoutInfo.height),
            );

            if (isHero) {
              heroGridPos = absPos;
            }

            // To keep coordinate systems consistent between the grid and the
            // hero transition, we use a "3R" rule: each image container is
            // exactly 3x the radius of the image, centered on the image's
            // coordinate.
            final boxSize = absPos.radius * 3;

            final isPending = _pendingImageUrls.contains(image.imageUrl);

            final hideOnHeroOpacity = isHero
                ? 0.0
                : (1.0 - _selectedLatteImageAnimationProgress);
            yield Positioned(
              left: absPos.center.dx - boxSize / 2,
              top: absPos.center.dy - boxSize / 2,
              height: boxSize,
              width: boxSize,
              key: ValueKey('position-${position.id}'),
              child: Opacity(
                // Fade out non-hero images during detail transition.
                opacity: hideOnHeroOpacity,
                child: AnimatedOpacity(
                  // Fade in new images when they arrive.
                  opacity: isPending ? 0.0 : 1.0,
                  duration: isPending
                      ? Duration.zero
                      : const Duration(milliseconds: 500),
                  child: IgnorePointer(
                    ignoring: widget.activeImage != null,
                    child: SquishableLatteImage(
                      image: image,
                      lattePosition: isHero
                          ? absPos.copyWith(squishAngle: null)
                          : absPos,
                    ),
                  ),
                ),
              ),
            );

            if (widget.activeImage == null) {
              // Now add a hit box for the latte image, which is different from
              // its own rendering bounding box, which has to have extra padding
              // to accommodate the wobble animation. However, that extra
              // padding can cause close-proximity images to overlap one another
              yield Positioned(
                left: absPos.center.dx - boxSize / 2 + absPos.radius / 2,
                top: absPos.center.dy - boxSize / 2 + absPos.radius / 2,

                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _toggleActiveImage(image),
                  child: SizedBox.fromSize(
                    size: Size.square(absPos.radius * 2),
                  ),
                ),
              );
            }
          },
        ),

        // Layer 2: "Ghosts" of lattes that have just been replaced.
        // When a new image arrives, it displaces an old one. This layer
        // captures the displaced image and applies a "Thanos snap" effect while
        // preserving its momentum from the physics loop.
        ..._snappingImages.map((snapping) {
          final padding = snapping.position.radius * 2;
          final elapsedTime = DateTime.now().difference(snapping.startTime);
          final displacement =
              snapping.velocity * (elapsedTime.inMicroseconds / 16666.0);
          final center = snapping.position.center + displacement;

          return Positioned(
            key: ValueKey('snap-${snapping.associatedNewImageUrl}'),
            left: center.dx - snapping.position.radius - padding,
            top: center.dy - snapping.position.radius - padding,
            height: snapping.position.radius * 2 + padding * 2,
            width: snapping.position.radius * 2 + padding * 2,
            child: Center(
              child: ThanosSnappable(
                onComplete: () {
                  if (mounted) {
                    setState(() {
                      _snappingImages.remove(snapping);
                      _pendingImageUrls.remove(
                        snapping.associatedNewImageUrl,
                      );
                    });
                  }
                },
                child: SquishableLatteImage(
                  image: snapping.image,
                  lattePosition: snapping.position.copyWith(
                    center: center,
                  ),
                ),
              ),
            ),
          );
        }),

        // Layer 3: The hero image animating to the front and center.
        // This is a single image that "breaks out" of Layer 1 to become the
        // central focus of the detail view. It tracks its original grid
        // position (captured in Layer 1 as 'heroGridPos') to ensure seamless
        // takeoff and landing.
        if (_heroImage != null && heroGridPos != null) ...[
          Positioned(
            left: widget.layoutInfo.width * 0.1,
            width: widget.layoutInfo.width * 0.8,
            top:
                widget.layoutInfo.height * 0.17 +
                // Add some more top padding for square aspect ratios because
                // that keeps the footer from crowding the image explainer text
                // too much.
                (widget.layoutInfo.aspectRatio > 1.2 &&
                        widget.layoutInfo.aspectRatio < 1.4
                    ? widget.layoutInfo.height * 0.03
                    : 0),
            bottom: 0,
            child: Opacity(
              opacity: showOnListViewOpacity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: widget.layoutInfo.aspectRatio < 1.4
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: <Widget>[
                  Text('${_heroImage!.name}:').h1,
                  const Text('My happy place is').h2_,
                  SizedBox(height: 16 * heightScale),
                  Text('“${_heroImage!.happyPlace}”').h3,
                  SizedBox(height: 8 * heightScale),
                  SizedBox(
                    width:
                        widget.layoutInfo.width *
                        (widget.layoutInfo.aspectRatio < 1.4 ? 0.6 : 0.4),
                    child: Row(
                      children: [
                        const Text(
                          'Prompt: ',
                          style: TextStyle(fontWeight: .bold),
                        ),
                        SizedBox(width: 8 * heightScale),
                        Flexible(
                          flex: 3,
                          child: OverflowMarquee(text: _heroImage!.prompt),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _HeroLatte(
            image: _heroImage!,
            gridPosition: heroGridPos!,
            layoutInfo: widget.layoutInfo,
            progress: _selectedLatteImageAnimationProgress,
            onTap: widget.clearActiveImage,
          ),
        ],
      ],
    );
  }

  void _animateToListView() {
    _selectedLatteImageController
        .animateTo(0, curve: Curves.easeInOutExpo)
        .then((_) {
          if (mounted && widget.activeImage == null) {
            _startTimer();
          }
        })
        .ignore();
  }

  void _animateToDetailView() {
    _selectedLatteImageController
        .animateTo(1, curve: Curves.easeInOutExpo)
        .ignore();
  }

  @override
  Future<void> dispose() async {
    _timer?.cancel();
    super.dispose();
  }
}

class _FilledCircleData {
  const _FilledCircleData({
    required this.color,
    required this.radius,
    required this.position,
    this.showOnDetailView = true,
  });

  final Color color;
  final double radius;
  final Offset position;

  /// Set to false if this appears behind or even too close to lettering
  final bool showOnDetailView;

  /// Arbitrary constant used to scale the background circles to the screen
  /// size.
  static const double _baseSize = 500;

  Widget toWidget(LayoutInformation layoutInfo, {required bool isDetail}) {
    final scale = layoutInfo.constrainingDimension / _baseSize;
    return _FilledCircle(
      color: color,
      radius: radius * scale,
      position: Offset(
        position.dx * layoutInfo.width,
        position.dy * layoutInfo.height,
      ),
      opacity: showOnDetailView || !isDetail ? 1.0 : 0.0,
    );
  }
}

class _FilledCircle extends StatelessWidget {
  const _FilledCircle({
    required this.color,
    required this.radius,
    required this.position,
    required this.opacity,
  });

  final Color color;
  final double radius;
  final Offset position;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      width: radius * 2,
      height: radius * 2,
      key: ValueKey('$position-$radius-$color'),
      child: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(milliseconds: 600),
        child: CustomPaint(
          painter: _FilledCirclePainter(color: color),
        ),
      ),
    );
  }
}

class _FilledCirclePainter extends CustomPainter {
  _FilledCirclePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

const _filledCircleData = [
  _FilledCircleData(
    color: AppColors.googleIntroRed,
    radius: 10,
    position: Offset(0.1, 0.1),
  ),
  _FilledCircleData(
    color: AppColors.googleIntroGreen,
    radius: 5,
    position: Offset(0.9, 0.1),
  ),
  _FilledCircleData(
    color: AppColors.googleIntroBlue,
    radius: 8,
    position: Offset(0.4, 0.7),
  ),
  _FilledCircleData(
    color: AppColors.googleIntroBlue,
    radius: 12,
    position: Offset(0.7, 0.35),
  ),
  _FilledCircleData(
    color: AppColors.googleIntroRed,
    radius: 15,
    position: Offset(0.2, 0.65),
    showOnDetailView: false,
  ),
  _FilledCircleData(
    color: AppColors.latteArtGold,
    radius: 12,
    position: Offset(0.8, 0.75),
  ),
  _FilledCircleData(
    color: AppColors.latteArtGold,
    radius: 6,
    position: Offset(0.2, 0.21),
    showOnDetailView: false,
  ),
  _FilledCircleData(
    color: AppColors.googleIntroRed,
    radius: 9,
    position: Offset(0.75, 0.22),
  ),
  _FilledCircleData(
    color: AppColors.latteArtGold,
    radius: 11,
    position: Offset(0.5, 0.5),
  ),
  _FilledCircleData(
    color: AppColors.googleIntroBlue,
    radius: 7,
    position: Offset(0.3, 0.45),
    showOnDetailView: false,
  ),
  _FilledCircleData(
    color: AppColors.googleIntroRed,
    radius: 13,
    position: Offset(0.7, 0.8),
  ),
  _FilledCircleData(
    color: AppColors.latteArtGold,
    radius: 13,
    position: Offset(0.15, 0.8),
  ),
  _FilledCircleData(
    color: AppColors.googleIntroGreen,
    radius: 8,
    position: Offset(0.2, 0.3),
    showOnDetailView: false,
  ),
  _FilledCircleData(
    color: AppColors.googleIntroGreen,
    radius: 8,
    position: Offset(0.45, 0.85),
  ),
];

/// The predefined "home" positions for floating latte images.
/// These use relative percentages (0.0 to 1.0) to ensure the design remains
/// responsive regardless of screen size.
const _startingLattePositions = <LattePosition>[
  LattePosition(
    id: '1',
    center: Offset(0.5, 0.5),
    radius: 0.120,
    direction: 0.5,
    squishAngle: null,
  ),
  LattePosition(
    id: '2',
    center: Offset(0.2, 0.3),
    radius: 0.110,
    direction: 1.2,
    squishAngle: null,
  ),
  LattePosition(
    id: '3',
    center: Offset(0.8, 0.1),
    radius: 0.102,
    direction: 2.1,
    squishAngle: null,
  ),
  LattePosition(
    id: '4',
    center: Offset(0.7, 0.7),
    radius: 0.093,
    direction: 3.5,
    squishAngle: null,
  ),
  LattePosition(
    id: '5',
    center: Offset(0.3, 0.8),
    radius: 0.086,
    direction: 4.8,
    squishAngle: null,
  ),
  LattePosition(
    id: '6',
    center: Offset(0.1, 0.6),
    radius: 0.079,
    direction: 5.9,
    squishAngle: null,
  ),
  LattePosition(
    id: '7',
    center: Offset(0.9, 0.5),
    radius: 0.073,
    direction: 0.2,
    squishAngle: null,
  ),
  LattePosition(
    id: '8',
    center: Offset(0.4, 0.2),
    radius: 0.067,
    direction: 1.7,
    squishAngle: null,
  ),
  LattePosition(
    id: '9',
    center: Offset(0.6, 0.9),
    radius: 0.062,
    direction: 2.9,
    squishAngle: null,
  ),
  LattePosition(
    id: '10',
    center: Offset(0.8, 0.8),
    radius: 0.057,
    direction: 4.1,
    squishAngle: null,
  ),
  LattePosition(
    id: '11',
    center: Offset(0.2, 0.9),
    radius: 0.052,
    direction: 5.3,
    squishAngle: null,
  ),
  LattePosition(
    id: '12',
    center: Offset(0.9, 0.9),
    radius: 0.048,
    direction: 6.1,
    squishAngle: null,
  ),
  LattePosition(
    id: '13',
    center: Offset(0.4, 0.5),
    radius: 0.044,
    direction: 3.14,
    squishAngle: null,
  ),
];

/// Internal record used to manage the state of an image currently undergoing
/// the "Thanos snap" disintegration animation.
class _SnappingImage {
  _SnappingImage({
    required this.image,
    required this.position,
    required this.associatedNewImageUrl,
    required this.velocity,
    required this.startTime,
  });

  final RecentLatteImage image;
  final AbsoluteLattePosition position;
  final String associatedNewImageUrl;
  final Offset velocity;
  final DateTime startTime;
}

class _HeroLatte extends StatelessWidget {
  const _HeroLatte({
    required this.image,
    required this.gridPosition,
    required this.layoutInfo,
    required this.progress,
    required this.onTap,
  });

  final RecentLatteImage image;
  final AbsoluteLattePosition gridPosition;
  final LayoutInformation layoutInfo;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // The target center for the detail view.
    // We adjust the focus point slightly based on aspect ratio to avoid
    // crowding the footer text in landscape or tablet views.
    final center = layoutInfo.aspectRatio < 1.4
        ? Offset(layoutInfo.width / 2, layoutInfo.height * 0.67)
        : Offset(layoutInfo.width * 0.75, layoutInfo.height * 0.6);

    // The target size for the detail view.
    // We want the image to be substantial but not overwhelming.
    final targetRadius = layoutInfo.aspectRatio < 1.4
        ? layoutInfo.height * 0.14
        : layoutInfo.width * 0.10;

    // Coordinate Interpolation (The "Hero" part):
    // We calculate a current position and radius that is a mix of the image's
    // 'home' position in the grid and its 'focus' position in the detail view.
    final currentCenter = Offset.lerp(gridPosition.center, center, progress)!;
    final currentRadius = lerpDouble(
      gridPosition.radius,
      targetRadius,
      progress,
    )!;

    // Transitioning Layout Math:
    // To prevent the image from "snapping" or "jumping" when it takes off
    // from the grid, it's vital that the Positioned box math matches exactly
    // across all layers. We use the '3R' rule established in Layer 1.
    final boxSize = currentRadius * 3;

    return Positioned(
      top: currentCenter.dy - boxSize / 2,
      left: currentCenter.dx - boxSize / 2,
      width: boxSize,
      height: boxSize,
      child: SquishableLatteImage(
        image: image,
        lattePosition: gridPosition.copyWith(
          center: currentCenter,
          radius: currentRadius,
        ),
        paddingPercentage: 1 - progress,
      ),
    );
  }
}
