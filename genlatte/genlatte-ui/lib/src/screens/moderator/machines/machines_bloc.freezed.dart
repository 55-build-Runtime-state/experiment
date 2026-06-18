// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'machines_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MachinesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MachinesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MachinesEvent()';
}


}

/// @nodoc
class $MachinesEventCopyWith<$Res>  {
$MachinesEventCopyWith(MachinesEvent _, $Res Function(MachinesEvent) __);
}


/// Adds pattern-matching-related methods to [MachinesEvent].
extension MachinesEventPatterns on MachinesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NewMachines value)?  newMachines,TResult Function( ToggleMachineStatus value)?  toggleMachineStatus,TResult Function( CreateMachine value)?  createMachine,TResult Function( DeleteMachine value)?  deleteMachine,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NewMachines() when newMachines != null:
return newMachines(_that);case ToggleMachineStatus() when toggleMachineStatus != null:
return toggleMachineStatus(_that);case CreateMachine() when createMachine != null:
return createMachine(_that);case DeleteMachine() when deleteMachine != null:
return deleteMachine(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NewMachines value)  newMachines,required TResult Function( ToggleMachineStatus value)  toggleMachineStatus,required TResult Function( CreateMachine value)  createMachine,required TResult Function( DeleteMachine value)  deleteMachine,}){
final _that = this;
switch (_that) {
case NewMachines():
return newMachines(_that);case ToggleMachineStatus():
return toggleMachineStatus(_that);case CreateMachine():
return createMachine(_that);case DeleteMachine():
return deleteMachine(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NewMachines value)?  newMachines,TResult? Function( ToggleMachineStatus value)?  toggleMachineStatus,TResult? Function( CreateMachine value)?  createMachine,TResult? Function( DeleteMachine value)?  deleteMachine,}){
final _that = this;
switch (_that) {
case NewMachines() when newMachines != null:
return newMachines(_that);case ToggleMachineStatus() when toggleMachineStatus != null:
return toggleMachineStatus(_that);case CreateMachine() when createMachine != null:
return createMachine(_that);case DeleteMachine() when deleteMachine != null:
return deleteMachine(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<Machine> machines)?  newMachines,TResult Function( Machine machine)?  toggleMachineStatus,TResult Function( Machine machine)?  createMachine,TResult Function( String id)?  deleteMachine,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NewMachines() when newMachines != null:
return newMachines(_that.machines);case ToggleMachineStatus() when toggleMachineStatus != null:
return toggleMachineStatus(_that.machine);case CreateMachine() when createMachine != null:
return createMachine(_that.machine);case DeleteMachine() when deleteMachine != null:
return deleteMachine(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<Machine> machines)  newMachines,required TResult Function( Machine machine)  toggleMachineStatus,required TResult Function( Machine machine)  createMachine,required TResult Function( String id)  deleteMachine,}) {final _that = this;
switch (_that) {
case NewMachines():
return newMachines(_that.machines);case ToggleMachineStatus():
return toggleMachineStatus(_that.machine);case CreateMachine():
return createMachine(_that.machine);case DeleteMachine():
return deleteMachine(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<Machine> machines)?  newMachines,TResult? Function( Machine machine)?  toggleMachineStatus,TResult? Function( Machine machine)?  createMachine,TResult? Function( String id)?  deleteMachine,}) {final _that = this;
switch (_that) {
case NewMachines() when newMachines != null:
return newMachines(_that.machines);case ToggleMachineStatus() when toggleMachineStatus != null:
return toggleMachineStatus(_that.machine);case CreateMachine() when createMachine != null:
return createMachine(_that.machine);case DeleteMachine() when deleteMachine != null:
return deleteMachine(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class NewMachines implements MachinesEvent {
  const NewMachines(final  List<Machine> machines): _machines = machines;
  

 final  List<Machine> _machines;
 List<Machine> get machines {
  if (_machines is EqualUnmodifiableListView) return _machines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_machines);
}


/// Create a copy of MachinesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewMachinesCopyWith<NewMachines> get copyWith => _$NewMachinesCopyWithImpl<NewMachines>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewMachines&&const DeepCollectionEquality().equals(other._machines, _machines));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_machines));

@override
String toString() {
  return 'MachinesEvent.newMachines(machines: $machines)';
}


}

/// @nodoc
abstract mixin class $NewMachinesCopyWith<$Res> implements $MachinesEventCopyWith<$Res> {
  factory $NewMachinesCopyWith(NewMachines value, $Res Function(NewMachines) _then) = _$NewMachinesCopyWithImpl;
@useResult
$Res call({
 List<Machine> machines
});




}
/// @nodoc
class _$NewMachinesCopyWithImpl<$Res>
    implements $NewMachinesCopyWith<$Res> {
  _$NewMachinesCopyWithImpl(this._self, this._then);

  final NewMachines _self;
  final $Res Function(NewMachines) _then;

/// Create a copy of MachinesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? machines = null,}) {
  return _then(NewMachines(
null == machines ? _self._machines : machines // ignore: cast_nullable_to_non_nullable
as List<Machine>,
  ));
}


}

/// @nodoc


class ToggleMachineStatus implements MachinesEvent {
  const ToggleMachineStatus(this.machine);
  

 final  Machine machine;

/// Create a copy of MachinesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleMachineStatusCopyWith<ToggleMachineStatus> get copyWith => _$ToggleMachineStatusCopyWithImpl<ToggleMachineStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleMachineStatus&&(identical(other.machine, machine) || other.machine == machine));
}


@override
int get hashCode => Object.hash(runtimeType,machine);

@override
String toString() {
  return 'MachinesEvent.toggleMachineStatus(machine: $machine)';
}


}

