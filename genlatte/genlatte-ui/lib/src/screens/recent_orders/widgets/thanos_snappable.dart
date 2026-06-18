// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:thanos_snap_effect/src/shader_builder.dart';
import 'package:thanos_snap_effect/src/shader_painter.dart';
import 'package:thanos_snap_effect/src/shader_x/thanos_effect_shader.dart';
import 'package:thanos_snap_effect/src/snappable_style.dart';
import 'package:thanos_snap_effect/src/snapshot/snapshot_builder.dart';

/// A widget that can be snapped using the Thanos snap effect.
class ThanosSnappable extends StatefulWidget {
  /// {@macro ThanosSnappable}
  const ThanosSnappable({
    required this.onComplete,
    required this.child,
    super.key,
  });

  /// Widget to be snapped
  final Widget child;

  /// Callback to be called when the snap animation is complete
  final VoidCallback onComplete;

  @override
  State<ThanosSnappable> createState() => _ThanosSnappableState();
}

class _ThanosSnappableState extends State<ThanosSnappable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });

    // The SnapshotBuilder waits for a non-zero animation value to capture the
    // widget.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward().ignore();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We avoid using the Snappable widget from thanos_snap_effect because it
    // uses OverlayPortal to pin the effect in one fixed place. By implementing
    // our own builder here and rendering the shader directly in the tree,
    // the vanishing "ghost" will follow the transform and position of this
    // widget as it continues its momentum across the screen.
    return ShaderBuilder(
      shaderAsset: ThanosSnapEffectShader.path,
      xShaderBuilder: ThanosSnapEffectShader.new,
      builder: (context, shader, child) {
        return SnapshotBuilder(
          animation: _controller,
          onSnapshotReadyListener: (snapshotInfo) {
            shader?.updateSnapshot(snapshotInfo);
            shader?.updateStyleProperties(
              ThanosSnapEffectStyleProps.fromSnappableStyle(
                const SnappableStyle(),
                snapshotInfo,
              ),
            );
          },
          builder: (context, snapshotInfo, child) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Visibility(
                  maintainState: true,
                  maintainSize: true,
                  maintainAnimation: true,
                  // Keep the original image visible for the first ~80ms (0.02)
                  // of the snap. This seamlessly masks the 1-frame WebGL/Wasm
                  // shader compilation hitch that causes a split-second of
                  // 'nothing' before the shader is fully injected into the
                  // render pipeline.
                  visible: _controller.value < 0.02 || snapshotInfo == null,
                  child: child,
                ),
                if (snapshotInfo != null && shader != null)
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      shader.setAnimationValue(_controller.value);
                      return Positioned.fill(
                        child: ShaderPainter(
                          shader: shader.fragmentShader,
                          outerPadding: const EdgeInsets.all(40),
                          animationValue: _controller.value,
                        ),
                      );
                    },
                  ),
              ],
            );
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
