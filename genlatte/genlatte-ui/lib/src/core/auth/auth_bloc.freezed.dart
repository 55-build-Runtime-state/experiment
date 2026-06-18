// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NewUserEvent value)?  newUser,TResult Function( LoggedOutEvent value)?  loggedOut,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NewUserEvent() when newUser != null:
return newUser(_that);case LoggedOutEvent() when loggedOut != null:
return loggedOut(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NewUserEvent value)  newUser,required TResult Function( LoggedOutEvent value)  loggedOut,}){
final _that = this;
switch (_that) {
case NewUserEvent():
return newUser(_that);case LoggedOutEvent():
return loggedOut(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NewUserEvent value)?  newUser,TResult? Function( LoggedOutEvent value)?  loggedOut,}){
final _that = this;
switch (_that) {
case NewUserEvent() when newUser != null:
return newUser(_that);case LoggedOutEvent() when loggedOut != null:
return loggedOut(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( User user,  Role role)?  newUser,TResult Function()?  loggedOut,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NewUserEvent() when newUser != null:
return newUser(_that.user,_that.role);case LoggedOutEvent() when loggedOut != null:
return loggedOut();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( User user,  Role role)  newUser,required TResult Function()  loggedOut,}) {final _that = this;
switch (_that) {
case NewUserEvent():
return newUser(_that.user,_that.role);case LoggedOutEvent():
return loggedOut();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( User user,  Role role)?  newUser,TResult? Function()?  loggedOut,}) {final _that = this;
switch (_that) {
case NewUserEvent() when newUser != null:
return newUser(_that.user,_that.role);case LoggedOutEvent() when loggedOut != null:
return loggedOut();case _:
  return null;

}
}

}

/// @nodoc


class NewUserEvent implements AuthEvent {
  const NewUserEvent(this.user, this.role);
  

 final  User user;
 final  Role role;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewUserEventCopyWith<NewUserEvent> get copyWith => _$NewUserEventCopyWithImpl<NewUserEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewUserEvent&&(identical(other.user, user) || other.user == user)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,user,role);

@override
String toString() {
  return 'AuthEvent.newUser(user: $user, role: $role)';
}


}

/// @nodoc
abstract mixin class $NewUserEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $NewUserEventCopyWith(NewUserEvent value, $Res Function(NewUserEvent) _then) = _$NewUserEventCopyWithImpl;
@useResult
$Res call({
 User user, Role role
});




}
/// @nodoc
class _$NewUserEventCopyWithImpl<$Res>
    implements $NewUserEventCopyWith<$Res> {
  _$NewUserEventCopyWithImpl(this._self, this._then);

  final NewUserEvent _self;
  final $Res Function(NewUserEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,Object? role = null,}) {
  return _then(NewUserEvent(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as Role,
  ));
}


}

/// @nodoc


class LoggedOutEvent implements AuthEvent {
  const LoggedOutEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoggedOutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.loggedOut()';
}


}




/// @nodoc
mixin _$AuthState {

 User? get user; Role? get role;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.user, user) || other.user == user)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,user,role);

@override
String toString() {
  return 'AuthState(user: $user, role: $role)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 User? user, Role? role
});




}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? role = freezed,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as Role?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User? user,  Role? role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.user,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User? user,  Role? role)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.user,_that.role);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User? user,  Role? role)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.user,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState extends AuthState {
  const _AuthState({this.user, this.role}): super._();
  

@override final  User? user;
@override final  Role? role;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.user, user) || other.user == user)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,user,role);

@override
String toString() {
  return 'AuthState(user: $user, role: $role)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 User? user, Role? role
});




}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? role = freezed,}) {
  return _then(_AuthState(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as Role?,
  ));
}


}

// dart format on
