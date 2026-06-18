// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'barista_home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BaristaHomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaristaHomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaristaHomeEvent()';
}


}

/// @nodoc
class $BaristaHomeEventCopyWith<$Res>  {
$BaristaHomeEventCopyWith(BaristaHomeEvent _, $Res Function(BaristaHomeEvent) __);
}


/// Adds pattern-matching-related methods to [BaristaHomeEvent].
extension BaristaHomeEventPatterns on BaristaHomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NewBrewQueueOrders value)?  newBrewQueueOrders,TResult Function( NewMachineList value)?  newMachinesList,TResult Function( SelectedMachineDisappeared value)?  selectedMachineDisappeared,TResult Function( SelectedMachine value)?  selectedMachine,TResult Function( NewBaristas value)?  newBaristas,TResult Function( BaristaSignIn value)?  baristaSignIn,TResult Function( BaristaSignOut value)?  baristaSignOut,TResult Function( ClaimOrder value)?  claimOrder,TResult Function( CompleteOrder value)?  completeOrder,TResult Function( ReprintOrder value)?  reprintOrder,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NewBrewQueueOrders() when newBrewQueueOrders != null:
return newBrewQueueOrders(_that);case NewMachineList() when newMachinesList != null:
return newMachinesList(_that);case SelectedMachineDisappeared() when selectedMachineDisappeared != null:
return selectedMachineDisappeared(_that);case SelectedMachine() when selectedMachine != null:
return selectedMachine(_that);case NewBaristas() when newBaristas != null:
return newBaristas(_that);case BaristaSignIn() when baristaSignIn != null:
return baristaSignIn(_that);case BaristaSignOut() when baristaSignOut != null:
return baristaSignOut(_that);case ClaimOrder() when claimOrder != null:
return claimOrder(_that);case CompleteOrder() when completeOrder != null:
return completeOrder(_that);case ReprintOrder() when reprintOrder != null:
return reprintOrder(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NewBrewQueueOrders value)  newBrewQueueOrders,required TResult Function( NewMachineList value)  newMachinesList,required TResult Function( SelectedMachineDisappeared value)  selectedMachineDisappeared,required TResult Function( SelectedMachine value)  selectedMachine,required TResult Function( NewBaristas value)  newBaristas,required TResult Function( BaristaSignIn value)  baristaSignIn,required TResult Function( BaristaSignOut value)  baristaSignOut,required TResult Function( ClaimOrder value)  claimOrder,required TResult Function( CompleteOrder value)  completeOrder,required TResult Function( ReprintOrder value)  reprintOrder,}){
final _that = this;
switch (_that) {
case NewBrewQueueOrders():
return newBrewQueueOrders(_that);case NewMachineList():
return newMachinesList(_that);case SelectedMachineDisappeared():
return selectedMachineDisappeared(_that);case SelectedMachine():
return selectedMachine(_that);case NewBaristas():
return newBaristas(_that);case BaristaSignIn():
return baristaSignIn(_that);case BaristaSignOut():
return baristaSignOut(_that);case ClaimOrder():
return claimOrder(_that);case CompleteOrder():
return completeOrder(_that);case ReprintOrder():
return reprintOrder(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NewBrewQueueOrders value)?  newBrewQueueOrders,TResult? Function( NewMachineList value)?  newMachinesList,TResult? Function( SelectedMachineDisappeared value)?  selectedMachineDisappeared,TResult? Function( SelectedMachine value)?  selectedMachine,TResult? Function( NewBaristas value)?  newBaristas,TResult? Function( BaristaSignIn value)?  baristaSignIn,TResult? Function( BaristaSignOut value)?  baristaSignOut,TResult? Function( ClaimOrder value)?  claimOrder,TResult? Function( CompleteOrder value)?  completeOrder,TResult? Function( ReprintOrder value)?  reprintOrder,}){
final _that = this;
switch (_that) {
case NewBrewQueueOrders() when newBrewQueueOrders != null:
return newBrewQueueOrders(_that);case NewMachineList() when newMachinesList != null:
return newMachinesList(_that);case SelectedMachineDisappeared() when selectedMachineDisappeared != null:
return selectedMachineDisappeared(_that);case SelectedMachine() when selectedMachine != null:
return selectedMachine(_that);case NewBaristas() when newBaristas != null:
return newBaristas(_that);case BaristaSignIn() when baristaSignIn != null:
return baristaSignIn(_that);case BaristaSignOut() when baristaSignOut != null:
return baristaSignOut(_that);case ClaimOrder() when claimOrder != null:
return claimOrder(_that);case CompleteOrder() when completeOrder != null:
return completeOrder(_that);case ReprintOrder() when reprintOrder != null:
return reprintOrder(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<LatteOrderMetadata> metadatas)?  newBrewQueueOrders,TResult Function( List<Machine> machines)?  newMachinesList,TResult Function()?  selectedMachineDisappeared,TResult Function( Machine machine)?  selectedMachine,TResult Function( List<Barista> baristas)?  newBaristas,TResult Function( Barista barista)?  baristaSignIn,TResult Function()?  baristaSignOut,TResult Function( String orderId)?  claimOrder,TResult Function( String orderId)?  completeOrder,TResult Function( String orderId)?  reprintOrder,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NewBrewQueueOrders() when newBrewQueueOrders != null:
return newBrewQueueOrders(_that.metadatas);case NewMachineList() when newMachinesList != null:
return newMachinesList(_that.machines);case SelectedMachineDisappeared() when selectedMachineDisappeared != null:
return selectedMachineDisappeared();case SelectedMachine() when selectedMachine != null:
return selectedMachine(_that.machine);case NewBaristas() when newBaristas != null:
return newBaristas(_that.baristas);case BaristaSignIn() when baristaSignIn != null:
return baristaSignIn(_that.barista);case BaristaSignOut() when baristaSignOut != null:
return baristaSignOut();case ClaimOrder() when claimOrder != null:
return claimOrder(_that.orderId);case CompleteOrder() when completeOrder != null:
return completeOrder(_that.orderId);case ReprintOrder() when reprintOrder != null:
return reprintOrder(_that.orderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<LatteOrderMetadata> metadatas)  newBrewQueueOrders,required TResult Function( List<Machine> machines)  newMachinesList,required TResult Function()  selectedMachineDisappeared,required TResult Function( Machine machine)  selectedMachine,required TResult Function( List<Barista> baristas)  newBaristas,required TResult Function( Barista barista)  baristaSignIn,required TResult Function()  baristaSignOut,required TResult Function( String orderId)  claimOrder,required TResult Function( String orderId)  completeOrder,required TResult Function( String orderId)  reprintOrder,}) {final _that = this;
switch (_that) {
case NewBrewQueueOrders():
return newBrewQueueOrders(_that.metadatas);case NewMachineList():
return newMachinesList(_that.machines);case SelectedMachineDisappeared():
return selectedMachineDisappeared();case SelectedMachine():
return selectedMachine(_that.machine);case NewBaristas():
return newBaristas(_that.baristas);case BaristaSignIn():
return baristaSignIn(_that.barista);case BaristaSignOut():
return baristaSignOut();case ClaimOrder():
return claimOrder(_that.orderId);case CompleteOrder():
return completeOrder(_that.orderId);case ReprintOrder():
return reprintOrder(_that.orderId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<LatteOrderMetadata> metadatas)?  newBrewQueueOrders,TResult? Function( List<Machine> machines)?  newMachinesList,TResult? Function()?  selectedMachineDisappeared,TResult? Function( Machine machine)?  selectedMachine,TResult? Function( List<Barista> baristas)?  newBaristas,TResult? Function( Barista barista)?  baristaSignIn,TResult? Function()?  baristaSignOut,TResult? Function( String orderId)?  claimOrder,TResult? Function( String orderId)?  completeOrder,TResult? Function( String orderId)?  reprintOrder,}) {final _that = this;
switch (_that) {
case NewBrewQueueOrders() when newBrewQueueOrders != null:
return newBrewQueueOrders(_that.metadatas);case NewMachineList() when newMachinesList != null:
return newMachinesList(_that.machines);case SelectedMachineDisappeared() when selectedMachineDisappeared != null:
return selectedMachineDisappeared();case SelectedMachine() when selectedMachine != null:
return selectedMachine(_that.machine);case NewBaristas() when newBaristas != null:
return newBaristas(_that.baristas);case BaristaSignIn() when baristaSignIn != null:
return baristaSignIn(_that.barista);case BaristaSignOut() when baristaSignOut != null:
return baristaSignOut();case ClaimOrder() when claimOrder != null:
return claimOrder(_that.orderId);case CompleteOrder() when completeOrder != null:
return completeOrder(_that.orderId);case ReprintOrder() when reprintOrder != null:
return reprintOrder(_that.orderId);case _:
  return null;

}
}

}

