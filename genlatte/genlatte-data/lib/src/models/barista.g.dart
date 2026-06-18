// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barista.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Barista _$BaristaFromJson(Map<String, dynamic> json) => _Barista(
  username: json['username'] as String,
  persona: $enumDecode(_$BaristaPersonaEnumMap, json['persona']),
  id: json['id'] as String?,
);

Map<String, dynamic> _$BaristaToJson(_Barista instance) => <String, dynamic>{
  'username': instance.username,
  'persona': _$BaristaPersonaEnumMap[instance.persona]!,
  'id': instance.id,
};

const _$BaristaPersonaEnumMap = {
  BaristaPersona.blackFemale: 'blackFemale',
  BaristaPersona.asianFemale: 'asianFemale',
  BaristaPersona.caucasianFemale: 'caucasianFemale',
  BaristaPersona.hispanicFemale: 'hispanicFemale',
  BaristaPersona.indianFemale: 'indianFemale',
  BaristaPersona.blackMale: 'blackMale',
  BaristaPersona.asianMale: 'asianMale',
  BaristaPersona.caucasianMale: 'caucasianMale',
  BaristaPersona.hispanicMale: 'hispanicMale',
  BaristaPersona.indianMale: 'indianMale',
};
