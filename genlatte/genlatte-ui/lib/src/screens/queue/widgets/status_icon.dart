// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:genlatte/src/screens/app/app.dart';

enum IconStatus { notYet, active, done }

enum OrderStatus { visible, atBarista, recentlyCompleted, completed }

class StatusIcon extends StatefulWidget {
  const StatusIcon({
    required this.status,
    required this.icon,
    required this.size,
    super.key,
  });

  static const iconFill = 1.0;

  static const iconWeight = 400.0;

  static const iconOpticalSize = 24.0;

  static const iconGrade = 0.0;

  static const notYetColor = AppColors.placeholderGrey;

  static const activeColor = AppColors.googleIntroBlue;

  static const doneColor = AppColors.black;

  final IconStatus status;
  final IconData icon;
  final double size;

  @override
  State<StatusIcon> createState() => _StatusIconState();
}

class _StatusIconState extends State<StatusIcon>
    with SingleTickerProviderStateMixin {
  static ui.Image? _textureImage;

  static Future<void>? _loadFuture;

  @override
  Widget build(BuildContext context) {
    final color = switch (widget.status) {
      IconStatus.notYet => StatusIcon.notYetColor,
      IconStatus.active => StatusIcon.activeColor,
      IconStatus.done => StatusIcon.doneColor,
    };

    final isTexturedActive =
        widget.status == IconStatus.active && _textureImage != null;

    final baseIcon = Icon(
      widget.icon,
      size: widget.size,
      fill: StatusIcon.iconFill,
      weight: StatusIcon.iconWeight,
      grade: StatusIcon.iconGrade,
      opticalSize: StatusIcon.iconOpticalSize,
      color: isTexturedActive ? const Color(0xFFFFFFFF) : color,
    );

    if (!isTexturedActive) {
      return baseIcon;
    }

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        final texture = _textureImage!;

        final imageCenterX = texture.width / 2;
        final imageCenterY = texture.height / 2;
        final boundsDiagonal = sqrt(
          bounds.width * bounds.width + bounds.height * bounds.height,
        );
        final scaleFactor = boundsDiagonal / min(texture.width, texture.height);

        final matrix = Matrix4.identity()
          ..translateByDouble(bounds.center.dx, bounds.center.dy, 0, 1)
          //..rotateZ(-animationValue * 2 * pi)
          ..scaleByDouble(scaleFactor, scaleFactor, 1, 1)
          ..translateByDouble(-imageCenterX, -imageCenterY, 0, 1);

        return ImageShader(
          texture,
          TileMode.decal,
          TileMode.decal,
          matrix.storage,
        );
      },
      child: baseIcon,
    );
  }

  @override
  void didUpdateWidget(StatusIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status != oldWidget.status) {
      if (widget.status == IconStatus.active) {
        unawaited(_ensureTextureLoaded());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.status == IconStatus.active) {
      unawaited(_ensureTextureLoaded());
    }
  }

  Future<void> _ensureTextureLoaded() async {
    if (_textureImage != null) return;

    _loadFuture ??= () async {
      final data = await rootBundle.load(
        'assets/io-primary-gradient-mesh-small.jpg',
      );
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      _textureImage = frame.image;
    }();

    await _loadFuture;
    setState(() {});
  }
}
