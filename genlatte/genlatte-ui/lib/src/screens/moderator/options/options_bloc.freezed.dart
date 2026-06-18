// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'options_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OptionsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OptionsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OptionsEvent()';
}


}

/// @nodoc
class $OptionsEventCopyWith<$Res>  {
$OptionsEventCopyWith(OptionsEvent _, $Res Function(OptionsEvent) __);
}


/// Adds pattern-matching-related methods to [OptionsEvent].
extension OptionsEventPatterns on OptionsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NewOptions value)?  newOptions,TResult Function( CreateOption value)?  createOption,TResult Function( ToggleOptionStatus value)?  toggleOptionStatus,TResult Function( DeleteOption value)?  deleteOption,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NewOptions() when newOptions != null:
return newOptions(_that);case CreateOption() when createOption != null:
return createOption(_that);case ToggleOptionStatus() when toggleOptionStatus != null:
return toggleOptionStatus(_that);case DeleteOption() when deleteOption != null:
return deleteOption(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NewOptions value)  newOptions,required TResult Function( CreateOption value)  createOption,required TResult Function( ToggleOptionStatus value)  toggleOptionStatus,required TResult Function( DeleteOption value)  deleteOption,}){
final _that = this;
switch (_that) {
case NewOptions():
return newOptions(_that);case CreateOption():
return createOption(_that);case ToggleOptionStatus():
return toggleOptionStatus(_that);case DeleteOption():
return deleteOption(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NewOptions value)?  newOptions,TResult? Function( CreateOption value)?  createOption,TResult? Function( ToggleOptionStatus value)?  toggleOptionStatus,TResult? Function( DeleteOption value)?  deleteOption,}){
final _that = this;
switch (_that) {
case NewOptions() when newOptions != null:
return newOptions(_that);case CreateOption() when createOption != null:
return createOption(_that);case ToggleOptionStatus() when toggleOptionStatus != null:
return toggleOptionStatus(_that);case DeleteOption() when deleteOption != null:
return deleteOption(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<LatteOptions> options)?  newOptions,TResult Function( LatteOptions parent,  String name)?  createOption,TResult Function( LatteOptions parent,  LatteOption option)?  toggleOptionStatus,TResult Function( LatteOptions parent,  LatteOption option)?  deleteOption,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NewOptions() when newOptions != null:
return newOptions(_that.options);case CreateOption() when createOption != null:
return createOption(_that.parent,_that.name);case ToggleOptionStatus() when toggleOptionStatus != null:
return toggleOptionStatus(_that.parent,_that.option);case DeleteOption() when deleteOption != null:
return deleteOption(_that.parent,_that.option);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<LatteOptions> options)  newOptions,required TResult Function( LatteOptions parent,  String name)  createOption,required TResult Function( LatteOptions parent,  LatteOption option)  toggleOptionStatus,required TResult Function( LatteOptions parent,  LatteOption option)  deleteOption,}) {final _that = this;
switch (_that) {
case NewOptions():
return newOptions(_that.options);case CreateOption():
return createOption(_that.parent,_that.name);case ToggleOptionStatus():
return toggleOptionStatus(_that.parent,_that.option);case DeleteOption():
return deleteOption(_that.parent,_that.option);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<LatteOptions> options)?  newOptions,TResult? Function( LatteOptions parent,  String name)?  createOption,TResult? Function( LatteOptions parent,  LatteOption option)?  toggleOptionStatus,TResult? Function( LatteOptions parent,  LatteOption option)?  deleteOption,}) {final _that = this;
switch (_that) {
case NewOptions() when newOptions != null:
return newOptions(_that.options);case CreateOption() when createOption != null:
return createOption(_that.parent,_that.name);case ToggleOptionStatus() when toggleOptionStatus != null:
return toggleOptionStatus(_that.parent,_that.option);case DeleteOption() when deleteOption != null:
return deleteOption(_that.parent,_that.option);case _:
  return null;

}
}

}

/// @nodoc


class NewOptions implements OptionsEvent {
  const NewOptions(final  List<LatteOptions> options): _options = options;
  

 final  List<LatteOptions> _options;
 List<LatteOptions> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewOptionsCopyWith<NewOptions> get copyWith => _$NewOptionsCopyWithImpl<NewOptions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewOptions&&const DeepCollectionEquality().equals(other._options, _options));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'OptionsEvent.newOptions(options: $options)';
}


}

