// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:data_layer_hive/data_layer_hive.dart';
import 'package:genlatte/hive/hive_registrar.g.dart';
import 'package:genlatte_data/models.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';

@GenerateAdapters([
  AdapterSpec<Barista>(),
  AdapterSpec<BaristaPersona>(),
  AdapterSpec<Latte>(),
  AdapterSpec<LatteOrder>(),
  AdapterSpec<LatteOrderMetadata>(),
  AdapterSpec<LatteOrderStatus>(),
  AdapterSpec<LatteImageBatch>(),
  AdapterSpec<LatteImage>(),
  AdapterSpec<Machine>(),
  AdapterSpec<Question>(),
])
part 'hive_adapters.g.dart';

final _log = Logger('HiveInitializer');

/// {@template AppHiveInitializer}
/// Class which exists to call `Hive.initFlutter` and `Hive.registerAdapters`
/// and report back when both are complete.
/// {@endtemplate}
class AppHiveInitializer extends HiveInitializer {
  /// {@macro AppHiveInitializer}
  AppHiveInitializer() {
    initialize();
  }

  @override
  Future<void> performInitialization() {
    return Hive.initFlutter().then((_) {
      try {
        Hive.registerAdapters();
        markReady(null);
      } on Exception catch (e, st) {
        _log.shout('Failed to initialize Hive: $e :: $st');
      }
    });
  }
}
