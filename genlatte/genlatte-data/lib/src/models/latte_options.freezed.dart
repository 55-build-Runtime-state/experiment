// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latte_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LatteOptions {

 String get id;@LatteOptionConverter() List<LatteOption> get values;
/// Create a copy of LatteOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatteOptionsCopyWith<LatteOptions> get copyWith => _$LatteOptionsCopyWithImpl<LatteOptions>(this as LatteOptions, _$identity);

  /// Serializes this LatteOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatteOptions&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.values, values));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(values));

@override
String toString() {
  return 'LatteOptions(id: $id, values: $values)';
}


}

/// @nodoc
abstract mixin class $LatteOptionsCopyWith<$Res>  {
  factory $LatteOptionsCopyWith(LatteOptions value, $Res Function(LatteOptions) _then) = _$LatteOptionsCopyWithImpl;
@useResult
$Res call({
 String id,@LatteOptionConverter() List<LatteOption> values
});




}
/// @nodoc
class _$LatteOptionsCopyWithImpl<$Res>
    implements $LatteOptionsCopyWith<$Res> {
  _$LatteOptionsCopyWithImpl(this._self, this._then);

  final LatteOptions _self;
  final $Res Function(LatteOptions) _then;

/// Create a copy of LatteOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? values = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as List<LatteOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [LatteOptions].
extension LatteOptionsPatterns on LatteOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatteOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatteOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatteOptions value)  $default,){
final _that = this;
switch (_that) {
case _LatteOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatteOptions value)?  $default,){
final _that = this;
switch (_that) {
case _LatteOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @LatteOptionConverter()  List<LatteOption> values)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatteOptions() when $default != null:
return $default(_that.id,_that.values);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @LatteOptionConverter()  List<LatteOption> values)  $default,) {final _that = this;
switch (_that) {
case _LatteOptions():
return $default(_that.id,_that.values);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @LatteOptionConverter()  List<LatteOption> values)?  $default,) {final _that = this;
switch (_that) {
case _LatteOptions() when $default != null:
return $default(_that.id,_that.values);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatteOptions extends LatteOptions {
  const _LatteOptions({required this.id, @LatteOptionConverter() required final  List<LatteOption> values}): _values = values,super._();
  factory _LatteOptions.fromJson(Map<String, dynamic> json) => _$LatteOptionsFromJson(json);

@override final  String id;
 final  List<LatteOption> _values;
@override@LatteOptionConverter() List<LatteOption> get values {
  if (_values is EqualUnmodifiableListView) return _values;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_values);
}


/// Create a copy of LatteOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatteOptionsCopyWith<_LatteOptions> get copyWith => __$LatteOptionsCopyWithImpl<_LatteOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatteOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatteOptions&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._values, _values));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_values));

@override
String toString() {
  return 'LatteOptions(id: $id, values: $values)';
}


}

/// @nodoc
abstract mixin class _$LatteOptionsCopyWith<$Res> implements $LatteOptionsCopyWith<$Res> {
  factory _$LatteOptionsCopyWith(_LatteOptions value, $Res Function(_LatteOptions) _then) = __$LatteOptionsCopyWithImpl;
@override @useResult
$Res call({
 String id,@LatteOptionConverter() List<LatteOption> values
});




}
/// @nodoc
class __$LatteOptionsCopyWithImpl<$Res>
    implements _$LatteOptionsCopyWith<$Res> {
  __$LatteOptionsCopyWithImpl(this._self, this._then);

  final _LatteOptions _self;
  final $Res Function(_LatteOptions) _then;

/// Create a copy of LatteOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? values = null,}) {
  return _then(_LatteOptions(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,values: null == values ? _self._values : values // ignore: cast_nullable_to_non_nullable
as List<LatteOption>,
  ));
}


}


/// @nodoc
mixin _$LatteOption {

 String get name; bool get isAvailable;
/// Create a copy of LatteOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatteOptionCopyWith<LatteOption> get copyWith => _$LatteOptionCopyWithImpl<LatteOption>(this as LatteOption, _$identity);

  /// Serializes this LatteOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatteOption&&(identical(other.name, name) || other.name == name)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,isAvailable);

@override
String toString() {
  return 'LatteOption(name: $name, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $LatteOptionCopyWith<$Res>  {
  factory $LatteOptionCopyWith(LatteOption value, $Res Function(LatteOption) _then) = _$LatteOptionCopyWithImpl;
@useResult
$Res call({
 String name, bool isAvailable
});




}
/// @nodoc
class _$LatteOptionCopyWithImpl<$Res>
    implements $LatteOptionCopyWith<$Res> {
  _$LatteOptionCopyWithImpl(this._self, this._then);

  final LatteOption _self;
  final $Res Function(LatteOption) _then;

/// Create a copy of LatteOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? isAvailable = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LatteOption].
extension LatteOptionPatterns on LatteOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatteOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatteOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatteOption value)  $default,){
final _that = this;
switch (_that) {
case _LatteOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatteOption value)?  $default,){
final _that = this;
switch (_that) {
case _LatteOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  bool isAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatteOption() when $default != null:
return $default(_that.name,_that.isAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  bool isAvailable)  $default,) {final _that = this;
switch (_that) {
case _LatteOption():
return $default(_that.name,_that.isAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  bool isAvailable)?  $default,) {final _that = this;
switch (_that) {
case _LatteOption() when $default != null:
return $default(_that.name,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatteOption extends LatteOption {
  const _LatteOption({required this.name, this.isAvailable = true}): super._();
  factory _LatteOption.fromJson(Map<String, dynamic> json) => _$LatteOptionFromJson(json);

@override final  String name;
@override@JsonKey() final  bool isAvailable;

/// Create a copy of LatteOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatteOptionCopyWith<_LatteOption> get copyWith => __$LatteOptionCopyWithImpl<_LatteOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatteOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatteOption&&(identical(other.name, name) || other.name == name)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,isAvailable);

@override
String toString() {
  return 'LatteOption(name: $name, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$LatteOptionCopyWith<$Res> implements $LatteOptionCopyWith<$Res> {
  factory _$LatteOptionCopyWith(_LatteOption value, $Res Function(_LatteOption) _then) = __$LatteOptionCopyWithImpl;
@override @useResult
$Res call({
 String name, bool isAvailable
});




}
/// @nodoc
class __$LatteOptionCopyWithImpl<$Res>
    implements _$LatteOptionCopyWith<$Res> {
  __$LatteOptionCopyWithImpl(this._self, this._then);

  final _LatteOption _self;
  final $Res Function(_LatteOption) _then;

/// Create a copy of LatteOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? isAvailable = null,}) {
  return _then(_LatteOption(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
