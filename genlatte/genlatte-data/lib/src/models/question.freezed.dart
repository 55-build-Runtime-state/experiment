// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Question _$QuestionFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'textQuestion':
          return TextQuestion.fromJson(
            json
          );
                case 'multipleChoiceQuestion':
          return MultipleChoiceQuestion.fromJson(
            json
          );
                case 'zeroToOneQuestion':
          return ZeroToOneQuestion.fromJson(
            json
          );
                case 'negativeOneToOneQuestion':
          return NegativeOneToOneQuestion.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Question',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Question {

 String get id;@JsonKey(name: 'question') String get body;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,body);

@override
String toString() {
  return 'Question(id: $id, body: $body)';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'question') String body
});




}
/// @nodoc
class _$QuestionCopyWithImpl<$Res>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? body = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Question].
extension QuestionPatterns on Question {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( TextQuestion value)?  $default,{TResult Function( MultipleChoiceQuestion value)?  multipleChoice,TResult Function( ZeroToOneQuestion value)?  zeroToOne,TResult Function( NegativeOneToOneQuestion value)?  negativeOneToOne,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TextQuestion() when $default != null:
return $default(_that);case MultipleChoiceQuestion() when multipleChoice != null:
return multipleChoice(_that);case ZeroToOneQuestion() when zeroToOne != null:
return zeroToOne(_that);case NegativeOneToOneQuestion() when negativeOneToOne != null:
return negativeOneToOne(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( TextQuestion value)  $default,{required TResult Function( MultipleChoiceQuestion value)  multipleChoice,required TResult Function( ZeroToOneQuestion value)  zeroToOne,required TResult Function( NegativeOneToOneQuestion value)  negativeOneToOne,}){
final _that = this;
switch (_that) {
case TextQuestion():
return $default(_that);case MultipleChoiceQuestion():
return multipleChoice(_that);case ZeroToOneQuestion():
return zeroToOne(_that);case NegativeOneToOneQuestion():
return negativeOneToOne(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( TextQuestion value)?  $default,{TResult? Function( MultipleChoiceQuestion value)?  multipleChoice,TResult? Function( ZeroToOneQuestion value)?  zeroToOne,TResult? Function( NegativeOneToOneQuestion value)?  negativeOneToOne,}){
final _that = this;
switch (_that) {
case TextQuestion() when $default != null:
return $default(_that);case MultipleChoiceQuestion() when multipleChoice != null:
return multipleChoice(_that);case ZeroToOneQuestion() when zeroToOne != null:
return zeroToOne(_that);case NegativeOneToOneQuestion() when negativeOneToOne != null:
return negativeOneToOne(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'question')  String body,  String helpText,  String? answer)?  $default,{TResult Function( String id, @JsonKey(name: 'question')  String body,  List<String> acceptableAnswers,  String? selectedValue)?  multipleChoice,TResult Function( String id, @JsonKey(name: 'question')  String body,  String minValueLabel,  String maxValueLabel,  double? selectedValue)?  zeroToOne,TResult Function( String id, @JsonKey(name: 'question')  String body,  String minValueLabel,  String maxValueLabel,  double? selectedValue)?  negativeOneToOne,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TextQuestion() when $default != null:
return $default(_that.id,_that.body,_that.helpText,_that.answer);case MultipleChoiceQuestion() when multipleChoice != null:
return multipleChoice(_that.id,_that.body,_that.acceptableAnswers,_that.selectedValue);case ZeroToOneQuestion() when zeroToOne != null:
return zeroToOne(_that.id,_that.body,_that.minValueLabel,_that.maxValueLabel,_that.selectedValue);case NegativeOneToOneQuestion() when negativeOneToOne != null:
return negativeOneToOne(_that.id,_that.body,_that.minValueLabel,_that.maxValueLabel,_that.selectedValue);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'question')  String body,  String helpText,  String? answer)  $default,{required TResult Function( String id, @JsonKey(name: 'question')  String body,  List<String> acceptableAnswers,  String? selectedValue)  multipleChoice,required TResult Function( String id, @JsonKey(name: 'question')  String body,  String minValueLabel,  String maxValueLabel,  double? selectedValue)  zeroToOne,required TResult Function( String id, @JsonKey(name: 'question')  String body,  String minValueLabel,  String maxValueLabel,  double? selectedValue)  negativeOneToOne,}) {final _that = this;
switch (_that) {
case TextQuestion():
return $default(_that.id,_that.body,_that.helpText,_that.answer);case MultipleChoiceQuestion():
return multipleChoice(_that.id,_that.body,_that.acceptableAnswers,_that.selectedValue);case ZeroToOneQuestion():
return zeroToOne(_that.id,_that.body,_that.minValueLabel,_that.maxValueLabel,_that.selectedValue);case NegativeOneToOneQuestion():
return negativeOneToOne(_that.id,_that.body,_that.minValueLabel,_that.maxValueLabel,_that.selectedValue);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'question')  String body,  String helpText,  String? answer)?  $default,{TResult? Function( String id, @JsonKey(name: 'question')  String body,  List<String> acceptableAnswers,  String? selectedValue)?  multipleChoice,TResult? Function( String id, @JsonKey(name: 'question')  String body,  String minValueLabel,  String maxValueLabel,  double? selectedValue)?  zeroToOne,TResult? Function( String id, @JsonKey(name: 'question')  String body,  String minValueLabel,  String maxValueLabel,  double? selectedValue)?  negativeOneToOne,}) {final _that = this;
switch (_that) {
case TextQuestion() when $default != null:
return $default(_that.id,_that.body,_that.helpText,_that.answer);case MultipleChoiceQuestion() when multipleChoice != null:
return multipleChoice(_that.id,_that.body,_that.acceptableAnswers,_that.selectedValue);case ZeroToOneQuestion() when zeroToOne != null:
return zeroToOne(_that.id,_that.body,_that.minValueLabel,_that.maxValueLabel,_that.selectedValue);case NegativeOneToOneQuestion() when negativeOneToOne != null:
return negativeOneToOne(_that.id,_that.body,_that.minValueLabel,_that.maxValueLabel,_that.selectedValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class TextQuestion extends Question {
  const TextQuestion({required this.id, @JsonKey(name: 'question') required this.body, this.helpText = 'Enter your answer', this.answer, final  String? $type}): $type = $type ?? 'textQuestion',super._();
  factory TextQuestion.fromJson(Map<String, dynamic> json) => _$TextQuestionFromJson(json);

@override final  String id;
@override@JsonKey(name: 'question') final  String body;
@JsonKey() final  String helpText;
 final  String? answer;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextQuestionCopyWith<TextQuestion> get copyWith => _$TextQuestionCopyWithImpl<TextQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.helpText, helpText) || other.helpText == helpText)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,body,helpText,answer);

@override
String toString() {
  return 'Question(id: $id, body: $body, helpText: $helpText, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $TextQuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory $TextQuestionCopyWith(TextQuestion value, $Res Function(TextQuestion) _then) = _$TextQuestionCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'question') String body, String helpText, String? answer
});




}
/// @nodoc
class _$TextQuestionCopyWithImpl<$Res>
    implements $TextQuestionCopyWith<$Res> {
  _$TextQuestionCopyWithImpl(this._self, this._then);

  final TextQuestion _self;
  final $Res Function(TextQuestion) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? body = null,Object? helpText = null,Object? answer = freezed,}) {
  return _then(TextQuestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,helpText: null == helpText ? _self.helpText : helpText // ignore: cast_nullable_to_non_nullable
as String,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class MultipleChoiceQuestion extends Question {
  const MultipleChoiceQuestion({required this.id, @JsonKey(name: 'question') required this.body, required final  List<String> acceptableAnswers, this.selectedValue, final  String? $type}): _acceptableAnswers = acceptableAnswers,$type = $type ?? 'multipleChoiceQuestion',super._();
  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) => _$MultipleChoiceQuestionFromJson(json);

@override final  String id;
@override@JsonKey(name: 'question') final  String body;
 final  List<String> _acceptableAnswers;
 List<String> get acceptableAnswers {
  if (_acceptableAnswers is EqualUnmodifiableListView) return _acceptableAnswers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_acceptableAnswers);
}

 final  String? selectedValue;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MultipleChoiceQuestionCopyWith<MultipleChoiceQuestion> get copyWith => _$MultipleChoiceQuestionCopyWithImpl<MultipleChoiceQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MultipleChoiceQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MultipleChoiceQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._acceptableAnswers, _acceptableAnswers)&&(identical(other.selectedValue, selectedValue) || other.selectedValue == selectedValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,body,const DeepCollectionEquality().hash(_acceptableAnswers),selectedValue);

