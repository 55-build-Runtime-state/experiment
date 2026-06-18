// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latte_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AbsoluteLattePosition {

/// Unique identifier to track collision pairs.
 String get id;/// The center of the latte image.
 Offset get center;/// The angle of this Latte's movement in radians.
 double get direction;/// The radius of the latte image as a percentage of the most constraine
/// dimension of the available space. A value of 1.0 would indicate a latte
/// that fills the entire available space.
 double get radius;/// The angle of the squish effect.
 double? get squishAngle;/// The speed of this latte's movement.
 double get speed;/// The last time this latte was involved in a collision.
 DateTime? get lastCollisionAt;/// The ID of the last object this collided with.
 String? get lastCollidedWith;
/// Create a copy of AbsoluteLattePosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbsoluteLattePositionCopyWith<AbsoluteLattePosition> get copyWith => _$AbsoluteLattePositionCopyWithImpl<AbsoluteLattePosition>(this as AbsoluteLattePosition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbsoluteLattePosition&&(identical(other.id, id) || other.id == id)&&(identical(other.center, center) || other.center == center)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.squishAngle, squishAngle) || other.squishAngle == squishAngle)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.lastCollisionAt, lastCollisionAt) || other.lastCollisionAt == lastCollisionAt)&&(identical(other.lastCollidedWith, lastCollidedWith) || other.lastCollidedWith == lastCollidedWith));
}


@override
int get hashCode => Object.hash(runtimeType,id,center,direction,radius,squishAngle,speed,lastCollisionAt,lastCollidedWith);

@override
String toString() {
  return 'AbsoluteLattePosition(id: $id, center: $center, direction: $direction, radius: $radius, squishAngle: $squishAngle, speed: $speed, lastCollisionAt: $lastCollisionAt, lastCollidedWith: $lastCollidedWith)';
}


}

/// @nodoc
abstract mixin class $AbsoluteLattePositionCopyWith<$Res>  {
  factory $AbsoluteLattePositionCopyWith(AbsoluteLattePosition value, $Res Function(AbsoluteLattePosition) _then) = _$AbsoluteLattePositionCopyWithImpl;
@useResult
$Res call({
 String id, Offset center, double direction, double radius, double? squishAngle, double speed, DateTime? lastCollisionAt, String? lastCollidedWith
});




}
/// @nodoc
class _$AbsoluteLattePositionCopyWithImpl<$Res>
    implements $AbsoluteLattePositionCopyWith<$Res> {
  _$AbsoluteLattePositionCopyWithImpl(this._self, this._then);

  final AbsoluteLattePosition _self;
  final $Res Function(AbsoluteLattePosition) _then;

/// Create a copy of AbsoluteLattePosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? center = null,Object? direction = null,Object? radius = null,Object? squishAngle = freezed,Object? speed = null,Object? lastCollisionAt = freezed,Object? lastCollidedWith = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Offset,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,squishAngle: freezed == squishAngle ? _self.squishAngle : squishAngle // ignore: cast_nullable_to_non_nullable
as double?,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,lastCollisionAt: freezed == lastCollisionAt ? _self.lastCollisionAt : lastCollisionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastCollidedWith: freezed == lastCollidedWith ? _self.lastCollidedWith : lastCollidedWith // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AbsoluteLattePosition].
extension AbsoluteLattePositionPatterns on AbsoluteLattePosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AbsoluteLattePosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AbsoluteLattePosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AbsoluteLattePosition value)  $default,){
final _that = this;
switch (_that) {
case _AbsoluteLattePosition():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AbsoluteLattePosition value)?  $default,){
final _that = this;
switch (_that) {
case _AbsoluteLattePosition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Offset center,  double direction,  double radius,  double? squishAngle,  double speed,  DateTime? lastCollisionAt,  String? lastCollidedWith)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AbsoluteLattePosition() when $default != null:
return $default(_that.id,_that.center,_that.direction,_that.radius,_that.squishAngle,_that.speed,_that.lastCollisionAt,_that.lastCollidedWith);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Offset center,  double direction,  double radius,  double? squishAngle,  double speed,  DateTime? lastCollisionAt,  String? lastCollidedWith)  $default,) {final _that = this;
switch (_that) {
case _AbsoluteLattePosition():
return $default(_that.id,_that.center,_that.direction,_that.radius,_that.squishAngle,_that.speed,_that.lastCollisionAt,_that.lastCollidedWith);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Offset center,  double direction,  double radius,  double? squishAngle,  double speed,  DateTime? lastCollisionAt,  String? lastCollidedWith)?  $default,) {final _that = this;
switch (_that) {
case _AbsoluteLattePosition() when $default != null:
return $default(_that.id,_that.center,_that.direction,_that.radius,_that.squishAngle,_that.speed,_that.lastCollisionAt,_that.lastCollidedWith);case _:
  return null;

}
}

}

