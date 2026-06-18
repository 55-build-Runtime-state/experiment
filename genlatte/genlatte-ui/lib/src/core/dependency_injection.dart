// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:data_layer/data_layer.dart';
import 'package:data_layer_hive/data_layer_hive.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:genlatte/hive/hive_adapters.dart';
import 'package:genlatte/src/core/core.dart';
import 'package:genlatte/src/core/utils/utils.dart';
import 'package:genlatte/src/data/data.dart';
import 'package:genlatte/src/data/shared_preferences_repository.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Instantiates and registers all dependencies.
Future<void> setUpDependencyInjection({
  required AppEnv appEnv,
  required FirebaseFirestore firebaseFirestore,
  required FirebaseFunctions firebaseFunctions,
  FirebaseAuth? firebaseAuth,
  FirebaseAnalytics? firebaseAnalytics,
  FirebaseRemoteConfig? firebaseRemoteConfig,
}) async {
  GetIt.I.registerSingleton<AppEnv>(appEnv);
  GetIt.I.registerSingleton<FirebaseAnalytics>(
    firebaseAnalytics ?? FirebaseAnalytics.instance,
  );

  final remoteConfig = firebaseRemoteConfig ?? FirebaseRemoteConfig.instance;
  GetIt.I.registerSingleton<FirebaseRemoteConfig>(remoteConfig);

  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ),
  );
  await remoteConfig.fetchAndActivate();
  final contentGroup = remoteConfig.getString('contentgroup');

  final analytics = firebaseAnalytics ?? FirebaseAnalytics.instance;
  if (!kIsWeb) {
    await analytics.setDefaultEventParameters({'content-group': contentGroup});
  }

  GetIt.I.registerSingleton<FirebaseAuth>(
    firebaseAuth ?? FirebaseAuth.instance,
  );
  GetIt.I.registerSingleton<FirebaseFunctions>(
    firebaseFunctions,
  );
  GetIt.I.registerSingleton<FirebaseFunctionsClient>(
    FirebaseFunctionsClient(
      GetIt.I<FirebaseFunctions>(),
      appEnv: appEnv,
    ),
  );
  GetIt.I.registerSingleton<FirebaseFirestore>(firebaseFirestore);

  // This must come before any repositories which use a [HiveSource].
  GetIt.I.registerSingleton<HiveInitializer>(AppHiveInitializer());

  GetIt.I.registerSingleton<AuthBloc>(AuthBloc(GetIt.I<FirebaseAuth>()));

  GetIt.I.registerSingleton<AppRouter>(
    AppRouter(authBloc: GetIt.I<AuthBloc>()),
  );

  GetIt.I.registerSingleton<Repository<LatteImageBatch>>(
    LatteImageBatchRepository(),
  );
  final ordersRepository = LatteOrdersRepository(
    acceptImage: GetIt.I<FirebaseFunctionsClient>().acceptImage,
    completeOrder: GetIt.I<FirebaseFunctionsClient>().completeOrder,
    generateRevisedImages:
        GetIt.I<FirebaseFunctionsClient>().generateRevisedImages,
    rejectImageBatch: GetIt.I<FirebaseFunctionsClient>().rejectImageBatch,
    sendToPrinters: GetIt.I<FirebaseFunctionsClient>().sendToPrinters,
    submitOrder: GetIt.I<FirebaseFunctionsClient>().submitOrder,
  );
  GetIt.I.registerSingleton<Repository<LatteOrder>>(
    ordersRepository,
  );
  GetIt.I.registerSingleton<LatteOrdersRepository>(
    ordersRepository,
  );

  GetIt.I.registerSingleton<Repository<RecentLatteImage>>(
    RecentLatteImagesRepository(),
  );

  GetIt.I.registerSingleton<Repository<LatteOrderMetadata>>(
    LatteOrdersMetadataRepository(),
  );
  GetIt.I.registerSingleton<Repository<LatteOptions>>(
    LatteOptionsRepository(),
  );
  GetIt.I.registerSingleton<Repository<Barista>>(
    BaristaRepository(),
  );
  GetIt.I.registerSingleton<Repository<Machine>>(
    MachineRepository(),
  );

  final prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferencesRepository>(
    SharedPreferencesRepository(prefs),
  );
}
