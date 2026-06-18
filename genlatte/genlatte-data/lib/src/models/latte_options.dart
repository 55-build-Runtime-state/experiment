// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// @docImport 'package:genlatte_data/src/models/latte_order.dart';
library;

import 'package:data_layer/data_layer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'latte_options.freezed.dart';
part 'latte_options.g.dart';

/// Milk and Sweetener options for a [LatteOrder].
@freezed
abstract class LatteOptions with _$LatteOptions {
  /// Instantiates a [LatteOptions].
  const factory LatteOptions({
    required String id,
    @LatteOptionConverter() required List<LatteOption> values,
  }) = _LatteOptions;

  const LatteOptions._();

  /// Json deserializer for [LatteOptions].
  factory LatteOptions.fromJson(Map<String, Object?> json) =>
      _$LatteOptionsFromJson(json);

  /// Data Layer bindings for [LatteOptions].
  static Bindings<LatteOptions> bindings = Bindings<LatteOptions>(
    fromJson: LatteOptions.fromJson,
    toJson: (obj) => obj.toJson(),
    getId: (obj) => obj.id,
    getDetailUrl: (id) => ApiUrl(path: 'latteOptions/$id'),
    getListUrl: () => const ApiUrl(path: 'latteOptions'),
  );
}

/// An entry within [LatteOptions].
///
/// For example, if the surrounding [LatteOptions] is for "milk", the values
/// could be "whole", "skim", "oat".
@Freezed()
abstract class LatteOption with _$LatteOption {
  /// Instantiates a [LatteOption].
  const factory LatteOption({
    required String name,
    @Default(true) bool isAvailable,
  }) = _LatteOption;

  const LatteOption._();

  /// Json deserializer for [LatteOption].
  factory LatteOption.fromJson(Map<String, Object?> json) =>
      _$LatteOptionFromJson(json);
}

/// JsonConverter for [LatteOption] used in [LatteOptions.values].
class LatteOptionConverter extends JsonConverter<LatteOption, Json> {
  /// Instantiates a [LatteOptionConverter].
  const LatteOptionConverter();

  @override
  LatteOption fromJson(Json json) => LatteOption.fromJson(json);

  @override
  Json toJson(LatteOption obj) => obj.toJson();
}
