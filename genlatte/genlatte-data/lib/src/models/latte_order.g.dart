// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latte_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LatteOrder _$LatteOrderFromJson(Map<String, dynamic> json) => _LatteOrder(
  id: json['id'] as String?,
  name: json['name'] as String?,
  milk: json['milk'] as String?,
  sweetener: json['sweetener'] as String?,
  happyPlace: json['happyPlace'] as String?,
);

Map<String, dynamic> _$LatteOrderToJson(_LatteOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'milk': instance.milk,
      'sweetener': instance.sweetener,
      'happyPlace': instance.happyPlace,
    };

_LatteOrderMetadata _$LatteOrderMetadataFromJson(Map<String, dynamic> json) =>
    _LatteOrderMetadata(
      id: json['id'] as String?,
      orderNumber: (json['orderNumber'] as num?)?.toInt(),
      isNameApproved: json['isNameApproved'] as bool?,
      isHappyPlaceApproved: json['isHappyPlaceApproved'] as bool?,
      happyPlaceModerationReason: json['happyPlaceModerationReason'] as String?,
      isImageApproved: json['isImageApproved'] as bool?,
      imageBatchId: json['imageBatchId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      status:
          $enumDecodeNullable(_$LatteOrderStatusEnumMap, json['status']) ??
          LatteOrderStatus.configuring,
      baristaId: json['baristaId'] as String?,
      orderSubmittedTime: json['orderSubmittedTime'] == null
          ? null
          : DateTime.parse(json['orderSubmittedTime'] as String),
      completionTime: json['completionTime'] == null
          ? null
          : DateTime.parse(json['completionTime'] as String),
    );

Map<String, dynamic> _$LatteOrderMetadataToJson(_LatteOrderMetadata instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'isNameApproved': instance.isNameApproved,
      'isHappyPlaceApproved': instance.isHappyPlaceApproved,
      'happyPlaceModerationReason': instance.happyPlaceModerationReason,
      'isImageApproved': instance.isImageApproved,
      'imageBatchId': instance.imageBatchId,
      'imageUrl': instance.imageUrl,
      'status': _$LatteOrderStatusEnumMap[instance.status]!,
      'baristaId': instance.baristaId,
      'orderSubmittedTime': instance.orderSubmittedTime?.toIso8601String(),
      'completionTime': instance.completionTime?.toIso8601String(),
    };

const _$LatteOrderStatusEnumMap = {
  LatteOrderStatus.configuring: 'configuring',
  LatteOrderStatus.submitted: 'submitted',
  LatteOrderStatus.validated: 'validated',
  LatteOrderStatus.inProgress: 'inProgress',
  LatteOrderStatus.completed: 'completed',
  LatteOrderStatus.archived: 'archived',
};

_Latte _$LatteFromJson(Map<String, dynamic> json) => _Latte(
  order: LatteOrder.fromJson(json['order'] as Map<String, dynamic>),
  metadata: LatteOrderMetadata.fromJson(
    json['metadata'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$LatteToJson(_Latte instance) => <String, dynamic>{
  'order': instance.order,
  'metadata': instance.metadata,
};
