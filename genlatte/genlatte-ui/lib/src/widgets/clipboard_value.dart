// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:clipboard/clipboard.dart';
import 'package:logging/logging.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Renders a value which can be copied to the clipboard.
class ClipboardValue extends StatefulWidget {
  /// Instantiates a [ClipboardValue].
  const ClipboardValue(this.value, {required this.label, super.key});

  /// The value to be displayed and copied.
  final String value;

  /// Semantic label.
  final String label;

  @override
  State<ClipboardValue> createState() => _ClipboardValueState();
}

class _ClipboardValueState extends State<ClipboardValue> {
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    child: Row(
      children: <Widget>[
        Flexible(
          child: Semantics(
            label: 'Copy ${widget.label}',
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () async {
                  try {
                    await FlutterClipboard.copy(widget.value);
                    if (!mounted) return;
                    showToast(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context, overlay) {
                        return SurfaceCard(
                          child: Basic(
                            title: Text(
                              'Copied ${widget.label}',
                            ),
                          ),
                        );
                      },
                    );
                  } on Exception catch (e, st) {
                    Logger('ClipboardValue').severe(
                      'Failed to copy ${widget.label}} '
                      '${widget.value} to '
                      'clipboard',
                      e,
                      st,
                    );
                  }
                },
                child: const Icon(Icons.copy),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.value).xSmall.mono,
            ],
          ),
        ),
      ],
    ),
  );
}
