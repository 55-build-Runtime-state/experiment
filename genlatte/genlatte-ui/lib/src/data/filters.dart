// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// @docImport 'package:genlatte_data/models.dart';
library;

import 'package:cloud_firestore/cloud_firestore.dart' hide Filter, Order;
import 'package:data_layer/data_layer.dart';
import 'package:genlatte/src/sources/firestore_filters.dart';
import 'package:genlatte_data/models.dart';

/// {@template LatteOrderMetadataBrewQueue}
/// Specifies LatteOrderMetadata documents that should show up in the barista's
/// queue to for brewing. These are moderated orders ready to be fulfilled.
/// {@endtemplate}
class LatteOrderMetadataBrewQueue extends FirestoreFilter {
  /// {@macro LatteOrderMetadataBrewQueue}
  const LatteOrderMetadataBrewQueue();

  @override
  Query<Json> apply(Query<Json> query) {
    return query
        .where(
          'status',
          whereIn: [
            LatteOrderStatus.validated.name,
            LatteOrderStatus.inProgress.name,
          ],
        )
        .where(
          'orderSubmittedTime',
          isGreaterThan: Timestamp.fromDate(
            DateTime.now().toUtc().subtract(
              const Duration(hours: 8),
            ),
          ),
        )
        // Note: there's no need to worry about sorting this on "moderation
        // time", which a) isn't tracked, and b) should result in the same
        // ordering as tracking on orderSubmittedTime anyways.
        .orderBy('orderSubmittedTime', descending: true);
  }

  @override
  CacheKey get cacheKey => 'brew_queue';

  @override
  Json toJson() => {
    'status': {
      'whereIn': [
        LatteOrderStatus.validated.name,
        LatteOrderStatus.inProgress.name,
      ],
    },
    'orderSubmittedTime': {
      'isGreaterThan': DateTime.now()
          .toUtc()
          .subtract(const Duration(hours: 8))
          .toIso8601String(),
    },
  };

  @override
  Params toParams() => toJson();
}

/// {@template LatteOrderMetadataBoardQueue}
/// Specifies LatteOrderMetadata documents that should show up
/// on the public queue board.
/// {@endtemplate}
class LatteOrderMetadataBoardQueue extends FirestoreFilter {
  /// {@macro LatteOrderMetadataBoardQueue}
  const LatteOrderMetadataBoardQueue();

  @override
  Query<Json> apply(Query<Json> query) {
    return query
        .where(
          'status',
          whereIn: [
            LatteOrderStatus.submitted.name,
            LatteOrderStatus.validated.name,
            LatteOrderStatus.inProgress.name,
            LatteOrderStatus.completed.name,
          ],
        )
        // TODO(filiph): also filter on sharding if possible
        .orderBy('orderSubmittedTime', descending: true);
  }

  @override
  CacheKey get cacheKey => 'board_queue';

  @override
  Json toJson() => {
    'status': {
      'whereIn': [
        LatteOrderStatus.submitted.name,
        LatteOrderStatus.validated.name,
        LatteOrderStatus.inProgress.name,
        LatteOrderStatus.completed.name,
      ],
    },
  };

  @override
  Params toParams() => toJson();
}

/// {@template LatteOrderMetadataModerationQueue}
/// Specifies LatteOrderMetadata documents that should show up in the barista's
/// queue to for moderation. Once moderated, these orders will get in the back
/// of the brew queue.
/// {@endtemplate}
class LatteOrderMetadataModerationQueue extends FirestoreFilter {
  /// {@macro LatteOrderMetadataModerationQueue}
  const LatteOrderMetadataModerationQueue();

  @override
  Query<Json> apply(Query<Json> query) {
    return query
        .where(
          'status',
          whereIn: [
            LatteOrderStatus.submitted.name,
            LatteOrderStatus.validated.name,
            LatteOrderStatus.inProgress.name,
          ],
        )
        .where(
          'orderSubmittedTime',
          isGreaterThan: Timestamp.fromDate(
            DateTime.now().toUtc().subtract(
              const Duration(hours: 8),
            ),
          ),
        )
        .orderBy('orderSubmittedTime', descending: true);
  }

  @override
  CacheKey get cacheKey => 'moderation_queue';

  @override
  Json toJson() => {
    'status': {
      'whereIn': [
        LatteOrderStatus.submitted.name,
        LatteOrderStatus.validated.name,
        LatteOrderStatus.inProgress.name,
      ],
    },
    'orderSubmittedTime': {
      'isGreaterThan': DateTime.now()
          .toUtc()
          .subtract(const Duration(hours: 8))
          .toIso8601String(),
    },
  };

  @override
  Params toParams() => toJson();
}

/// Synthetic filter used to store the logged-in Barista.
class ActiveBaristaFilter extends Filter {
  @override
  CacheKey get cacheKey => 'active_baristas';

  @override
  Json toJson() => {'active': true};

  @override
  Params toParams() => toJson();
}
