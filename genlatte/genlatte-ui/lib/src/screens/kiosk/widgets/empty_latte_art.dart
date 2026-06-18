// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Class to hold unique data for each swirling arc per instance
class _ArcConfig {
  _ArcConfig({
    required this.phaseOffset,
    required this.baseRadiusFactor,
    required this.speedFactor,
    required this.opacityFactor,
    required this.maxSweep,
  });

  // Factory constructor for generating a random config for one arc
  factory _ArcConfig.random() {
    final rand = math.Random();
    return _ArcConfig(
      phaseOffset: rand.nextDouble() * math.pi * 2, // Random starting phase
      baseRadiusFactor:
          0.3 + rand.nextDouble() * 0.1, // Slight base radius variation
      speedFactor: 0.8 + rand.nextDouble() * 0.4, // Slight speed variation
      opacityFactor: 0.3 + rand.nextDouble() * 0.1, // Base opacity variation
      maxSweep:
          math.pi / 1.5 + rand.nextDouble() * (math.pi / 2), // Random max sweep
    );
  }

  final double phaseOffset;
  final double baseRadiusFactor;
  final double speedFactor;
  final double opacityFactor;
  final double maxSweep;
}

/// Draws dream-like swirling latte art.
class EmptyLatteArt extends StatefulWidget {
  /// Instantiates an [EmptyLatteArt].
  const EmptyLatteArt({super.key});

  @override
  State<EmptyLatteArt> createState() => _EmptyLatteArtState();
}

class _EmptyLatteArtState extends State<EmptyLatteArt>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;

  // ValueNotifier is a highly efficient way to rebuild only the CustomPaint
  // without rebuilding the entire widget tree on every frame.
  final ValueNotifier<double> _time = ValueNotifier(0);
  late List<_ArcConfig> _arcConfigs;

  static const _swirlSpeed = 12;

  @override
  void initState() {
    super.initState();
    _arcConfigs = List.generate(6, (index) => _ArcConfig.random());

    // Create a ticker that fires every frame.
    // It provides the total elapsed time, which grows infinitely and never
    // resets.
    _ticker = createTicker((Duration elapsed) {
      // Use microseconds for high-precision, perfectly smooth double values
      _time.value = elapsed.inMicroseconds / Duration.microsecondsPerSecond;
    });

    _ticker.start().ignore();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(constraints.maxWidth, constraints.maxHeight);
        return SizedBox(
          width: size,
          height: size,
          child: ValueListenableBuilder<double>(
            valueListenable: _time,
            builder: (context, time, child) {
              return CustomPaint(
                painter: _LattePainter(time / _swirlSpeed, _arcConfigs),
              );
            },
          ),
        );
      },
    );
  }
}

class _LattePainter extends CustomPainter {
  _LattePainter(this.progress, this.arcConfigs);
  final double progress;
  final List<_ArcConfig> arcConfigs;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    // --- LAYER 1: Large, Blurry Outer Circle (Outline) ---
    final outlinePaint = Paint()
      ..color =
          const Color(0xFF4E342E) // Deep espresso brown
      ..style = PaintingStyle.fill
      // Increased blur for very soft outline
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);

    // Draw slightly larger than radius to cover edges
    canvas.drawCircle(center, radius * 1.05, outlinePaint);

    // --- LAYER 2: Solid Inner Circle ---
    final softInnerPaint = Paint()
      ..color =
          const Color(0xFF4E342E) // Same deep brown
      ..style = PaintingStyle.fill
      // ADDED: A moderate blur to melt the hard edge into the outer layer
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    // Draw inner circle. The radius stays the same, but the edge is now soft.
    canvas.drawCircle(center, radius * 0.95, softInnerPaint);

    // --- LAYER 3: Swirling, Morphing Arcs (Inside Solid Circle) ---
    // Setup the "foam" paint (reduce arc blur slightly to make them "less
    // blurred")
    final foamPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      // Maintain some blur for dreamy feel, but less than outer circle blur
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    // Draw multiple swirling, morphing arcs using unique instance data
    for (int i = 0; i < arcConfigs.length; i++) {
      final config = arcConfigs[i];

      // Use unique phase offset & speed for starting angle, incorporating
      // global progress
      final startAngle =
          (progress * math.pi * 4 * config.speedFactor) + config.phaseOffset;

      // Oscillate sweep, based on unique max sweep and progress/phase
      final sweepAngle =
          (config.maxSweep / 1.5) +
          math.sin(progress * math.pi * 2 + config.phaseOffset) *
              (config.maxSweep / 3);

      // Oscillate radius, using unique base radius factor and variation
      double currentRadius =
          radius * config.baseRadiusFactor +
          (i * radius * 0.08) +
          math.cos(progress * math.pi * 4 + config.phaseOffset) * 8.0;

      // Ensure arcs stay contained mostly within solid inner circle
      // (adjust slightly)
      if (currentRadius > radius * 0.93) currentRadius = radius * 0.93;

      // Morphing thickness (less per-instance variation here, but still morphs
      // over time)
      foamPaint.strokeWidth =
          10.0 + 8.0 * math.cos(progress * math.pi * 2 + config.phaseOffset);

      // Morphing opacity (using unique opacity factor and base phase for
      // uniqueness)
      final opacity =
          config.opacityFactor +
          0.4 * math.sin(progress * math.pi * 2 + config.phaseOffset).abs();
      foamPaint.color = const Color(0xFFD7CCC8).withValues(alpha: opacity);

      // Draw the arc
      final rect = Rect.fromCircle(center: center, radius: currentRadius);
      canvas.drawArc(rect, startAngle, sweepAngle, false, foamPaint);
    }

    // --- Central Swirling Blob (Optional, make slightly unique) ---
    // Use data from one arc config to introduce slight per-instance variation
    // in center
    final centralRandFactor = arcConfigs[0].phaseOffset * 0.1;
    final centerFoamPaint = Paint()
      ..color = const Color(0xFFEFEBE9).withValues(
        alpha: 0.4 + 0.2 * math.sin(progress * math.pi * 2 + centralRandFactor),
      )
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        16,
      ); // Maintain blur for center

    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width:
            radius * 0.6 +
            math.cos(progress * math.pi * 2 + centralRandFactor) * 10,
        height:
            radius * 0.4 +
            math.sin(progress * math.pi * 2 + centralRandFactor) * 10,
      ),
      centerFoamPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _LattePainter oldDelegate) {
    // Re-paint when progress changes (animation) or if configs differ (not
    // usually applicable per instance, but safer check)
    return oldDelegate.progress != progress ||
        oldDelegate.arcConfigs != arcConfigs;
  }
}