/// @nodoc
abstract mixin class $NewOptionsCopyWith<$Res> implements $OptionsEventCopyWith<$Res> {
  factory $NewOptionsCopyWith(NewOptions value, $Res Function(NewOptions) _then) = _$NewOptionsCopyWithImpl;
@useResult
$Res call({
 List<LatteOptions> options
});




}
/// @nodoc
class _$NewOptionsCopyWithImpl<$Res>
    implements $NewOptionsCopyWith<$Res> {
  _$NewOptionsCopyWithImpl(this._self, this._then);

  final NewOptions _self;
  final $Res Function(NewOptions) _then;

/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? options = null,}) {
  return _then(NewOptions(
null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<LatteOptions>,
  ));
}


}

/// @nodoc


class CreateOption implements OptionsEvent {
  const CreateOption(this.parent, this.name);
  

 final  LatteOptions parent;
 final  String name;

/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateOptionCopyWith<CreateOption> get copyWith => _$CreateOptionCopyWithImpl<CreateOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateOption&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,parent,name);

@override
String toString() {
  return 'OptionsEvent.createOption(parent: $parent, name: $name)';
}


}

/// @nodoc
abstract mixin class $CreateOptionCopyWith<$Res> implements $OptionsEventCopyWith<$Res> {
  factory $CreateOptionCopyWith(CreateOption value, $Res Function(CreateOption) _then) = _$CreateOptionCopyWithImpl;
@useResult
$Res call({
 LatteOptions parent, String name
});


$LatteOptionsCopyWith<$Res> get parent;

}
/// @nodoc
class _$CreateOptionCopyWithImpl<$Res>
    implements $CreateOptionCopyWith<$Res> {
  _$CreateOptionCopyWithImpl(this._self, this._then);

  final CreateOption _self;
  final $Res Function(CreateOption) _then;

/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? parent = null,Object? name = null,}) {
  return _then(CreateOption(
null == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as LatteOptions,null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOptionsCopyWith<$Res> get parent {
  
  return $LatteOptionsCopyWith<$Res>(_self.parent, (value) {
    return _then(_self.copyWith(parent: value));
  });
}
}

/// @nodoc


class ToggleOptionStatus implements OptionsEvent {
  const ToggleOptionStatus(this.parent, this.option);
  

 final  LatteOptions parent;
 final  LatteOption option;

/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleOptionStatusCopyWith<ToggleOptionStatus> get copyWith => _$ToggleOptionStatusCopyWithImpl<ToggleOptionStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleOptionStatus&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.option, option) || other.option == option));
}


@override
int get hashCode => Object.hash(runtimeType,parent,option);

@override
String toString() {
  return 'OptionsEvent.toggleOptionStatus(parent: $parent, option: $option)';
}


}

/// @nodoc
abstract mixin class $ToggleOptionStatusCopyWith<$Res> implements $OptionsEventCopyWith<$Res> {
  factory $ToggleOptionStatusCopyWith(ToggleOptionStatus value, $Res Function(ToggleOptionStatus) _then) = _$ToggleOptionStatusCopyWithImpl;
@useResult
$Res call({
 LatteOptions parent, LatteOption option
});


$LatteOptionsCopyWith<$Res> get parent;$LatteOptionCopyWith<$Res> get option;

}
/// @nodoc
class _$ToggleOptionStatusCopyWithImpl<$Res>
    implements $ToggleOptionStatusCopyWith<$Res> {
  _$ToggleOptionStatusCopyWithImpl(this._self, this._then);

  final ToggleOptionStatus _self;
  final $Res Function(ToggleOptionStatus) _then;

/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? parent = null,Object? option = null,}) {
  return _then(ToggleOptionStatus(
null == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as LatteOptions,null == option ? _self.option : option // ignore: cast_nullable_to_non_nullable
as LatteOption,
  ));
}

/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOptionsCopyWith<$Res> get parent {
  
  return $LatteOptionsCopyWith<$Res>(_self.parent, (value) {
    return _then(_self.copyWith(parent: value));
  });
}/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOptionCopyWith<$Res> get option {
  
  return $LatteOptionCopyWith<$Res>(_self.option, (value) {
    return _then(_self.copyWith(option: value));
  });
}
}

/// @nodoc


class DeleteOption implements OptionsEvent {
  const DeleteOption(this.parent, this.option);
  

 final  LatteOptions parent;
 final  LatteOption option;

/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteOptionCopyWith<DeleteOption> get copyWith => _$DeleteOptionCopyWithImpl<DeleteOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteOption&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.option, option) || other.option == option));
}


@override
int get hashCode => Object.hash(runtimeType,parent,option);