/// @nodoc
abstract mixin class $ToggleMachineStatusCopyWith<$Res> implements $MachinesEventCopyWith<$Res> {
  factory $ToggleMachineStatusCopyWith(ToggleMachineStatus value, $Res Function(ToggleMachineStatus) _then) = _$ToggleMachineStatusCopyWithImpl;
@useResult
$Res call({
 Machine machine
});


$MachineCopyWith<$Res> get machine;

}
/// @nodoc
class _$ToggleMachineStatusCopyWithImpl<$Res>
    implements $ToggleMachineStatusCopyWith<$Res> {
  _$ToggleMachineStatusCopyWithImpl(this._self, this._then);

  final ToggleMachineStatus _self;
  final $Res Function(ToggleMachineStatus) _then;

/// Create a copy of MachinesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? machine = null,}) {
  return _then(ToggleMachineStatus(
null == machine ? _self.machine : machine // ignore: cast_nullable_to_non_nullable
as Machine,
  ));
}

/// Create a copy of MachinesEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MachineCopyWith<$Res> get machine {
  
  return $MachineCopyWith<$Res>(_self.machine, (value) {
    return _then(_self.copyWith(machine: value));
  });
}
}

/// @nodoc


class CreateMachine implements MachinesEvent {
  const CreateMachine(this.machine);
  

 final  Machine machine;

/// Create a copy of MachinesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateMachineCopyWith<CreateMachine> get copyWith => _$CreateMachineCopyWithImpl<CreateMachine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateMachine&&(identical(other.machine, machine) || other.machine == machine));
}


@override
int get hashCode => Object.hash(runtimeType,machine);

@override
String toString() {
  return 'MachinesEvent.createMachine(machine: $machine)';
}


}

/// @nodoc
abstract mixin class $CreateMachineCopyWith<$Res> implements $MachinesEventCopyWith<$Res> {
  factory $CreateMachineCopyWith(CreateMachine value, $Res Function(CreateMachine) _then) = _$CreateMachineCopyWithImpl;
@useResult
$Res call({
 Machine machine
});


$MachineCopyWith<$Res> get machine;

}
/// @nodoc
class _$CreateMachineCopyWithImpl<$Res>
    implements $CreateMachineCopyWith<$Res> {
  _$CreateMachineCopyWithImpl(this._self, this._then);

  final CreateMachine _self;
  final $Res Function(CreateMachine) _then;

/// Create a copy of MachinesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? machine = null,}) {
  return _then(CreateMachine(
null == machine ? _self.machine : machine // ignore: cast_nullable_to_non_nullable
as Machine,
  ));
}

/// Create a copy of MachinesEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MachineCopyWith<$Res> get machine {
  
  return $MachineCopyWith<$Res>(_self.machine, (value) {
    return _then(_self.copyWith(machine: value));
  });
}
}

/// @nodoc


class DeleteMachine implements MachinesEvent {
  const DeleteMachine(this.id);
  

