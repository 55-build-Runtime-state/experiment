// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, Query;
import 'package:data_layer/data_layer.dart';
import 'package:data_layer_hive/data_layer_hive.dart';
import 'package:genlatte/src/sources/firestore_filters.dart';
import 'package:genlatte/src/sources/firestore_source.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';

/// Repository for [Machine].
class MachineRepository extends Repository<Machine> {
  /// Creates a new [MachineRepository].
  MachineRepository()
    : super(
        SourceList<Machine>(
          bindings: Machine.bindings,
          sources: <Source<Machine>>[
            HiveSource<Machine>(
              hiveInit: GetIt.I<HiveInitializer>().ready,
              bindings: Machine.bindings,
            ),
            FirestoreSource<Machine>(
              GetIt.I<FirebaseFirestore>(),
              bindings: Machine.bindings,
            ),
          ],
        ),
      );
}

/// Filter for active machines.
class ActiveMachinesFilter extends FirestoreFilter {
  /// Instantiates a new [ActiveMachinesFilter].
  const ActiveMachinesFilter();

  @override
  Query<Json> apply(Query<Json> query) =>
      query.where('isActive', isEqualTo: true);

  @override
  CacheKey get cacheKey => 'active_machines';

  @override
  Json toJson() => {'type': 'active_machines'};

  @override
  Params toParams() => <String, String>{'isActive': 'true'};
}
