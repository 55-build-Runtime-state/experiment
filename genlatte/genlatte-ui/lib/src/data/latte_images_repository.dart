// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_layer/data_layer.dart';
import 'package:genlatte/src/sources/firestore_source.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';

/// Repository for managing [LatteImageBatch]s.
class LatteImageBatchRepository extends Repository<LatteImageBatch> {
  /// Instantiates a [LatteImageBatchRepository].
  LatteImageBatchRepository()
    : super(
        SourceList<LatteImageBatch>(
          sources: [
            LocalMemorySource<LatteImageBatch>(
              bindings: LatteImageBatch.bindings,
            ),
            FirestoreSource<LatteImageBatch>(
              GetIt.I<FirebaseFirestore>(),
              bindings: LatteImageBatch.bindings,
            ),
          ],
          bindings: LatteImageBatch.bindings,
        ),
      );
}