@override
String toString() {
  return 'OptionsEvent.deleteOption(parent: $parent, option: $option)';
}


}

/// @nodoc
abstract mixin class $DeleteOptionCopyWith<$Res> implements $OptionsEventCopyWith<$Res> {
  factory $DeleteOptionCopyWith(DeleteOption value, $Res Function(DeleteOption) _then) = _$DeleteOptionCopyWithImpl;
@useResult
$Res call({
 LatteOptions parent, LatteOption option
});


$LatteOptionsCopyWith<$Res> get parent;$LatteOptionCopyWith<$Res> get option;

}
/// @nodoc
class _$DeleteOptionCopyWithImpl<$Res>
    implements $DeleteOptionCopyWith<$Res> {
  _$DeleteOptionCopyWithImpl(this._self, this._then);

  final DeleteOption _self;
  final $Res Function(DeleteOption) _then;

/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? parent = null,Object? option = null,}) {
  return _then(DeleteOption(
null == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as LatteOptions,null == option ? _self.option : option // ignore: cast_nullable_to_non_nullable
as LatteOption,
  ));
}

/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOptionsCopyWith<$Res> get parent {
  
  return $LatteOptionsCopyWith<$Res>(_self.parent, (value) {
    return _then(_self.copyWith(parent: value));
  });
}/// Create a copy of OptionsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOptionCopyWith<$Res> get option {
  
  return $LatteOptionCopyWith<$Res>(_self.option, (value) {
    return _then(_self.copyWith(option: value));
  });
}
}

/// @nodoc
mixin _$OptionsState {

/// All options available on the server.
 List<LatteOptions> get options;
/// Create a copy of OptionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OptionsStateCopyWith<OptionsState> get copyWith => _$OptionsStateCopyWithImpl<OptionsState>(this as OptionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OptionsState&&const DeepCollectionEquality().equals(other.options, options));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'OptionsState(options: $options)';
}


}

/// @nodoc
abstract mixin class $OptionsStateCopyWith<$Res>  {
  factory $OptionsStateCopyWith(OptionsState value, $Res Function(OptionsState) _then) = _$OptionsStateCopyWithImpl;
@useResult
$Res call({
 List<LatteOptions> options
});




}
/// @nodoc
class _$OptionsStateCopyWithImpl<$Res>
    implements $OptionsStateCopyWith<$Res> {
  _$OptionsStateCopyWithImpl(this._self, this._then);

  final OptionsState _self;
  final $Res Function(OptionsState) _then;

/// Create a copy of OptionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? options = null,}) {
  return _then(_self.copyWith(
options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<LatteOptions>,
  ));
}

}


/// Adds pattern-matching-related methods to [OptionsState].
extension OptionsStatePatterns on OptionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OptionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OptionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OptionsState value)  $default,){
final _that = this;
switch (_that) {
case _OptionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OptionsState value)?  $default,){
final _that = this;
switch (_that) {
case _OptionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LatteOptions> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OptionsState() when $default != null:
return $default(_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LatteOptions> options)  $default,) {final _that = this;
switch (_that) {
case _OptionsState():
return $default(_that.options);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LatteOptions> options)?  $default,) {final _that = this;
switch (_that) {
case _OptionsState() when $default != null:
return $default(_that.options);case _:
  return null;

}
}

}

/// @nodoc


class _OptionsState extends OptionsState {
  const _OptionsState({final  List<LatteOptions> options = const []}): _options = options,super._();
  

/// All options available on the server.
 final  List<LatteOptions> _options;
/// All options available on the server.
@override@JsonKey() List<LatteOptions> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of OptionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OptionsStateCopyWith<_OptionsState> get copyWith => __$OptionsStateCopyWithImpl<_OptionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OptionsState&&const DeepCollectionEquality().equals(other._options, _options));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'OptionsState(options: $options)';
}


}

/// @nodoc
abstract mixin class _$OptionsStateCopyWith<$Res> implements $OptionsStateCopyWith<$Res> {
  factory _$OptionsStateCopyWith(_OptionsState value, $Res Function(_OptionsState) _then) = __$OptionsStateCopyWithImpl;
@override @useResult
$Res call({
 List<LatteOptions> options
});




}
/// @nodoc
class __$OptionsStateCopyWithImpl<$Res>
    implements _$OptionsStateCopyWith<$Res> {
  __$OptionsStateCopyWithImpl(this._self, this._then);

  final _OptionsState _self;
  final $Res Function(_OptionsState) _then;

/// Create a copy of OptionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? options = null,}) {
  return _then(_OptionsState(
options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<LatteOptions>,
  ));
}


}

// dart format on
