// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:data_layer_hive/data_layer_hive.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:genlatte/firebase_options.dart';
import 'package:genlatte/src/core/core.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

/// {@template bootstrap}
/// Application bootstrap.
/// {@endtemplate}
Future<void> bootstrap({AppEnv? appEnv}) async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  final env = appEnv ?? AppEnv.current;

  final defaultOptions = DefaultFirebaseOptions.currentPlatform;
  final customMeasurementId = env.isProd
      ? defaultOptions.measurementId
      : 'G-51CFKR9L9R';

  final options = FirebaseOptions(
    apiKey: defaultOptions.apiKey,
    appId: defaultOptions.appId,
    messagingSenderId: defaultOptions.messagingSenderId,
    projectId: defaultOptions.projectId,
    authDomain: defaultOptions.authDomain,
    databaseURL: defaultOptions.databaseURL,
    storageBucket: defaultOptions.storageBucket,
    measurementId: customMeasurementId,
  );

  final app = await Firebase.initializeApp(
    options: options,
  );

  await setUpDependencyInjection(
    appEnv: env,
    firebaseFirestore: FirebaseFirestore.instanceFor(
      app: app,
      databaseId: 'gcdemos-26-int-dd-latteart-${env.name}',
    ),
    firebaseFunctions: FirebaseFunctions.instance,
    firebaseAnalytics: FirebaseAnalytics.instance,
    firebaseRemoteConfig: FirebaseRemoteConfig.instance,
  );

  // Register Hive adapaters and signal to HiveSources when that process
  // is complete.
  GetIt.I<HiveInitializer>().initialize();

  // await deleteAllDocumentsInCollection('latteOrders');
  // await deleteAllDocumentsInCollection('latteImageBatches');
  // await deleteAllDocumentsInCollection('latteOrderMetadata');
  // await deleteAllDocumentsInCollection('recentLatteImages');

  await migrateOptionsCollection();

  Logger.root.level = Level.FINE; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(
    AppView(
      authBloc: GetIt.I<AuthBloc>(),
      appRouter: GetIt.I<AppRouter>(),
    ),
  );
}

/// Helper function to delete all documents in a specified Firestore collection.
Future<void> deleteAllDocumentsInCollection(String collectionName) async {
  final firestore = GetIt.I<FirebaseFirestore>();
  final snapshot = await firestore.collection(collectionName).get();
  await Future.wait(snapshot.docs.map((doc) => doc.reference.delete()));
  debugPrint('Deleted ${snapshot.docs.length} documents from $collectionName');
}

/// Migrates the latteOptions collection to the new format. No-op once
/// already migrated. This can be deleted after the first application runs this
/// code against production.
Future<void> migrateOptionsCollection() async {
  final firestore = GetIt.I<FirebaseFirestore>();
  final optionsSnapshot = await firestore.collection('latteOptions').get();
  for (final doc in optionsSnapshot.docs) {
    final data = doc.data();
    final values = data['values'] as List<dynamic>?;
    if (values != null && values.isNotEmpty && values.first is String) {
      final newValues = values
          .map((v) => {'name': v as String, 'isAvailable': true})
          .toList();
      await doc.reference.update({'values': newValues});
      debugPrint('Migrated LatteOptions document: ${doc.id}');
    }
  }
}