 final  String id;

/// Create a copy of MachinesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteMachineCopyWith<DeleteMachine> get copyWith => _$DeleteMachineCopyWithImpl<DeleteMachine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteMachine&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'MachinesEvent.deleteMachine(id: $id)';
}


}

/// @nodoc
abstract mixin class $DeleteMachineCopyWith<$Res> implements $MachinesEventCopyWith<$Res> {
  factory $DeleteMachineCopyWith(DeleteMachine value, $Res Function(DeleteMachine) _then) = _$DeleteMachineCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$DeleteMachineCopyWithImpl<$Res>
    implements $DeleteMachineCopyWith<$Res> {
  _$DeleteMachineCopyWithImpl(this._self, this._then);

  final DeleteMachine _self;
  final $Res Function(DeleteMachine) _then;

/// Create a copy of MachinesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(DeleteMachine(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$MachinesState {

/// All machines available on the server.
 List<Machine> get machines;
/// Create a copy of MachinesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MachinesStateCopyWith<MachinesState> get copyWith => _$MachinesStateCopyWithImpl<MachinesState>(this as MachinesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MachinesState&&const DeepCollectionEquality().equals(other.machines, machines));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(machines));

@override
String toString() {
  return 'MachinesState(machines: $machines)';
}


}

/// @nodoc
abstract mixin class $MachinesStateCopyWith<$Res>  {
  factory $MachinesStateCopyWith(MachinesState value, $Res Function(MachinesState) _then) = _$MachinesStateCopyWithImpl;
@useResult
$Res call({
 List<Machine> machines
});




}
/// @nodoc
class _$MachinesStateCopyWithImpl<$Res>
    implements $MachinesStateCopyWith<$Res> {
  _$MachinesStateCopyWithImpl(this._self, this._then);

  final MachinesState _self;
  final $Res Function(MachinesState) _then;

/// Create a copy of MachinesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? machines = null,}) {
  return _then(_self.copyWith(
machines: null == machines ? _self.machines : machines // ignore: cast_nullable_to_non_nullable
as List<Machine>,
  ));
}

}


/// Adds pattern-matching-related methods to [MachinesState].
extension MachinesStatePatterns on MachinesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MachinesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MachinesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MachinesState value)  $default,){
final _that = this;
switch (_that) {
case _MachinesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MachinesState value)?  $default,){
final _that = this;
switch (_that) {
case _MachinesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Machine> machines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MachinesState() when $default != null:
return $default(_that.machines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Machine> machines)  $default,) {final _that = this;
switch (_that) {
case _MachinesState():
return $default(_that.machines);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Machine> machines)?  $default,) {final _that = this;
switch (_that) {
case _MachinesState() when $default != null:
return $default(_that.machines);case _:
  return null;

}
}

}

/// @nodoc


class _MachinesState extends MachinesState {
  const _MachinesState({final  List<Machine> machines = const []}): _machines = machines,super._();
  

/// All machines available on the server.
 final  List<Machine> _machines;
/// All machines available on the server.
@override@JsonKey() List<Machine> get machines {
  if (_machines is EqualUnmodifiableListView) return _machines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_machines);
}


/// Create a copy of MachinesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MachinesStateCopyWith<_MachinesState> get copyWith => __$MachinesStateCopyWithImpl<_MachinesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MachinesState&&const DeepCollectionEquality().equals(other._machines, _machines));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_machines));

@override
String toString() {
  return 'MachinesState(machines: $machines)';
}


}

/// @nodoc
abstract mixin class _$MachinesStateCopyWith<$Res> implements $MachinesStateCopyWith<$Res> {
  factory _$MachinesStateCopyWith(_MachinesState value, $Res Function(_MachinesState) _then) = __$MachinesStateCopyWithImpl;
@override @useResult
$Res call({
 List<Machine> machines
});




}
/// @nodoc
class __$MachinesStateCopyWithImpl<$Res>
    implements _$MachinesStateCopyWith<$Res> {
  __$MachinesStateCopyWithImpl(this._self, this._then);

  final _MachinesState _self;
  final $Res Function(_MachinesState) _then;

/// Create a copy of MachinesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? machines = null,}) {
  return _then(_MachinesState(
machines: null == machines ? _self._machines : machines // ignore: cast_nullable_to_non_nullable
as List<Machine>,
  ));
}


}

// dart format on
