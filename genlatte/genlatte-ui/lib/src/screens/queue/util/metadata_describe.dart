// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte_data/models.dart';

extension MetadataDescribe on LatteOrderMetadata {
  String describe() {
    final buf = StringBuffer('<')..write(id);
    if (completionTime != null) {
      buf.write('-completed');
    }
    buf.write('>');
    return buf.toString();
  }
}