/// @nodoc


class _AbsoluteLattePosition extends AbsoluteLattePosition {
  const _AbsoluteLattePosition({required this.id, required this.center, required this.direction, required this.radius, required this.squishAngle, required this.speed, this.lastCollisionAt, this.lastCollidedWith}): super._();
  

/// Unique identifier to track collision pairs.
@override final  String id;
/// The center of the latte image.
@override final  Offset center;
/// The angle of this Latte's movement in radians.
@override final  double direction;
/// The radius of the latte image as a percentage of the most constraine
/// dimension of the available space. A value of 1.0 would indicate a latte
/// that fills the entire available space.
@override final  double radius;
/// The angle of the squish effect.
@override final  double? squishAngle;
/// The speed of this latte's movement.
@override final  double speed;
/// The last time this latte was involved in a collision.
@override final  DateTime? lastCollisionAt;
/// The ID of the last object this collided with.
@override final  String? lastCollidedWith;

/// Create a copy of AbsoluteLattePosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AbsoluteLattePositionCopyWith<_AbsoluteLattePosition> get copyWith => __$AbsoluteLattePositionCopyWithImpl<_AbsoluteLattePosition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AbsoluteLattePosition&&(identical(other.id, id) || other.id == id)&&(identical(other.center, center) || other.center == center)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.squishAngle, squishAngle) || other.squishAngle == squishAngle)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.lastCollisionAt, lastCollisionAt) || other.lastCollisionAt == lastCollisionAt)&&(identical(other.lastCollidedWith, lastCollidedWith) || other.lastCollidedWith == lastCollidedWith));
}


@override
int get hashCode => Object.hash(runtimeType,id,center,direction,radius,squishAngle,speed,lastCollisionAt,lastCollidedWith);

@override
String toString() {
  return 'AbsoluteLattePosition(id: $id, center: $center, direction: $direction, radius: $radius, squishAngle: $squishAngle, speed: $speed, lastCollisionAt: $lastCollisionAt, lastCollidedWith: $lastCollidedWith)';
}


}