@override
String toString() {
  return 'Question.multipleChoice(id: $id, body: $body, acceptableAnswers: $acceptableAnswers, selectedValue: $selectedValue)';
}


}

/// @nodoc
abstract mixin class $MultipleChoiceQuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory $MultipleChoiceQuestionCopyWith(MultipleChoiceQuestion value, $Res Function(MultipleChoiceQuestion) _then) = _$MultipleChoiceQuestionCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'question') String body, List<String> acceptableAnswers, String? selectedValue
});




}
/// @nodoc
class _$MultipleChoiceQuestionCopyWithImpl<$Res>
    implements $MultipleChoiceQuestionCopyWith<$Res> {
  _$MultipleChoiceQuestionCopyWithImpl(this._self, this._then);

  final MultipleChoiceQuestion _self;
  final $Res Function(MultipleChoiceQuestion) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? body = null,Object? acceptableAnswers = null,Object? selectedValue = freezed,}) {
  return _then(MultipleChoiceQuestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,acceptableAnswers: null == acceptableAnswers ? _self._acceptableAnswers : acceptableAnswers // ignore: cast_nullable_to_non_nullable
as List<String>,selectedValue: freezed == selectedValue ? _self.selectedValue : selectedValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ZeroToOneQuestion extends Question {
  const ZeroToOneQuestion({required this.id, @JsonKey(name: 'question') required this.body, required this.minValueLabel, required this.maxValueLabel, this.selectedValue, final  String? $type}): $type = $type ?? 'zeroToOneQuestion',super._();
  factory ZeroToOneQuestion.fromJson(Map<String, dynamic> json) => _$ZeroToOneQuestionFromJson(json);

@override final  String id;
@override@JsonKey(name: 'question') final  String body;
 final  String minValueLabel;
 final  String maxValueLabel;
/// A value of 0 to 1, representing the value's place between the two
/// labels.
 final  double? selectedValue;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZeroToOneQuestionCopyWith<ZeroToOneQuestion> get copyWith => _$ZeroToOneQuestionCopyWithImpl<ZeroToOneQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZeroToOneQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZeroToOneQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.minValueLabel, minValueLabel) || other.minValueLabel == minValueLabel)&&(identical(other.maxValueLabel, maxValueLabel) || other.maxValueLabel == maxValueLabel)&&(identical(other.selectedValue, selectedValue) || other.selectedValue == selectedValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,body,minValueLabel,maxValueLabel,selectedValue);

@override
String toString() {
  return 'Question.zeroToOne(id: $id, body: $body, minValueLabel: $minValueLabel, maxValueLabel: $maxValueLabel, selectedValue: $selectedValue)';
}


}