/// @nodoc


class NewBrewQueueOrders implements BaristaHomeEvent {
  const NewBrewQueueOrders(final  List<LatteOrderMetadata> metadatas): _metadatas = metadatas;
  

 final  List<LatteOrderMetadata> _metadatas;
 List<LatteOrderMetadata> get metadatas {
  if (_metadatas is EqualUnmodifiableListView) return _metadatas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_metadatas);
}


/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewBrewQueueOrdersCopyWith<NewBrewQueueOrders> get copyWith => _$NewBrewQueueOrdersCopyWithImpl<NewBrewQueueOrders>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewBrewQueueOrders&&const DeepCollectionEquality().equals(other._metadatas, _metadatas));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_metadatas));

@override
String toString() {
  return 'BaristaHomeEvent.newBrewQueueOrders(metadatas: $metadatas)';
}


}

/// @nodoc
abstract mixin class $NewBrewQueueOrdersCopyWith<$Res> implements $BaristaHomeEventCopyWith<$Res> {
  factory $NewBrewQueueOrdersCopyWith(NewBrewQueueOrders value, $Res Function(NewBrewQueueOrders) _then) = _$NewBrewQueueOrdersCopyWithImpl;
@useResult
$Res call({
 List<LatteOrderMetadata> metadatas
});




}
/// @nodoc
class _$NewBrewQueueOrdersCopyWithImpl<$Res>
    implements $NewBrewQueueOrdersCopyWith<$Res> {
  _$NewBrewQueueOrdersCopyWithImpl(this._self, this._then);

  final NewBrewQueueOrders _self;
  final $Res Function(NewBrewQueueOrders) _then;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? metadatas = null,}) {
  return _then(NewBrewQueueOrders(
null == metadatas ? _self._metadatas : metadatas // ignore: cast_nullable_to_non_nullable
as List<LatteOrderMetadata>,
  ));
}


}