/// @nodoc
abstract mixin class _$AbsoluteLattePositionCopyWith<$Res> implements $AbsoluteLattePositionCopyWith<$Res> {
  factory _$AbsoluteLattePositionCopyWith(_AbsoluteLattePosition value, $Res Function(_AbsoluteLattePosition) _then) = __$AbsoluteLattePositionCopyWithImpl;
@override @useResult
$Res call({
 String id, Offset center, double direction, double radius, double? squishAngle, double speed, DateTime? lastCollisionAt, String? lastCollidedWith
});




}
/// @nodoc
class __$AbsoluteLattePositionCopyWithImpl<$Res>
    implements _$AbsoluteLattePositionCopyWith<$Res> {
  __$AbsoluteLattePositionCopyWithImpl(this._self, this._then);

  final _AbsoluteLattePosition _self;
  final $Res Function(_AbsoluteLattePosition) _then;

/// Create a copy of AbsoluteLattePosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? center = null,Object? direction = null,Object? radius = null,Object? squishAngle = freezed,Object? speed = null,Object? lastCollisionAt = freezed,Object? lastCollidedWith = freezed,}) {
  return _then(_AbsoluteLattePosition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Offset,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,squishAngle: freezed == squishAngle ? _self.squishAngle : squishAngle // ignore: cast_nullable_to_non_nullable
as double?,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,lastCollisionAt: freezed == lastCollisionAt ? _self.lastCollisionAt : lastCollisionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastCollidedWith: freezed == lastCollidedWith ? _self.lastCollidedWith : lastCollidedWith // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$LattePosition {

/// Unique identifier to track collision pairs.
 String get id;/// The center of the latte image.
 Offset get center;/// The angle of this Latte's movement in radians.
 double get direction;/// Size of the latte image as a percentage of the most constrained
/// dimension of the available space. A value of 1.0 would indicate a latte.
 double get radius;/// The angle of the squish effect.
 double? get squishAngle;/// The raw speed as calculated off of the last collision. If this is
/// greater than [defaultSpeed], then friction will slow the latte down
/// until it returns to [defaultSpeed]
 double get rawSpeed;/// The last time this latte was involved in a collision. This is used to
/// calculate friction to slow down a circle's velocity.
 DateTime? get lastCollisionAt;/// The ID of the last object this collided with to prevent rapid duplicate
/// collisions.
 String? get lastCollidedWith;
/// Create a copy of LattePosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LattePositionCopyWith<LattePosition> get copyWith => _$LattePositionCopyWithImpl<LattePosition>(this as LattePosition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LattePosition&&(identical(other.id, id) || other.id == id)&&(identical(other.center, center) || other.center == center)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.squishAngle, squishAngle) || other.squishAngle == squishAngle)&&(identical(other.rawSpeed, rawSpeed) || other.rawSpeed == rawSpeed)&&(identical(other.lastCollisionAt, lastCollisionAt) || other.lastCollisionAt == lastCollisionAt)&&(identical(other.lastCollidedWith, lastCollidedWith) || other.lastCollidedWith == lastCollidedWith));
}


@override
int get hashCode => Object.hash(runtimeType,id,center,direction,radius,squishAngle,rawSpeed,lastCollisionAt,lastCollidedWith);

@override
String toString() {
  return 'LattePosition(id: $id, center: $center, direction: $direction, radius: $radius, squishAngle: $squishAngle, rawSpeed: $rawSpeed, lastCollisionAt: $lastCollisionAt, lastCollidedWith: $lastCollidedWith)';
}


}

/// @nodoc
abstract mixin class $LattePositionCopyWith<$Res>  {
  factory $LattePositionCopyWith(LattePosition value, $Res Function(LattePosition) _then) = _$LattePositionCopyWithImpl;
@useResult
$Res call({
 String id, Offset center, double direction, double radius, double? squishAngle, double rawSpeed, DateTime? lastCollisionAt, String? lastCollidedWith
});




}
/// @nodoc
class _$LattePositionCopyWithImpl<$Res>
    implements $LattePositionCopyWith<$Res> {
  _$LattePositionCopyWithImpl(this._self, this._then);

  final LattePosition _self;
  final $Res Function(LattePosition) _then;

/// Create a copy of LattePosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? center = null,Object? direction = null,Object? radius = null,Object? squishAngle = freezed,Object? rawSpeed = null,Object? lastCollisionAt = freezed,Object? lastCollidedWith = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Offset,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,squishAngle: freezed == squishAngle ? _self.squishAngle : squishAngle // ignore: cast_nullable_to_non_nullable
as double?,rawSpeed: null == rawSpeed ? _self.rawSpeed : rawSpeed // ignore: cast_nullable_to_non_nullable
as double,lastCollisionAt: freezed == lastCollisionAt ? _self.lastCollisionAt : lastCollisionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastCollidedWith: freezed == lastCollidedWith ? _self.lastCollidedWith : lastCollidedWith // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LattePosition].
extension LattePositionPatterns on LattePosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LattePosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LattePosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LattePosition value)  $default,){
final _that = this;
switch (_that) {
case _LattePosition():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LattePosition value)?  $default,){
final _that = this;
switch (_that) {
case _LattePosition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Offset center,  double direction,  double radius,  double? squishAngle,  double rawSpeed,  DateTime? lastCollisionAt,  String? lastCollidedWith)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LattePosition() when $default != null:
return $default(_that.id,_that.center,_that.direction,_that.radius,_that.squishAngle,_that.rawSpeed,_that.lastCollisionAt,_that.lastCollidedWith);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Offset center,  double direction,  double radius,  double? squishAngle,  double rawSpeed,  DateTime? lastCollisionAt,  String? lastCollidedWith)  $default,) {final _that = this;
switch (_that) {
case _LattePosition():
return $default(_that.id,_that.center,_that.direction,_that.radius,_that.squishAngle,_that.rawSpeed,_that.lastCollisionAt,_that.lastCollidedWith);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Offset center,  double direction,  double radius,  double? squishAngle,  double rawSpeed,  DateTime? lastCollisionAt,  String? lastCollidedWith)?  $default,) {final _that = this;
switch (_that) {
case _LattePosition() when $default != null:
return $default(_that.id,_that.center,_that.direction,_that.radius,_that.squishAngle,_that.rawSpeed,_that.lastCollisionAt,_that.lastCollidedWith);case _:
  return null;

}
}

}

