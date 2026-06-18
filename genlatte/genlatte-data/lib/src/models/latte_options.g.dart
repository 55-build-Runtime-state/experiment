// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latte_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LatteOptions _$LatteOptionsFromJson(Map<String, dynamic> json) =>
    _LatteOptions(
      id: json['id'] as String,
      values: (json['values'] as List<dynamic>)
          .map(
            (e) => const LatteOptionConverter().fromJson(
              e as Map<String, Object?>,
            ),
          )
          .toList(),
    );

Map<String, dynamic> _$LatteOptionsToJson(
  _LatteOptions instance,
) => <String, dynamic>{
  'id': instance.id,
  'values': instance.values.map(const LatteOptionConverter().toJson).toList(),
};

_LatteOption _$LatteOptionFromJson(Map<String, dynamic> json) => _LatteOption(
  name: json['name'] as String,
  isAvailable: json['isAvailable'] as bool? ?? true,
);

Map<String, dynamic> _$LatteOptionToJson(_LatteOption instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isAvailable': instance.isAvailable,
    };