/// @nodoc


class NewMachineList implements BaristaHomeEvent {
  const NewMachineList(final  List<Machine> machines): _machines = machines;
  

 final  List<Machine> _machines;
 List<Machine> get machines {
  if (_machines is EqualUnmodifiableListView) return _machines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_machines);
}


/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewMachineListCopyWith<NewMachineList> get copyWith => _$NewMachineListCopyWithImpl<NewMachineList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewMachineList&&const DeepCollectionEquality().equals(other._machines, _machines));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_machines));

@override
String toString() {
  return 'BaristaHomeEvent.newMachinesList(machines: $machines)';
}


}

/// @nodoc
abstract mixin class $NewMachineListCopyWith<$Res> implements $BaristaHomeEventCopyWith<$Res> {
  factory $NewMachineListCopyWith(NewMachineList value, $Res Function(NewMachineList) _then) = _$NewMachineListCopyWithImpl;
@useResult
$Res call({
 List<Machine> machines
});




}
/// @nodoc
class _$NewMachineListCopyWithImpl<$Res>
    implements $NewMachineListCopyWith<$Res> {
  _$NewMachineListCopyWithImpl(this._self, this._then);

  final NewMachineList _self;
  final $Res Function(NewMachineList) _then;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? machines = null,}) {
  return _then(NewMachineList(
null == machines ? _self._machines : machines // ignore: cast_nullable_to_non_nullable
as List<Machine>,
  ));
}


}

/// @nodoc


class SelectedMachineDisappeared implements BaristaHomeEvent {
  const SelectedMachineDisappeared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedMachineDisappeared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaristaHomeEvent.selectedMachineDisappeared()';
}


}




/// @nodoc


class SelectedMachine implements BaristaHomeEvent {
  const SelectedMachine(this.machine);
  

