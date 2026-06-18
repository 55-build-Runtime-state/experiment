// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

///
extension DebuggableWidget on Widget {
  ///
  Widget border({Color? color}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color:
              color ??
              const Color.from(
                alpha: 1,
                red: 1,
                green: 0,
                blue: 0,
              ),
        ),
      ),
      child: this,
    );
  }

  ///
  Widget withBorder({Color? color}) => border(color: color);
}