/// @nodoc
abstract mixin class $ZeroToOneQuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory $ZeroToOneQuestionCopyWith(ZeroToOneQuestion value, $Res Function(ZeroToOneQuestion) _then) = _$ZeroToOneQuestionCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'question') String body, String minValueLabel, String maxValueLabel, double? selectedValue
});




}
/// @nodoc
class _$ZeroToOneQuestionCopyWithImpl<$Res>
    implements $ZeroToOneQuestionCopyWith<$Res> {
  _$ZeroToOneQuestionCopyWithImpl(this._self, this._then);

  final ZeroToOneQuestion _self;
  final $Res Function(ZeroToOneQuestion) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? body = null,Object? minValueLabel = null,Object? maxValueLabel = null,Object? selectedValue = freezed,}) {
  return _then(ZeroToOneQuestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,minValueLabel: null == minValueLabel ? _self.minValueLabel : minValueLabel // ignore: cast_nullable_to_non_nullable
as String,maxValueLabel: null == maxValueLabel ? _self.maxValueLabel : maxValueLabel // ignore: cast_nullable_to_non_nullable
as String,selectedValue: freezed == selectedValue ? _self.selectedValue : selectedValue // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NegativeOneToOneQuestion extends Question {
  const NegativeOneToOneQuestion({required this.id, @JsonKey(name: 'question') required this.body, required this.minValueLabel, required this.maxValueLabel, this.selectedValue, final  String? $type}): $type = $type ?? 'negativeOneToOneQuestion',super._();
  factory NegativeOneToOneQuestion.fromJson(Map<String, dynamic> json) => _$NegativeOneToOneQuestionFromJson(json);

@override final  String id;
@override@JsonKey(name: 'question') final  String body;
 final  String minValueLabel;
 final  String maxValueLabel;
/// A value of -1 to 1, representing the value's shift relative to the
/// user's perceived value in the original image.
 final  double? selectedValue;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NegativeOneToOneQuestionCopyWith<NegativeOneToOneQuestion> get copyWith => _$NegativeOneToOneQuestionCopyWithImpl<NegativeOneToOneQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NegativeOneToOneQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NegativeOneToOneQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.minValueLabel, minValueLabel) || other.minValueLabel == minValueLabel)&&(identical(other.maxValueLabel, maxValueLabel) || other.maxValueLabel == maxValueLabel)&&(identical(other.selectedValue, selectedValue) || other.selectedValue == selectedValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,body,minValueLabel,maxValueLabel,selectedValue);

@override
String toString() {
  return 'Question.negativeOneToOne(id: $id, body: $body, minValueLabel: $minValueLabel, maxValueLabel: $maxValueLabel, selectedValue: $selectedValue)';
}


}

/// @nodoc
abstract mixin class $NegativeOneToOneQuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory $NegativeOneToOneQuestionCopyWith(NegativeOneToOneQuestion value, $Res Function(NegativeOneToOneQuestion) _then) = _$NegativeOneToOneQuestionCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'question') String body, String minValueLabel, String maxValueLabel, double? selectedValue
});




}
/// @nodoc
class _$NegativeOneToOneQuestionCopyWithImpl<$Res>
    implements $NegativeOneToOneQuestionCopyWith<$Res> {
  _$NegativeOneToOneQuestionCopyWithImpl(this._self, this._then);

  final NegativeOneToOneQuestion _self;
  final $Res Function(NegativeOneToOneQuestion) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? body = null,Object? minValueLabel = null,Object? maxValueLabel = null,Object? selectedValue = freezed,}) {
  return _then(NegativeOneToOneQuestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,minValueLabel: null == minValueLabel ? _self.minValueLabel : minValueLabel // ignore: cast_nullable_to_non_nullable
as String,maxValueLabel: null == maxValueLabel ? _self.maxValueLabel : maxValueLabel // ignore: cast_nullable_to_non_nullable
as String,selectedValue: freezed == selectedValue ? _self.selectedValue : selectedValue // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
