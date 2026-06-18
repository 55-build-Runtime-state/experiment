// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart' hide Filter;
import 'package:data_layer/data_layer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'firestore_filters.freezed.dart';
part 'firestore_filters.g.dart';

/// {@template FirestoreFilter}
/// Filter for Firestore queries.
/// {@endtemplate}
abstract class FirestoreFilter extends Filter {
  /// {@macro FirestoreFilter}
  const FirestoreFilter();

  /// Add whatever WHERE clauses are necessary to modify this [query].
  Query<Json> apply(Query<Json> query);
}

/// Firestore filters for queries against the Orders collection.
@Freezed()
sealed class OrdersFilter extends FirestoreFilter with _$OrdersFilter {
  const OrdersFilter._();

  /// Loads orders which are in any state other than incomplete.
  const factory OrdersFilter.incompleteOrders() = IncompleteFilter;

  factory OrdersFilter.fromJson(Map<String, dynamic> json) =>
      _$OrdersFilterFromJson(json);

  @override
  Query<Json> apply(Query<Json> query) => switch (this) {
    IncompleteFilter() => query.where('status', isNotEqualTo: 'complete'),
  };

  @override
  CacheKey get cacheKey => toString();

  @override
  Params toParams() => throw UnimplementedError();
}
