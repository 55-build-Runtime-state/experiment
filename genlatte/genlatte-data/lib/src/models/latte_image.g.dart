// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latte_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LatteImageBatch _$LatteImageBatchFromJson(Map<String, dynamic> json) =>
    _LatteImageBatch(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      image0: _$JsonConverterFromJson<Map<String, Object?>, LatteImage>(
        json['image0'],
        const LatteImageConverter().fromJson,
      ),
      image1: _$JsonConverterFromJson<Map<String, Object?>, LatteImage>(
        json['image1'],
        const LatteImageConverter().fromJson,
      ),
      image2: _$JsonConverterFromJson<Map<String, Object?>, LatteImage>(
        json['image2'],
        const LatteImageConverter().fromJson,
      ),
      image3: _$JsonConverterFromJson<Map<String, Object?>, LatteImage>(
        json['image3'],
        const LatteImageConverter().fromJson,
      ),
      parent:
          _$JsonConverterFromJson<Map<String, Object?>, LatteImageBatchParent>(
            json['parent'],
            const LatteImageBatchParentConverter().fromJson,
          ),
    );

Map<String, dynamic> _$LatteImageBatchToJson(
  _LatteImageBatch instance,
) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'image0': _$JsonConverterToJson<Map<String, Object?>, LatteImage>(
    instance.image0,
    const LatteImageConverter().toJson,
  ),
  'image1': _$JsonConverterToJson<Map<String, Object?>, LatteImage>(
    instance.image1,
    const LatteImageConverter().toJson,
  ),
  'image2': _$JsonConverterToJson<Map<String, Object?>, LatteImage>(
    instance.image2,
    const LatteImageConverter().toJson,
  ),
  'image3': _$JsonConverterToJson<Map<String, Object?>, LatteImage>(
    instance.image3,
    const LatteImageConverter().toJson,
  ),
  'parent': _$JsonConverterToJson<Map<String, Object?>, LatteImageBatchParent>(
    instance.parent,
    const LatteImageBatchParentConverter().toJson,
  ),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_LatteImageBatchParent _$LatteImageBatchParentFromJson(
  Map<String, dynamic> json,
) => _LatteImageBatchParent(
  id: json['id'] as String,
  imageIndex: json['imageIndex'] as String,
);

Map<String, dynamic> _$LatteImageBatchParentToJson(
  _LatteImageBatchParent instance,
) => <String, dynamic>{'id': instance.id, 'imageIndex': instance.imageIndex};

_LatteImage _$LatteImageFromJson(Map<String, dynamic> json) => _LatteImage(
  imageUrl: json['imageUrl'] as String,
  prompt: json['prompt'] as String,
  questions: (json['questions'] as List<dynamic>?)
      ?.map(
        (e) => const QuestionConverter().fromJson(e as Map<String, Object?>),
      )
      .toList(),
  description: json['description'] as String,
);

Map<String, dynamic> _$LatteImageToJson(_LatteImage instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'prompt': instance.prompt,
      'questions': instance.questions
          ?.map(const QuestionConverter().toJson)
          .toList(),
      'description': instance.description,
    };

_RecentLatteImage _$RecentLatteImageFromJson(Map<String, dynamic> json) =>
    _RecentLatteImage(
      imageUrl: json['imageUrl'] as String,
      prompt: json['prompt'] as String,
      happyPlace: json['happyPlace'] as String,
      description: json['description'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$RecentLatteImageToJson(_RecentLatteImage instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'prompt': instance.prompt,
      'happyPlace': instance.happyPlace,
      'description': instance.description,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'id': instance.id,
    };
