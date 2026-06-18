// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:data_layer/data_layer.dart';
import 'package:data_layer_hive/data_layer_hive.dart';
import 'package:genlatte/src/sources/firestore_source.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';

/// Repository for [LatteOrderMetadata].
class LatteOrdersMetadataRepository extends Repository<LatteOrderMetadata> {
  /// Creates a new [LatteOrdersMetadataRepository].
  LatteOrdersMetadataRepository()
    : super(
        SourceList<LatteOrderMetadata>(
          bindings: LatteOrderMetadata.bindings,
          sources: <Source<LatteOrderMetadata>>[
            HiveSource<LatteOrderMetadata>(
              hiveInit: GetIt.I<HiveInitializer>().ready,
              bindings: LatteOrderMetadata.bindings,
            ),
            FirestoreSource<LatteOrderMetadata>(
              GetIt.I<FirebaseFirestore>(),
              bindings: LatteOrderMetadata.bindings,
            ),
          ],
        ),
      );
}
