// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueueSettingsState {

/// If set to `true`, this screen will only show the first page and will
/// never paginate.
///
/// If set to `false`, this screen works normally except it ignores
/// the first [topOrdersCount] of orders.
 bool get isTopScreen;/// Asks the screen to ignore the first N orders (because, presumably,
/// they are shown on the top screen (see [isTopScreen]).
 int get topOrdersCount;/// The shard number of this device.
 int get shardNumber;/// The total number of shards in play.
 int get shardTotal;/// The maximum age of a completed order, after which the order will not
/// be shown anymore.
 Duration get maxShowAge;/// The duration for which an order is considered "recent". The UI may
/// choose to highlight such orders.
 Duration get maxRecentAge;/// The duration between updates of the UI.
 Duration get pageUpdatePeriod;/// A scaling factor for order rows. Can be customized in order to achieve
/// more or less dense displays (for example, when the display is farther
/// away from the customers than expected).
 double get targetRowHeight;
/// Create a copy of QueueSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueSettingsStateCopyWith<QueueSettingsState> get copyWith => _$QueueSettingsStateCopyWithImpl<QueueSettingsState>(this as QueueSettingsState, _$identity);

  /// Serializes this QueueSettingsState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueSettingsState&&(identical(other.isTopScreen, isTopScreen) || other.isTopScreen == isTopScreen)&&(identical(other.topOrdersCount, topOrdersCount) || other.topOrdersCount == topOrdersCount)&&(identical(other.shardNumber, shardNumber) || other.shardNumber == shardNumber)&&(identical(other.shardTotal, shardTotal) || other.shardTotal == shardTotal)&&(identical(other.maxShowAge, maxShowAge) || other.maxShowAge == maxShowAge)&&(identical(other.maxRecentAge, maxRecentAge) || other.maxRecentAge == maxRecentAge)&&(identical(other.pageUpdatePeriod, pageUpdatePeriod) || other.pageUpdatePeriod == pageUpdatePeriod)&&(identical(other.targetRowHeight, targetRowHeight) || other.targetRowHeight == targetRowHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isTopScreen,topOrdersCount,shardNumber,shardTotal,maxShowAge,maxRecentAge,pageUpdatePeriod,targetRowHeight);

@override
String toString() {
  return 'QueueSettingsState(isTopScreen: $isTopScreen, topOrdersCount: $topOrdersCount, shardNumber: $shardNumber, shardTotal: $shardTotal, maxShowAge: $maxShowAge, maxRecentAge: $maxRecentAge, pageUpdatePeriod: $pageUpdatePeriod, targetRowHeight: $targetRowHeight)';
}


}