 final  Machine machine;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedMachineCopyWith<SelectedMachine> get copyWith => _$SelectedMachineCopyWithImpl<SelectedMachine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedMachine&&(identical(other.machine, machine) || other.machine == machine));
}


@override
int get hashCode => Object.hash(runtimeType,machine);

@override
String toString() {
  return 'BaristaHomeEvent.selectedMachine(machine: $machine)';
}


}

/// @nodoc
abstract mixin class $SelectedMachineCopyWith<$Res> implements $BaristaHomeEventCopyWith<$Res> {
  factory $SelectedMachineCopyWith(SelectedMachine value, $Res Function(SelectedMachine) _then) = _$SelectedMachineCopyWithImpl;
@useResult
$Res call({
 Machine machine
});


$MachineCopyWith<$Res> get machine;

}
/// @nodoc
class _$SelectedMachineCopyWithImpl<$Res>
    implements $SelectedMachineCopyWith<$Res> {
  _$SelectedMachineCopyWithImpl(this._self, this._then);

  final SelectedMachine _self;
  final $Res Function(SelectedMachine) _then;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? machine = null,}) {
  return _then(SelectedMachine(
null == machine ? _self.machine : machine // ignore: cast_nullable_to_non_nullable
as Machine,
  ));
}

/// Create a copy of BaristaHomeEvent
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


class NewBaristas implements BaristaHomeEvent {
  const NewBaristas(final  List<Barista> baristas): _baristas = baristas;
  

 final  List<Barista> _baristas;
 List<Barista> get baristas {
  if (_baristas is EqualUnmodifiableListView) return _baristas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_baristas);
}


/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewBaristasCopyWith<NewBaristas> get copyWith => _$NewBaristasCopyWithImpl<NewBaristas>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewBaristas&&const DeepCollectionEquality().equals(other._baristas, _baristas));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_baristas));

@override
String toString() {
  return 'BaristaHomeEvent.newBaristas(baristas: $baristas)';
}


}

/// @nodoc
abstract mixin class $NewBaristasCopyWith<$Res> implements $BaristaHomeEventCopyWith<$Res> {
  factory $NewBaristasCopyWith(NewBaristas value, $Res Function(NewBaristas) _then) = _$NewBaristasCopyWithImpl;
@useResult
$Res call({
 List<Barista> baristas
});




}
/// @nodoc
class _$NewBaristasCopyWithImpl<$Res>
    implements $NewBaristasCopyWith<$Res> {
  _$NewBaristasCopyWithImpl(this._self, this._then);

  final NewBaristas _self;
  final $Res Function(NewBaristas) _then;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? baristas = null,}) {
  return _then(NewBaristas(
null == baristas ? _self._baristas : baristas // ignore: cast_nullable_to_non_nullable
as List<Barista>,
  ));
}


}

/// @nodoc


class BaristaSignIn implements BaristaHomeEvent {
  const BaristaSignIn(this.barista);
  

 final  Barista barista;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaristaSignInCopyWith<BaristaSignIn> get copyWith => _$BaristaSignInCopyWithImpl<BaristaSignIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaristaSignIn&&(identical(other.barista, barista) || other.barista == barista));
}


@override
int get hashCode => Object.hash(runtimeType,barista);

@override
String toString() {
  return 'BaristaHomeEvent.baristaSignIn(barista: $barista)';
}


}

/// @nodoc
abstract mixin class $BaristaSignInCopyWith<$Res> implements $BaristaHomeEventCopyWith<$Res> {
  factory $BaristaSignInCopyWith(BaristaSignIn value, $Res Function(BaristaSignIn) _then) = _$BaristaSignInCopyWithImpl;
@useResult
$Res call({
 Barista barista
});


$BaristaCopyWith<$Res> get barista;

}
/// @nodoc
class _$BaristaSignInCopyWithImpl<$Res>
    implements $BaristaSignInCopyWith<$Res> {
  _$BaristaSignInCopyWithImpl(this._self, this._then);

  final BaristaSignIn _self;
  final $Res Function(BaristaSignIn) _then;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? barista = null,}) {
  return _then(BaristaSignIn(
null == barista ? _self.barista : barista // ignore: cast_nullable_to_non_nullable
as Barista,
  ));
}

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BaristaCopyWith<$Res> get barista {
  
  return $BaristaCopyWith<$Res>(_self.barista, (value) {
    return _then(_self.copyWith(barista: value));
  });
}
}

