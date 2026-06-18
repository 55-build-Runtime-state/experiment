// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

/// Question which informs one detail of a coffee or its latte art.
@Freezed(unionKey: 'type')
sealed class Question with _$Question {
  /// Simple text-based input, used to ask the user their name or for their
  /// happy place.
  @FreezedUnionValue('textQuestion')
  const factory Question({
    required String id,
    @JsonKey(name: 'question') //
    required String body,
    @Default('Enter your answer') String helpText,
    String? answer,
  }) = TextQuestion;

  /// Standard multiple choice question, which are provided via
  /// [acceptableAnswers].
  @FreezedUnionValue('multipleChoiceQuestion')
  const factory Question.multipleChoice({
    required String id,

    @JsonKey(name: 'question') //
    required String body,

    required List<String> acceptableAnswers,
    String? selectedValue,
  }) = MultipleChoiceQuestion;

  /// Simple end-to-end slider, with bookends like "Light" and "Dark".
  @FreezedUnionValue('zeroToOneQuestion')
  const factory Question.zeroToOne({
    required String id,
    @JsonKey(name: 'question') //
    required String body,
    required String minValueLabel,
    required String maxValueLabel,

    /// A value of 0 to 1, representing the value's place between the two
    /// labels.
    double? selectedValue,
  }) = ZeroToOneQuestion;

  /// Slider to shift a value relative to the current perceived value in the
  /// image, with values like "Lighter" and "Darker", and which will show
  /// "No change" above the midpart of the slider.
  @FreezedUnionValue('negativeOneToOneQuestion')
  const factory Question.negativeOneToOne({
    required String id,
    @JsonKey(name: 'question') //
    required String body,
    required String minValueLabel,
    required String maxValueLabel,

    /// A value of -1 to 1, representing the value's shift relative to the
    /// user's perceived value in the original image.
    double? selectedValue,
  }) = NegativeOneToOneQuestion;

  const Question._();

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  /// Returns a copy of this question with the given [answer] set.
  Question copyWithAnswer(Object? answer) => switch (this) {
    MultipleChoiceQuestion() => (this as MultipleChoiceQuestion).copyWith(
      selectedValue: answer as String?,
    ),
    ZeroToOneQuestion() => (this as ZeroToOneQuestion).copyWith(
      selectedValue: answer as double?,
    ),
    NegativeOneToOneQuestion() => (this as NegativeOneToOneQuestion).copyWith(
      selectedValue: answer as double?,
    ),
    TextQuestion() => (this as TextQuestion).copyWith(
      answer: answer as String?,
    ),
  };

  /// The answer to this question, if it has one.
  Object? get answer => switch (this) {
    MultipleChoiceQuestion(:final selectedValue) => selectedValue,
    ZeroToOneQuestion(:final selectedValue) => selectedValue,
    NegativeOneToOneQuestion(:final selectedValue) => selectedValue,
    TextQuestion(:final answer) => answer,
  };

  /// True if this question's answer is non-null.
  bool get isAnswered => answer != null;
}

/// {@template QuestionConverter}
/// Json converter for [Question].
/// {@endtemplate}
class QuestionConverter extends JsonConverter<Question, Map<String, Object?>> {
  /// {@macro QuestionConverter}
  const QuestionConverter();

  @override
  Question fromJson(Map<String, Object?> json) => Question.fromJson(json);

  @override
  Map<String, Object?> toJson(Question object) => object.toJson();
}
