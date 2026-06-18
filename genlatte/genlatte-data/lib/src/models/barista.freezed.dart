// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'barista.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Barista {

 String get username; BaristaPersona get persona; String? get id;
/// Create a copy of Barista
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaristaCopyWith<Barista> get copyWith => _$BaristaCopyWithImpl<Barista>(this as Barista, _$identity);

  /// Serializes this Barista to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Barista&&(identical(other.username, username) || other.username == username)&&(identical(other.persona, persona) || other.persona == persona)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,persona,id);

@override
String toString() {
  return 'Barista(username: $username, persona: $persona, id: $id)';
}


}

/// @nodoc
abstract mixin class $BaristaCopyWith<$Res>  {
  factory $BaristaCopyWith(Barista value, $Res Function(Barista) _then) = _$BaristaCopyWithImpl;
@useResult
$Res call({
 String username, BaristaPersona persona, String? id
});




}
/// @nodoc
class _$BaristaCopyWithImpl<$Res>
    implements $BaristaCopyWith<$Res> {
  _$BaristaCopyWithImpl(this._self, this._then);

  final Barista _self;
  final $Res Function(Barista) _then;

/// Create a copy of Barista
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? persona = null,Object? id = freezed,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,persona: null == persona ? _self.persona : persona // ignore: cast_nullable_to_non_nullable
as BaristaPersona,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Barista].
extension BaristaPatterns on Barista {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Barista value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Barista() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Barista value)  $default,){
final _that = this;
switch (_that) {
case _Barista():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Barista value)?  $default,){
final _that = this;
switch (_that) {
case _Barista() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  BaristaPersona persona,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Barista() when $default != null:
return $default(_that.username,_that.persona,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  BaristaPersona persona,  String? id)  $default,) {final _that = this;
switch (_that) {
case _Barista():
return $default(_that.username,_that.persona,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  BaristaPersona persona,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _Barista() when $default != null:
return $default(_that.username,_that.persona,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Barista implements Barista {
  const _Barista({required this.username, required this.persona, this.id});
  factory _Barista.fromJson(Map<String, dynamic> json) => _$BaristaFromJson(json);

@override final  String username;
@override final  BaristaPersona persona;
@override final  String? id;

/// Create a copy of Barista
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BaristaCopyWith<_Barista> get copyWith => __$BaristaCopyWithImpl<_Barista>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BaristaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Barista&&(identical(other.username, username) || other.username == username)&&(identical(other.persona, persona) || other.persona == persona)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,persona,id);

@override
String toString() {
  return 'Barista(username: $username, persona: $persona, id: $id)';
}


}

/// @nodoc
abstract mixin class _$BaristaCopyWith<$Res> implements $BaristaCopyWith<$Res> {
  factory _$BaristaCopyWith(_Barista value, $Res Function(_Barista) _then) = __$BaristaCopyWithImpl;
@override @useResult
$Res call({
 String username, BaristaPersona persona, String? id
});




}
/// @nodoc
class __$BaristaCopyWithImpl<$Res>
    implements _$BaristaCopyWith<$Res> {
  __$BaristaCopyWithImpl(this._self, this._then);

  final _Barista _self;
  final $Res Function(_Barista) _then;

/// Create a copy of Barista
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? persona = null,Object? id = freezed,}) {
  return _then(_Barista(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,persona: null == persona ? _self.persona : persona // ignore: cast_nullable_to_non_nullable
as BaristaPersona,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
