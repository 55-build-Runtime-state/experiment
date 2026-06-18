// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:flutter/material.dart';

/// A widget that displays a countdown timer in a human-readable format.
class HumanizedCountdown extends StatefulWidget {
  /// Instantiates a [HumanizedCountdown].
  const HumanizedCountdown({
    required this.timestamp,
    this.label,
    this.textStyle,
    super.key,
  });

  /// Optional label.
  final String? label;

  /// Start time.
  final DateTime timestamp;

  /// Optional styling.
  final TextStyle? textStyle;

  @override
  State<HumanizedCountdown> createState() => _HumanizedCountdownState();
}

class _HumanizedCountdownState extends State<HumanizedCountdown> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Update the UI every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(DateTime localizedTime) {
    final now = DateTime.now();
    final duration = now.difference(localizedTime);

    // Guard against future dates
    if (duration.isNegative || duration.inSeconds < 1) {
      return 'Just now';
    }

    final int sec = duration.inSeconds % 60;
    final int min = duration.inMinutes % 60;
    final int hour = duration.inHours % 24;
    final int days = duration.inDays;

    if (days > 0) {
      return '${days}d ${hour}h ago';
    } else if (hour > 0) {
      return '${hour}h ${min}m ago';
    } else if (min > 0) {
      return '${min}m ${sec}s ago';
    } else {
      return '${sec}s ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.label != null ? "${widget.label} " : ''}'
      '${_formatDuration(widget.timestamp)}',
      style:
          widget.textStyle ??
          const TextStyle(fontSize: 16, color: Colors.blueGrey),
    );
  }
}
