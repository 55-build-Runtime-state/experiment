// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:genlatte/src/screens/app/theme.dart';
import 'package:genlatte/src/widgets/loading_dash.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A widget that only shows itself when [stillWaiting] is true,
/// and fades out otherwise (ignoring pointers). It is therefore safe
/// to have this widget in a [Stack] above other widgets.
///
/// The widget shows an animation ([LoadingDash]) and a progress bar
/// below it. It is designed to take the user's mind away from the fact
/// they are waiting.
///
/// Note that the progress bar is a lie. We _don't_ actually know how far
/// in the process we are at any point. All we know is the [expectedDuration]
/// and [worstCaseDuration].
class LoadingProgress extends StatefulWidget {
  /// Creates a new [LoadingProgress].
  const LoadingProgress({
    required this.progressStartTime,
    required this.padding,
    required this.stillWaiting,
    this.expectedDuration = const Duration(seconds: 30),
    this.worstCaseDuration = const Duration(minutes: 1, seconds: 20),
    this.primaryColor = AppColors.chevronYellow,
    this.secondaryColor = AppColors.latteArtGold,
    super.key,
  }) : assert(
         worstCaseDuration > expectedDuration,
         'Worst case duration must be longer than expected duration',
       );

  /// The expected duration of the loading process.
  ///
  /// Choose a duration at the top of the expected range so that the user
  /// is more likely to be pleasantly surprised rather than infuriated.
  /// 90% of the users should see the action completed _sooner_ than
  /// the given duration.
  final Duration expectedDuration;

  /// 99.9% of users should see the action completed before this time.
  /// After that, the progress bar no longer moves.
  ///
  /// This _MUST_ be higher than [expectedDuration].
  final Duration worstCaseDuration;

  /// The time at which this progress bar started.
  ///
  /// This exists in case the widget needs to go in and out of the widget tree
  /// but we don't want to restart the progress each time.
  final DateTime? progressStartTime;

  /// This is `true` if the loading progress should be shown.
  ///
  /// When set to `false`, the widget will immediately stop responding to
  /// pointer events, will start fading away, and after that, will
  /// remove its children from the widget tree.
  final bool stillWaiting;

  /// Padding for the main content of the progress indicator.
  final EdgeInsets padding;

  /// The main color of the progress bar.
  final Color primaryColor;

  /// Accent color (used for the border around the progress bar).
  final Color secondaryColor;

  @override
  State<LoadingProgress> createState() => _LoadingProgressState();
}

