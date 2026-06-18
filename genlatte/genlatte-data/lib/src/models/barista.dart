// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:data_layer/data_layer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'barista.freezed.dart';
part 'barista.g.dart';

/// An admin worker can moderate and fulfill orders.
@freezed
abstract class Barista with _$Barista {
  /// Instantiates a [Barista].
  const factory Barista({
    required String username,
    required BaristaPersona persona,
    String? id,
  }) = _Barista;

  /// Json deserializer for [Barista].
  factory Barista.fromJson(Map<String, dynamic> json) =>
      _$BaristaFromJson(json);

  /// Data layer bindings for [Barista].
  static Bindings<Barista> bindings = Bindings<Barista>(
    fromJson: Barista.fromJson,
    toJson: (obj) => obj.toJson(),
    getId: (item) => item.id,
    getDetailUrl: (id) => ApiUrl(path: 'baristas/$id'),
    getListUrl: () => const ApiUrl(path: 'baristas'),
  );
}

/// Generic avatars for [Barista]s.
enum BaristaPersona {
  /// A Black female barista.
  blackFemale,

  /// An Asian female barista.
  asianFemale,

  /// A Caucasian female barista.
  caucasianFemale,

  /// A Hispanic female barista.
  hispanicFemale,

  /// An Indian female barista.
  indianFemale,

  /// A Black male barista.
  blackMale,

  /// An Asian male barista.
  asianMale,

  /// A Caucasian male barista.
  caucasianMale,

  /// A Hispanic male barista.
  hispanicMale,

  /// An Indian male barista.
  indianMale;

  /// The asset name for the avatar image.
  String get assetName => 'assets/avatars/$name.png';
}

/// Extension for [Barista] lists.
extension BaristaList on List<Barista> {
  /// Converts the list of orders into a map keyed by order id.
  Map<String, Barista> toIdsMap() {
    return fold<Map<String, Barista>>(
      {},
      (map, order) {
        map[order.id!] = order;
        return map;
      },
    );
  }
}
