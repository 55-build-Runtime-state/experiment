// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:web_browser_detect/web_browser_detect.dart';

/// Displays the loading animation of Dash imagining various Google logos as
/// latte art.
///
/// Renders nothing on Safari web, which does not support transparency in
/// videos.
class LoadingDash extends StatelessWidget {
  /// Instantiates a [LoadingDash].
  const LoadingDash({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      final browser = Browser();
      if (browser.browserAgent == BrowserAgent.safari) {
        return const SizedBox.shrink();
      }
    }
    return const _LoadingDashInner();
  }
}

class _LoadingDashInner extends StatefulWidget {
  const _LoadingDashInner();

  @override
  State<_LoadingDashInner> createState() => _LoadingDashState();
}

class _LoadingDashState extends State<_LoadingDashInner> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Use the asset constructor
    _controller =
        VideoPlayerController.asset(
            kIsWeb
                ? 'assets/videos/Dash_Loading_1080px.webm'
                : 'assets/videos/Dash_Loading_1080px_H.265.mov',
          )
          ..initialize()
              .then((_) {
                if (!mounted) return;
                _controller.setLooping(true).ignore();
                _controller.play().ignore();
                // Ensure the first frame is shown after the video is
                // initialized.
                setState(() {});
              })
              .onError((error, stackTrace) {
                debugPrint('Failed to initialize video player: $error');
              })
              .ignore();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = VideoPlayer(_controller);

    // Android isn't honoring transparency in either webm or h265, but this
    // color filter drops the alpha channel to 0 for black pixels, which is the
    // same for our purposes.
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;

    if (isAndroid) {
      widget = ColorFiltered(
        colorFilter: const ColorFilter.matrix([
          1, 0, 0, 0, 0, //
          0, 1, 0, 0, 0, //
          0, 0, 1, 0, 0, //
          1, 1, 1, 0, -1, //
        ]),
        child: widget,
      );
    }

    return Center(
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: widget,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose().ignore();
    super.dispose();
  }
}