/// @nodoc


class _LattePosition extends LattePosition {
  const _LattePosition({required this.id, required this.center, required this.direction, required this.radius, required this.squishAngle, this.rawSpeed = LattePosition.defaultSpeed, this.lastCollisionAt, this.lastCollidedWith}): super._();
  

/// Unique identifier to track collision pairs.
@override final  String id;
/// The center of the latte image.
@override final  Offset center;
/// The angle of this Latte's movement in radians.
@override final  double direction;
/// Size of the latte image as a percentage of the most constrained
/// dimension of the available space. A value of 1.0 would indicate a latte.
@override final  double radius;
/// The angle of the squish effect.
@override final  double? squishAngle;
/// The raw speed as calculated off of the last collision. If this is
/// greater than [defaultSpeed], then friction will slow the latte down
/// until it returns to [defaultSpeed]
@override@JsonKey() final  double rawSpeed;
/// The last time this latte was involved in a collision. This is used to
/// calculate friction to slow down a circle's velocity.
@override final  DateTime? lastCollisionAt;
/// The ID of the last object this collided with to prevent rapid duplicate
/// collisions.
@override final  String? lastCollidedWith;

/// Create a copy of LattePosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LattePositionCopyWith<_LattePosition> get copyWith => __$LattePositionCopyWithImpl<_LattePosition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LattePosition&&(identical(other.id, id) || other.id == id)&&(identical(other.center, center) || other.center == center)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.squishAngle, squishAngle) || other.squishAngle == squishAngle)&&(identical(other.rawSpeed, rawSpeed) || other.rawSpeed == rawSpeed)&&(identical(other.lastCollisionAt, lastCollisionAt) || other.lastCollisionAt == lastCollisionAt)&&(identical(other.lastCollidedWith, lastCollidedWith) || other.lastCollidedWith == lastCollidedWith));
}


@override
int get hashCode => Object.hash(runtimeType,id,center,direction,radius,squishAngle,rawSpeed,lastCollisionAt,lastCollidedWith);

@override
String toString() {
  return 'LattePosition(id: $id, center: $center, direction: $direction, radius: $radius, squishAngle: $squishAngle, rawSpeed: $rawSpeed, lastCollisionAt: $lastCollisionAt, lastCollidedWith: $lastCollidedWith)';
}


}

/// @nodoc
abstract mixin class _$LattePositionCopyWith<$Res> implements $LattePositionCopyWith<$Res> {
  factory _$LattePositionCopyWith(_LattePosition value, $Res Function(_LattePosition) _then) = __$LattePositionCopyWithImpl;
@override @useResult
$Res call({
 String id, Offset center, double direction, double radius, double? squishAngle, double rawSpeed, DateTime? lastCollisionAt, String? lastCollidedWith
});




}
/// @nodoc
class __$LattePositionCopyWithImpl<$Res>
    implements _$LattePositionCopyWith<$Res> {
  __$LattePositionCopyWithImpl(this._self, this._then);

  final _LattePosition _self;
  final $Res Function(_LattePosition) _then;

/// Create a copy of LattePosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? center = null,Object? direction = null,Object? radius = null,Object? squishAngle = freezed,Object? rawSpeed = null,Object? lastCollisionAt = freezed,Object? lastCollidedWith = freezed,}) {
  return _then(_LattePosition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Offset,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,squishAngle: freezed == squishAngle ? _self.squishAngle : squishAngle // ignore: cast_nullable_to_non_nullable
as double?,rawSpeed: null == rawSpeed ? _self.rawSpeed : rawSpeed // ignore: cast_nullable_to_non_nullable
as double,lastCollisionAt: freezed == lastCollisionAt ? _self.lastCollisionAt : lastCollisionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastCollidedWith: freezed == lastCollidedWith ? _self.lastCollidedWith : lastCollidedWith // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
