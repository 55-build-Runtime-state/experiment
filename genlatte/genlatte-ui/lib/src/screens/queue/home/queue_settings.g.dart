// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QueueSettingsState _$QueueSettingsStateFromJson(Map<String, dynamic> json) =>
    _QueueSettingsState(
      isTopScreen: json['isTopScreen'] as bool? ?? false,
      topOrdersCount: (json['topOrdersCount'] as num?)?.toInt() ?? 0,
      shardNumber: (json['shardNumber'] as num?)?.toInt() ?? 1,
      shardTotal: (json['shardTotal'] as num?)?.toInt() ?? 1,
      maxShowAge: json['maxShowAge'] == null
          ? const Duration(minutes: 15)
          : Duration(microseconds: (json['maxShowAge'] as num).toInt()),
      maxRecentAge: json['maxRecentAge'] == null
          ? const Duration(minutes: 5)
          : Duration(microseconds: (json['maxRecentAge'] as num).toInt()),
      pageUpdatePeriod: json['pageUpdatePeriod'] == null
          ? const Duration(seconds: 5)
          : Duration(microseconds: (json['pageUpdatePeriod'] as num).toInt()),
      targetRowHeight: (json['targetRowHeight'] as num?)?.toDouble() ?? 100,
    );

Map<String, dynamic> _$QueueSettingsStateToJson(_QueueSettingsState instance) =>
    <String, dynamic>{
      'isTopScreen': instance.isTopScreen,
      'topOrdersCount': instance.topOrdersCount,
      'shardNumber': instance.shardNumber,
      'shardTotal': instance.shardTotal,
      'maxShowAge': instance.maxShowAge.inMicroseconds,
      'maxRecentAge': instance.maxRecentAge.inMicroseconds,
      'pageUpdatePeriod': instance.pageUpdatePeriod.inMicroseconds,
      'targetRowHeight': instance.targetRowHeight,
    };
