// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart' hide Source;
import 'package:data_layer/data_layer.dart';
import 'package:genlatte/src/sources/firestore_source.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';

/// Repository for [LatteOptions].
class LatteOptionsRepository extends Repository<LatteOptions> {
  /// {@macro LatteOptionsRepository}
  LatteOptionsRepository()
    : super(
        SourceList<LatteOptions>(
          sources: <Source<LatteOptions>>[
            LocalMemorySource<LatteOptions>(
              bindings: LatteOptions.bindings,
            ),
            FirestoreSource<LatteOptions>(
              GetIt.I<FirebaseFirestore>(),
              bindings: LatteOptions.bindings,
            ),
          ],
          bindings: LatteOptions.bindings,
        ),
      );
}
