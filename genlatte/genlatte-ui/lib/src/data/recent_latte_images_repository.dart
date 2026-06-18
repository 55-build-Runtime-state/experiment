// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' show Random;

import 'package:cloud_firestore/cloud_firestore.dart' hide Source;
import 'package:data_layer/data_layer.dart';
import 'package:genlatte/src/sources/firestore_source.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

/// Repository for [LatteImage] that is used to fetch recent latte images.
class RecentLatteImagesRepository extends Repository<RecentLatteImage> {
  /// Instantiates the [RecentLatteImagesRepository].
  RecentLatteImagesRepository()
    : super(
        SourceList<RecentLatteImage>(
          bindings: RecentLatteImage.recentBindings,
          sources: <Source<RecentLatteImage>>[
            FirestoreSource<RecentLatteImage>(
              GetIt.I<FirebaseFirestore>(),
              bindings: RecentLatteImage.recentBindings,
              onCreateServerTimestampFields: ['createdAt'],
            ),
          ],
        ),
      );

  final _log = Logger('RecentLatteImagesRepository');

  /// Fake method to be deleted.
  // TODO(craiglabenz): Delete this and everything around its call site once
  // the recent images screen is considered 100% done.
  Future<void> addRandomRecentImage() async {
    final batchRepository = GetIt.I<Repository<LatteImageBatch>>();
    final batches = await batchRepository.getItems();
    final randomIndex = Random().nextInt(batches.length);
    final randomBatch = batches[randomIndex];
    _log.info('Random batch: ${randomBatch.id}');
    final imageIndex = Random().nextInt(4);
    final randomImage = randomBatch.images.toList()[imageIndex];

    final order = await GetIt.I<Repository<LatteOrder>>().getById(
      randomBatch.orderId,
    );

    final recentImage = RecentLatteImage(
      imageUrl: randomImage!.imageUrl,
      prompt: randomImage.prompt,
      description: randomImage.description,
      createdAt: DateTime.now(),
      happyPlace: order!.happyPlace!,
      name: order.name!,
    );
    await setItem(recentImage);
  }
}