/// @nodoc


class BaristaSignOut implements BaristaHomeEvent {
  const BaristaSignOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaristaSignOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaristaHomeEvent.baristaSignOut()';
}


}




/// @nodoc


class ClaimOrder implements BaristaHomeEvent {
  const ClaimOrder(this.orderId);
  

 final  String orderId;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimOrderCopyWith<ClaimOrder> get copyWith => _$ClaimOrderCopyWithImpl<ClaimOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimOrder&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'BaristaHomeEvent.claimOrder(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $ClaimOrderCopyWith<$Res> implements $BaristaHomeEventCopyWith<$Res> {
  factory $ClaimOrderCopyWith(ClaimOrder value, $Res Function(ClaimOrder) _then) = _$ClaimOrderCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class _$ClaimOrderCopyWithImpl<$Res>
    implements $ClaimOrderCopyWith<$Res> {
  _$ClaimOrderCopyWithImpl(this._self, this._then);

  final ClaimOrder _self;
  final $Res Function(ClaimOrder) _then;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(ClaimOrder(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CompleteOrder implements BaristaHomeEvent {
  const CompleteOrder(this.orderId);
  

 final  String orderId;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompleteOrderCopyWith<CompleteOrder> get copyWith => _$CompleteOrderCopyWithImpl<CompleteOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteOrder&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'BaristaHomeEvent.completeOrder(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $CompleteOrderCopyWith<$Res> implements $BaristaHomeEventCopyWith<$Res> {
  factory $CompleteOrderCopyWith(CompleteOrder value, $Res Function(CompleteOrder) _then) = _$CompleteOrderCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class _$CompleteOrderCopyWithImpl<$Res>
    implements $CompleteOrderCopyWith<$Res> {
  _$CompleteOrderCopyWithImpl(this._self, this._then);

  final CompleteOrder _self;
  final $Res Function(CompleteOrder) _then;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(CompleteOrder(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ReprintOrder implements BaristaHomeEvent {
  const ReprintOrder(this.orderId);
  

 final  String orderId;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReprintOrderCopyWith<ReprintOrder> get copyWith => _$ReprintOrderCopyWithImpl<ReprintOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReprintOrder&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'BaristaHomeEvent.reprintOrder(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $ReprintOrderCopyWith<$Res> implements $BaristaHomeEventCopyWith<$Res> {
  factory $ReprintOrderCopyWith(ReprintOrder value, $Res Function(ReprintOrder) _then) = _$ReprintOrderCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class _$ReprintOrderCopyWithImpl<$Res>
    implements $ReprintOrderCopyWith<$Res> {
  _$ReprintOrderCopyWithImpl(this._self, this._then);

  final ReprintOrder _self;
  final $Res Function(ReprintOrder) _then;

/// Create a copy of BaristaHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(ReprintOrder(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BaristaHomeState {

 List<Latte> get brewQueue; Barista? get currentBarista; Map<String, Barista> get baristas; List<Machine> get machines; Machine? get selectedMachine; MachinesError? get error;
/// Create a copy of BaristaHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaristaHomeStateCopyWith<BaristaHomeState> get copyWith => _$BaristaHomeStateCopyWithImpl<BaristaHomeState>(this as BaristaHomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaristaHomeState&&const DeepCollectionEquality().equals(other.brewQueue, brewQueue)&&(identical(other.currentBarista, currentBarista) || other.currentBarista == currentBarista)&&const DeepCollectionEquality().equals(other.baristas, baristas)&&const DeepCollectionEquality().equals(other.machines, machines)&&(identical(other.selectedMachine, selectedMachine) || other.selectedMachine == selectedMachine)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(brewQueue),currentBarista,const DeepCollectionEquality().hash(baristas),const DeepCollectionEquality().hash(machines),selectedMachine,error);

@override
String toString() {
  return 'BaristaHomeState(brewQueue: $brewQueue, currentBarista: $currentBarista, baristas: $baristas, machines: $machines, selectedMachine: $selectedMachine, error: $error)';
}


}

/// @nodoc
abstract mixin class $BaristaHomeStateCopyWith<$Res>  {
  factory $BaristaHomeStateCopyWith(BaristaHomeState value, $Res Function(BaristaHomeState) _then) = _$BaristaHomeStateCopyWithImpl;
@useResult
$Res call({
 List<Latte> brewQueue, Barista? currentBarista, Map<String, Barista> baristas, List<Machine> machines, Machine? selectedMachine, MachinesError? error
});


$BaristaCopyWith<$Res>? get currentBarista;$MachineCopyWith<$Res>? get selectedMachine;

}
/// @nodoc
class _$BaristaHomeStateCopyWithImpl<$Res>
    implements $BaristaHomeStateCopyWith<$Res> {
  _$BaristaHomeStateCopyWithImpl(this._self, this._then);

  final BaristaHomeState _self;
  final $Res Function(BaristaHomeState) _then;

/// Create a copy of BaristaHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? brewQueue = null,Object? currentBarista = freezed,Object? baristas = null,Object? machines = null,Object? selectedMachine = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
brewQueue: null == brewQueue ? _self.brewQueue : brewQueue // ignore: cast_nullable_to_non_nullable
as List<Latte>,currentBarista: freezed == currentBarista ? _self.currentBarista : currentBarista // ignore: cast_nullable_to_non_nullable
as Barista?,baristas: null == baristas ? _self.baristas : baristas // ignore: cast_nullable_to_non_nullable
as Map<String, Barista>,machines: null == machines ? _self.machines : machines // ignore: cast_nullable_to_non_nullable
as List<Machine>,selectedMachine: freezed == selectedMachine ? _self.selectedMachine : selectedMachine // ignore: cast_nullable_to_non_nullable
as Machine?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as MachinesError?,
  ));
}
/// Create a copy of BaristaHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BaristaCopyWith<$Res>? get currentBarista {
    if (_self.currentBarista == null) {
    return null;
  }

  return $BaristaCopyWith<$Res>(_self.currentBarista!, (value) {
    return _then(_self.copyWith(currentBarista: value));
  });
}/// Create a copy of BaristaHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MachineCopyWith<$Res>? get selectedMachine {
    if (_self.selectedMachine == null) {
    return null;
  }

  return $MachineCopyWith<$Res>(_self.selectedMachine!, (value) {
    return _then(_self.copyWith(selectedMachine: value));
  });
}
}


/// Adds pattern-matching-related methods to [BaristaHomeState].
extension BaristaHomeStatePatterns on BaristaHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BaristaHomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BaristaHomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BaristaHomeState value)  $default,){
final _that = this;
switch (_that) {
case _BaristaHomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BaristaHomeState value)?  $default,){
final _that = this;
switch (_that) {
case _BaristaHomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Latte> brewQueue,  Barista? currentBarista,  Map<String, Barista> baristas,  List<Machine> machines,  Machine? selectedMachine,  MachinesError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BaristaHomeState() when $default != null:
return $default(_that.brewQueue,_that.currentBarista,_that.baristas,_that.machines,_that.selectedMachine,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Latte> brewQueue,  Barista? currentBarista,  Map<String, Barista> baristas,  List<Machine> machines,  Machine? selectedMachine,  MachinesError? error)  $default,) {final _that = this;
switch (_that) {
case _BaristaHomeState():
return $default(_that.brewQueue,_that.currentBarista,_that.baristas,_that.machines,_that.selectedMachine,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Latte> brewQueue,  Barista? currentBarista,  Map<String, Barista> baristas,  List<Machine> machines,  Machine? selectedMachine,  MachinesError? error)?  $default,) {final _that = this;
switch (_that) {
case _BaristaHomeState() when $default != null:
return $default(_that.brewQueue,_that.currentBarista,_that.baristas,_that.machines,_that.selectedMachine,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _BaristaHomeState extends BaristaHomeState {
  const _BaristaHomeState({required final  List<Latte> brewQueue, this.currentBarista, final  Map<String, Barista> baristas = const {}, final  List<Machine> machines = const [], this.selectedMachine, this.error}): _brewQueue = brewQueue,_baristas = baristas,_machines = machines,super._();
  

 final  List<Latte> _brewQueue;
@override List<Latte> get brewQueue {
  if (_brewQueue is EqualUnmodifiableListView) return _brewQueue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brewQueue);
}

@override final  Barista? currentBarista;
 final  Map<String, Barista> _baristas;
@override@JsonKey() Map<String, Barista> get baristas {
  if (_baristas is EqualUnmodifiableMapView) return _baristas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_baristas);
}

 final  List<Machine> _machines;
@override@JsonKey() List<Machine> get machines {
  if (_machines is EqualUnmodifiableListView) return _machines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_machines);
}

@override final  Machine? selectedMachine;
@override final  MachinesError? error;

/// Create a copy of BaristaHomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BaristaHomeStateCopyWith<_BaristaHomeState> get copyWith => __$BaristaHomeStateCopyWithImpl<_BaristaHomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BaristaHomeState&&const DeepCollectionEquality().equals(other._brewQueue, _brewQueue)&&(identical(other.currentBarista, currentBarista) || other.currentBarista == currentBarista)&&const DeepCollectionEquality().equals(other._baristas, _baristas)&&const DeepCollectionEquality().equals(other._machines, _machines)&&(identical(other.selectedMachine, selectedMachine) || other.selectedMachine == selectedMachine)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_brewQueue),currentBarista,const DeepCollectionEquality().hash(_baristas),const DeepCollectionEquality().hash(_machines),selectedMachine,error);

@override
String toString() {
  return 'BaristaHomeState(brewQueue: $brewQueue, currentBarista: $currentBarista, baristas: $baristas, machines: $machines, selectedMachine: $selectedMachine, error: $error)';
}


}

/// @nodoc
abstract mixin class _$BaristaHomeStateCopyWith<$Res> implements $BaristaHomeStateCopyWith<$Res> {
  factory _$BaristaHomeStateCopyWith(_BaristaHomeState value, $Res Function(_BaristaHomeState) _then) = __$BaristaHomeStateCopyWithImpl;
@override @useResult
$Res call({
 List<Latte> brewQueue, Barista? currentBarista, Map<String, Barista> baristas, List<Machine> machines, Machine? selectedMachine, MachinesError? error
});


@override $BaristaCopyWith<$Res>? get currentBarista;@override $MachineCopyWith<$Res>? get selectedMachine;

}
/// @nodoc
class __$BaristaHomeStateCopyWithImpl<$Res>
    implements _$BaristaHomeStateCopyWith<$Res> {
  __$BaristaHomeStateCopyWithImpl(this._self, this._then);

  final _BaristaHomeState _self;
  final $Res Function(_BaristaHomeState) _then;

/// Create a copy of BaristaHomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? brewQueue = null,Object? currentBarista = freezed,Object? baristas = null,Object? machines = null,Object? selectedMachine = freezed,Object? error = freezed,}) {
  return _then(_BaristaHomeState(
brewQueue: null == brewQueue ? _self._brewQueue : brewQueue // ignore: cast_nullable_to_non_nullable
as List<Latte>,currentBarista: freezed == currentBarista ? _self.currentBarista : currentBarista // ignore: cast_nullable_to_non_nullable
as Barista?,baristas: null == baristas ? _self._baristas : baristas // ignore: cast_nullable_to_non_nullable
as Map<String, Barista>,machines: null == machines ? _self._machines : machines // ignore: cast_nullable_to_non_nullable
as List<Machine>,selectedMachine: freezed == selectedMachine ? _self.selectedMachine : selectedMachine // ignore: cast_nullable_to_non_nullable
as Machine?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as MachinesError?,
  ));
}

/// Create a copy of BaristaHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BaristaCopyWith<$Res>? get currentBarista {
    if (_self.currentBarista == null) {
    return null;
  }

  return $BaristaCopyWith<$Res>(_self.currentBarista!, (value) {
    return _then(_self.copyWith(currentBarista: value));
  });
}/// Create a copy of BaristaHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MachineCopyWith<$Res>? get selectedMachine {
    if (_self.selectedMachine == null) {
    return null;
  }

  return $MachineCopyWith<$Res>(_self.selectedMachine!, (value) {
    return _then(_self.copyWith(selectedMachine: value));
  });
}
}

// dart format on
