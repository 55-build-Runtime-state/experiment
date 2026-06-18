// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextQuestion _$TextQuestionFromJson(Map<String, dynamic> json) => TextQuestion(
  id: json['id'] as String,
  body: json['question'] as String,
  helpText: json['helpText'] as String? ?? 'Enter your answer',
  answer: json['answer'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TextQuestionToJson(TextQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.body,
      'helpText': instance.helpText,
      'answer': instance.answer,
      'type': instance.$type,
    };

MultipleChoiceQuestion _$MultipleChoiceQuestionFromJson(
  Map<String, dynamic> json,
) => MultipleChoiceQuestion(
  id: json['id'] as String,
  body: json['question'] as String,
  acceptableAnswers: (json['acceptableAnswers'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  selectedValue: json['selectedValue'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$MultipleChoiceQuestionToJson(
  MultipleChoiceQuestion instance,
) => <String, dynamic>{
  'id': instance.id,
  'question': instance.body,
  'acceptableAnswers': instance.acceptableAnswers,
  'selectedValue': instance.selectedValue,
  'type': instance.$type,
};

ZeroToOneQuestion _$ZeroToOneQuestionFromJson(Map<String, dynamic> json) =>
    ZeroToOneQuestion(
      id: json['id'] as String,
      body: json['question'] as String,
      minValueLabel: json['minValueLabel'] as String,
      maxValueLabel: json['maxValueLabel'] as String,
      selectedValue: (json['selectedValue'] as num?)?.toDouble(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ZeroToOneQuestionToJson(ZeroToOneQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.body,
      'minValueLabel': instance.minValueLabel,
      'maxValueLabel': instance.maxValueLabel,
      'selectedValue': instance.selectedValue,
      'type': instance.$type,
    };

NegativeOneToOneQuestion _$NegativeOneToOneQuestionFromJson(
  Map<String, dynamic> json,
) => NegativeOneToOneQuestion(
  id: json['id'] as String,
  body: json['question'] as String,
  minValueLabel: json['minValueLabel'] as String,
  maxValueLabel: json['maxValueLabel'] as String,
  selectedValue: (json['selectedValue'] as num?)?.toDouble(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$NegativeOneToOneQuestionToJson(
  NegativeOneToOneQuestion instance,
) => <String, dynamic>{
  'id': instance.id,
  'question': instance.body,
  'minValueLabel': instance.minValueLabel,
  'maxValueLabel': instance.maxValueLabel,
  'selectedValue': instance.selectedValue,
  'type': instance.$type,
};
