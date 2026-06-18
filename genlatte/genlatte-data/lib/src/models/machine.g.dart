// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Machine _$MachineFromJson(Map<String, dynamic> json) => _Machine(
  id: json['id'] as String,
  name: json['name'] as String,
  isActive: json['isActive'] as bool? ?? true,
  isBlackAndWhite: json['isBlackAndWhite'] as bool? ?? true,
);

Map<String, dynamic> _$MachineToJson(_Machine instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'isActive': instance.isActive,
  'isBlackAndWhite': instance.isBlackAndWhite,
};