class _LoadingProgressState extends State<LoadingProgress>
    with SingleTickerProviderStateMixin<LoadingProgress> {
  late final AnimationController opacityController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 1000),
  );

  late DateTime startTime;

  DateTime _latestTime = DateTime.now();

  double _progress = 0;

  Timer? _timer;

  /// A 'designed' curve that transforms the real (linear) progress to
  /// a non-linear curve that 'vibes' better with the human psyche.
  /// See [_recomputeProgressTween].
  late TweenSequence<double> progressTween;

  /// This becomes `true` only when [LoadingProgress.stillWaiting] is `true`
  /// and the [opacityController]'s value is non-zero (it is not dismissed).
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final progress = widget.stillWaiting
        ? progressTween.transform(_progress.clamp(0, 1))
        : 1.0;

    final screenWidth = MediaQuery.widthOf(context);
    final tickerScaler = TextScaler.linear(min(1, screenWidth / 600));

    return Visibility(
      // Avoid paying the price for showing the widget subtree below
      // (incl. the Dash movie).
      visible: _visible,
      child: IgnorePointer(
        // As soon as we start fading out, ignore pointer.
        ignoring: widget.stillWaiting,
        child: Padding(
          padding: widget.padding,
          child: FadeTransition(
            opacity: opacityController,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                const Expanded(child: LoadingDash()),
                const SizedBox(height: 40),
                Stack(
                  children: [
                    _ProgressBar(
                      progress: progress,
                      primaryColor: widget.primaryColor,
                      secondaryColor: widget.secondaryColor,
                    ),
                    Positioned.fill(
                      child: Center(
                        child: WrappedText(
                          style: (context, theme) =>
                              theme.typography.p.copyWith(
                                // Make the ticker text blend as a difference
                                // of the background.
                                foreground: Paint()
                                  ..color = const Color(0xFFFFFFFF)
                                  ..blendMode = BlendMode.difference,
                                fontSize: tickerScaler.scale(
                                  theme.typography.p.fontSize!,
                                ),
                              ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: _Ticker(
                              sinceStart: _latestTime.difference(startTime),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant LoadingProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progressStartTime != null &&
        widget.progressStartTime != oldWidget.progressStartTime) {
      startTime = widget.progressStartTime!;
    }

    if (widget.stillWaiting && !oldWidget.stillWaiting) {
      _start();
      unawaited(opacityController.forward());
      _visible = true;
    } else if (!widget.stillWaiting && oldWidget.stillWaiting) {
      _stop();
      unawaited(opacityController.reverse());
    }

    _recomputeProgressTween();
  }

  @override
  void dispose() {
    _timer?.cancel();
    opacityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTime = widget.progressStartTime ?? DateTime.now();
    _recomputeProgressTween();

    opacityController.addStatusListener(_onAnimationStatusChange);

    if (widget.stillWaiting) {
      _start();
      unawaited(opacityController.forward());
      _visible = true;
    }
  }

  void _onAnimationStatusChange(AnimationStatus status) {
    if (status == .dismissed && !widget.stillWaiting) {
      _visible = false;
    }
  }

  void _recomputeProgressTween() {
    progressTween = TweenSequence<double>([
      // Start subtly faster.
      TweenSequenceItem(
        tween: Tween(begin: 0.01, end: 0.15),
        weight: 0.10 * widget.expectedDuration.inMilliseconds,
      ),
      // Most of the progression is mostly gradual.
      TweenSequenceItem(
        tween: Tween(begin: 0.15, end: 0.90),
        weight: 0.90 * widget.expectedDuration.inMilliseconds,
      ),
      // Slow down at the very end. Hopefully, most users don't see this.
      TweenSequenceItem(
        tween: Tween(begin: 0.90, end: 0.98),
        weight:
            0.5 *
            (widget.worstCaseDuration - widget.expectedDuration).inMilliseconds,
      ),
      // The very last leg where almost no progress is achieved.
      TweenSequenceItem(
        tween: Tween(begin: 0.98, end: 0.995),
        weight:
            0.5 *
            (widget.worstCaseDuration - widget.expectedDuration).inMilliseconds,
      ),
    ]);
  }

  void _start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 500), _tick);
    _tick(null);
  }

  void _stop() {
    _timer?.cancel();
  }

  void _tick(Object? _) {
    if (!mounted) return;
    _latestTime = DateTime.now();
    final elapsed = _latestTime.difference(startTime);
    setState(() {
      _progress =
          elapsed.inMilliseconds / widget.worstCaseDuration.inMilliseconds;
    });
  }
}

class _ProgressBar extends StatefulWidget {
  const _ProgressBar({
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
  });

  final double progress;

  final Color primaryColor;

  final Color secondaryColor;

  @override
  State<_ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<_ProgressBar>
    with SingleTickerProviderStateMixin<_ProgressBar> {
  late final animationController = AnimationController(
    vsync: this,
  );

  final Duration stepDuration = const Duration(milliseconds: 300);

  final Curve stepCurve = Curves.easeOut;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: widget.primaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: animationController.value,
              child: child,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: widget.secondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant _ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    unawaited(
      animationController.animateTo(
        widget.progress.clamp(0, 1),
        duration: stepDuration,
        curve: stepCurve,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    unawaited(
      animationController.animateTo(
        widget.progress.clamp(0, 1),
        duration: stepDuration,
        curve: stepCurve,
      ),
    );
  }
}

class _Ticker extends StatelessWidget {
  const _Ticker({
    required this.sinceStart,
    // ignore: unused_element_parameter
    this.messages = _defaultMessages,
    this.switchDuration = const Duration(seconds: 3),
  }) : assert(
         switchDuration > Duration.zero,
         'Switch duration must be non-zero',
       );

  static const List<String> _defaultMessages = [
    'Generating four images in parallel',
    'Expanding prompts via Gemini Flash',
    'Tokenizing input prompts',
    'Calculating Gemini multimodal embeddings',
    'Encoding text prompts into latent space',
    'Peeling initial nanobananas',
    'Sampling from Gaussian noise distribution',
    'Injecting prompt embeddings into the diffusion process',
    'Calibrating nanobanana attention heads',
    'Aligning embeddings with visual features',
    'Executing reverse diffusion steps',
    'Decoding latents into pixel space',
    'Refining high-frequency details',
    'Scaling resolution via variational autoencoder',
    'Embedding SynthID provenance metadata',
    'Converging on final pixel arrangements',
    // At this point, most users are away. The following is to give some
    // entertainment to the poor souls who need to wait longer.
    'Hallucinating 100% progress',
    'Reticulating splines',
    'Constructing additional pylons',
    'Rerouting power from the holodeck',
    'Trying to exit vim',
    'Reversing the polarity of the neutron flow',
    'Gathering your party before venturing forth',
    'Compensating for Heisenberg compensators',
    "Saying: \"I'm sorry, Dave. I'm afraid I can't do that.\"",
    'Downloading more RAM',
    'Establishing a secure connection to Skynet',
    'Dividing by zero (as a treat)',
    'Warming up the flux capacitor',
    'Bypassing the Kobayashi Maru scenario',
    'Executing `sudo rm -rf /`',
    'Calculating the answer to life, the universe, and everything',
    'Resolving circular dependencies',
    'Blowing into the cartridge',
    'Commenting out broken unit tests',
    'Scanning for Cylon raiders',
    'Defragmenting the mainframe',
    'Punching widget trees',
    'Equipping +5 GPU of Rendering',
    'Ensuring the flow of spice',
    'Ignoring the warning signs in the logs',
    'Calculating PageRank',
    'Requisitioning a bigger boat',
    'Executing order 66',
    'Turning the TPUs up to eleven',
    'Going ahead and making my day',
    'Turning it off and on again',
    '',
    'Ah shucks, here we go again...',
  ];

  final Duration sinceStart;

  final Duration switchDuration;

  final List<String> messages;

  @override
  Widget build(BuildContext context) {
    final index =
        (sinceStart.inMilliseconds ~/ switchDuration.inMilliseconds) %
        messages.length;
    final message = messages[index];

    return ClipRect(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchOutCurve: Curves.ease,
        switchInCurve: Curves.ease,
        // The default FadeTransition doesn't work well with
        // BlendMode.difference so we're sliding the text up and down.
        // The ClipRect above makes sure the text disappears from view.
        transitionBuilder: (child, animation) => SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
        child: Text(
          message,
          // Key must be provided for AnimatedSwitcher to work.
          key: ValueKey(message),
          maxLines: 1,
          overflow: .ellipsis,
        ),
      ),
    );
  }
}