/// @nodoc
abstract mixin class $QueueSettingsStateCopyWith<$Res>  {
  factory $QueueSettingsStateCopyWith(QueueSettingsState value, $Res Function(QueueSettingsState) _then) = _$QueueSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool isTopScreen, int topOrdersCount, int shardNumber, int shardTotal, Duration maxShowAge, Duration maxRecentAge, Duration pageUpdatePeriod, double targetRowHeight
});




}
/// @nodoc
class _$QueueSettingsStateCopyWithImpl<$Res>
    implements $QueueSettingsStateCopyWith<$Res> {
  _$QueueSettingsStateCopyWithImpl(this._self, this._then);

  final QueueSettingsState _self;
  final $Res Function(QueueSettingsState) _then;

/// Create a copy of QueueSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isTopScreen = null,Object? topOrdersCount = null,Object? shardNumber = null,Object? shardTotal = null,Object? maxShowAge = null,Object? maxRecentAge = null,Object? pageUpdatePeriod = null,Object? targetRowHeight = null,}) {
  return _then(_self.copyWith(
isTopScreen: null == isTopScreen ? _self.isTopScreen : isTopScreen // ignore: cast_nullable_to_non_nullable
as bool,topOrdersCount: null == topOrdersCount ? _self.topOrdersCount : topOrdersCount // ignore: cast_nullable_to_non_nullable
as int,shardNumber: null == shardNumber ? _self.shardNumber : shardNumber // ignore: cast_nullable_to_non_nullable
as int,shardTotal: null == shardTotal ? _self.shardTotal : shardTotal // ignore: cast_nullable_to_non_nullable
as int,maxShowAge: null == maxShowAge ? _self.maxShowAge : maxShowAge // ignore: cast_nullable_to_non_nullable
as Duration,maxRecentAge: null == maxRecentAge ? _self.maxRecentAge : maxRecentAge // ignore: cast_nullable_to_non_nullable
as Duration,pageUpdatePeriod: null == pageUpdatePeriod ? _self.pageUpdatePeriod : pageUpdatePeriod // ignore: cast_nullable_to_non_nullable
as Duration,targetRowHeight: null == targetRowHeight ? _self.targetRowHeight : targetRowHeight // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [QueueSettingsState].
extension QueueSettingsStatePatterns on QueueSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueSettingsState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _QueueSettingsState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _QueueSettingsState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isTopScreen,  int topOrdersCount,  int shardNumber,  int shardTotal,  Duration maxShowAge,  Duration maxRecentAge,  Duration pageUpdatePeriod,  double targetRowHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueSettingsState() when $default != null:
return $default(_that.isTopScreen,_that.topOrdersCount,_that.shardNumber,_that.shardTotal,_that.maxShowAge,_that.maxRecentAge,_that.pageUpdatePeriod,_that.targetRowHeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isTopScreen,  int topOrdersCount,  int shardNumber,  int shardTotal,  Duration maxShowAge,  Duration maxRecentAge,  Duration pageUpdatePeriod,  double targetRowHeight)  $default,) {final _that = this;
switch (_that) {
case _QueueSettingsState():
return $default(_that.isTopScreen,_that.topOrdersCount,_that.shardNumber,_that.shardTotal,_that.maxShowAge,_that.maxRecentAge,_that.pageUpdatePeriod,_that.targetRowHeight);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isTopScreen,  int topOrdersCount,  int shardNumber,  int shardTotal,  Duration maxShowAge,  Duration maxRecentAge,  Duration pageUpdatePeriod,  double targetRowHeight)?  $default,) {final _that = this;
switch (_that) {
case _QueueSettingsState() when $default != null:
return $default(_that.isTopScreen,_that.topOrdersCount,_that.shardNumber,_that.shardTotal,_that.maxShowAge,_that.maxRecentAge,_that.pageUpdatePeriod,_that.targetRowHeight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueueSettingsState extends QueueSettingsState {
  const _QueueSettingsState({this.isTopScreen = false, this.topOrdersCount = 0, this.shardNumber = 1, this.shardTotal = 1, this.maxShowAge = const Duration(minutes: 15), this.maxRecentAge = const Duration(minutes: 5), this.pageUpdatePeriod = const Duration(seconds: 5), this.targetRowHeight = 100}): super._();
  factory _QueueSettingsState.fromJson(Map<String, dynamic> json) => _$QueueSettingsStateFromJson(json);

/// If set to `true`, this screen will only show the first page and will
/// never paginate.
///
/// If set to `false`, this screen works normally except it ignores
/// the first [topOrdersCount] of orders.
@override@JsonKey() final  bool isTopScreen;
/// Asks the screen to ignore the first N orders (because, presumably,
/// they are shown on the top screen (see [isTopScreen]).
@override@JsonKey() final  int topOrdersCount;
/// The shard number of this device.
@override@JsonKey() final  int shardNumber;
/// The total number of shards in play.
@override@JsonKey() final  int shardTotal;
/// The maximum age of a completed order, after which the order will not
/// be shown anymore.
@override@JsonKey() final  Duration maxShowAge;
/// The duration for which an order is considered "recent". The UI may
/// choose to highlight such orders.
@override@JsonKey() final  Duration maxRecentAge;
/// The duration between updates of the UI.
@override@JsonKey() final  Duration pageUpdatePeriod;
/// A scaling factor for order rows. Can be customized in order to achieve
/// more or less dense displays (for example, when the display is farther
/// away from the customers than expected).
@override@JsonKey() final  double targetRowHeight;

/// Create a copy of QueueSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueSettingsStateCopyWith<_QueueSettingsState> get copyWith => __$QueueSettingsStateCopyWithImpl<_QueueSettingsState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueueSettingsStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueSettingsState&&(identical(other.isTopScreen, isTopScreen) || other.isTopScreen == isTopScreen)&&(identical(other.topOrdersCount, topOrdersCount) || other.topOrdersCount == topOrdersCount)&&(identical(other.shardNumber, shardNumber) || other.shardNumber == shardNumber)&&(identical(other.shardTotal, shardTotal) || other.shardTotal == shardTotal)&&(identical(other.maxShowAge, maxShowAge) || other.maxShowAge == maxShowAge)&&(identical(other.maxRecentAge, maxRecentAge) || other.maxRecentAge == maxRecentAge)&&(identical(other.pageUpdatePeriod, pageUpdatePeriod) || other.pageUpdatePeriod == pageUpdatePeriod)&&(identical(other.targetRowHeight, targetRowHeight) || other.targetRowHeight == targetRowHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isTopScreen,topOrdersCount,shardNumber,shardTotal,maxShowAge,maxRecentAge,pageUpdatePeriod,targetRowHeight);

@override
String toString() {
  return 'QueueSettingsState(isTopScreen: $isTopScreen, topOrdersCount: $topOrdersCount, shardNumber: $shardNumber, shardTotal: $shardTotal, maxShowAge: $maxShowAge, maxRecentAge: $maxRecentAge, pageUpdatePeriod: $pageUpdatePeriod, targetRowHeight: $targetRowHeight)';
}


}

/// @nodoc
abstract mixin class _$QueueSettingsStateCopyWith<$Res> implements $QueueSettingsStateCopyWith<$Res> {
  factory _$QueueSettingsStateCopyWith(_QueueSettingsState value, $Res Function(_QueueSettingsState) _then) = __$QueueSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isTopScreen, int topOrdersCount, int shardNumber, int shardTotal, Duration maxShowAge, Duration maxRecentAge, Duration pageUpdatePeriod, double targetRowHeight
});




}
/// @nodoc
class __$QueueSettingsStateCopyWithImpl<$Res>
    implements _$QueueSettingsStateCopyWith<$Res> {
  __$QueueSettingsStateCopyWithImpl(this._self, this._then);

  final _QueueSettingsState _self;
  final $Res Function(_QueueSettingsState) _then;

/// Create a copy of QueueSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isTopScreen = null,Object? topOrdersCount = null,Object? shardNumber = null,Object? shardTotal = null,Object? maxShowAge = null,Object? maxRecentAge = null,Object? pageUpdatePeriod = null,Object? targetRowHeight = null,}) {
  return _then(_QueueSettingsState(
isTopScreen: null == isTopScreen ? _self.isTopScreen : isTopScreen // ignore: cast_nullable_to_non_nullable
as bool,topOrdersCount: null == topOrdersCount ? _self.topOrdersCount : topOrdersCount // ignore: cast_nullable_to_non_nullable
as int,shardNumber: null == shardNumber ? _self.shardNumber : shardNumber // ignore: cast_nullable_to_non_nullable
as int,shardTotal: null == shardTotal ? _self.shardTotal : shardTotal // ignore: cast_nullable_to_non_nullable
as int,maxShowAge: null == maxShowAge ? _self.maxShowAge : maxShowAge // ignore: cast_nullable_to_non_nullable
as Duration,maxRecentAge: null == maxRecentAge ? _self.maxRecentAge : maxRecentAge // ignore: cast_nullable_to_non_nullable
as Duration,pageUpdatePeriod: null == pageUpdatePeriod ? _self.pageUpdatePeriod : pageUpdatePeriod // ignore: cast_nullable_to_non_nullable
as Duration,targetRowHeight: null == targetRowHeight ? _self.targetRowHeight : targetRowHeight // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
