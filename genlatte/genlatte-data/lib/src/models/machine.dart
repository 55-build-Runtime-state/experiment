// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:data_layer/data_layer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'machine.freezed.dart';
part 'machine.g.dart';

/// An available printer.
@freezed
abstract class Machine with _$Machine {
  /// Instantiates a new [Machine].
  const factory Machine({
    required String id,
    required String name,
    @Default(true) bool isActive,
    @Default(true) bool isBlackAndWhite,
  }) = _Machine;
  const Machine._();

  /// Json factory for [Machine].
  factory Machine.fromJson(Map<String, dynamic> json) =>
      _$MachineFromJson(json);

  /// Data layer bindings for [Machine].
  static Bindings<Machine> bindings = Bindings<Machine>(
    fromJson: Machine.fromJson,
    toJson: (obj) => obj.toJson(),
    getId: (item) => item.id,
    getDetailUrl: (id) => ApiUrl(path: 'machines/$id'),
    getListUrl: () => const ApiUrl(path: 'machines'),
  );
}

/// Extension for [Machine] lists.
extension MachineList on List<Machine> {
  /// Converts the list of orders into a map keyed by order id.
  Map<String, Machine> toIdsMap() {
    return fold<Map<String, Machine>>(
      {},
      (map, machine) {
        map[machine.id] = machine;
        return map;
      },
    );
  }
}
