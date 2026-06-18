// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moderator_home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ModeratorHomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModeratorHomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ModeratorHomeEvent()';
}


}

/// @nodoc
class $ModeratorHomeEventCopyWith<$Res>  {
$ModeratorHomeEventCopyWith(ModeratorHomeEvent _, $Res Function(ModeratorHomeEvent) __);
}


/// Adds pattern-matching-related methods to [ModeratorHomeEvent].
extension ModeratorHomeEventPatterns on ModeratorHomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NewBaristas value)?  newBaristas,TResult Function( NewModerateQueueOrders value)?  newModerateQueueOrders,TResult Function( ApproveNameAndImage value)?  approveNameAndImage,TResult Function( RejectNameApproveImage value)?  rejectNameApproveImage,TResult Function( ApproveNameRejectImage value)?  approveNameRejectImage,TResult Function( RejectNameAndImage value)?  rejectNameAndImage,TResult Function( CompleteOrder value)?  completeOrder,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NewBaristas() when newBaristas != null:
return newBaristas(_that);case NewModerateQueueOrders() when newModerateQueueOrders != null:
return newModerateQueueOrders(_that);case ApproveNameAndImage() when approveNameAndImage != null:
return approveNameAndImage(_that);case RejectNameApproveImage() when rejectNameApproveImage != null:
return rejectNameApproveImage(_that);case ApproveNameRejectImage() when approveNameRejectImage != null:
return approveNameRejectImage(_that);case RejectNameAndImage() when rejectNameAndImage != null:
return rejectNameAndImage(_that);case CompleteOrder() when completeOrder != null:
return completeOrder(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NewBaristas value)  newBaristas,required TResult Function( NewModerateQueueOrders value)  newModerateQueueOrders,required TResult Function( ApproveNameAndImage value)  approveNameAndImage,required TResult Function( RejectNameApproveImage value)  rejectNameApproveImage,required TResult Function( ApproveNameRejectImage value)  approveNameRejectImage,required TResult Function( RejectNameAndImage value)  rejectNameAndImage,required TResult Function( CompleteOrder value)  completeOrder,}){
final _that = this;
switch (_that) {
case NewBaristas():
return newBaristas(_that);case NewModerateQueueOrders():
return newModerateQueueOrders(_that);case ApproveNameAndImage():
return approveNameAndImage(_that);case RejectNameApproveImage():
return rejectNameApproveImage(_that);case ApproveNameRejectImage():
return approveNameRejectImage(_that);case RejectNameAndImage():
return rejectNameAndImage(_that);case CompleteOrder():
return completeOrder(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NewBaristas value)?  newBaristas,TResult? Function( NewModerateQueueOrders value)?  newModerateQueueOrders,TResult? Function( ApproveNameAndImage value)?  approveNameAndImage,TResult? Function( RejectNameApproveImage value)?  rejectNameApproveImage,TResult? Function( ApproveNameRejectImage value)?  approveNameRejectImage,TResult? Function( RejectNameAndImage value)?  rejectNameAndImage,TResult? Function( CompleteOrder value)?  completeOrder,}){
final _that = this;
switch (_that) {
case NewBaristas() when newBaristas != null:
return newBaristas(_that);case NewModerateQueueOrders() when newModerateQueueOrders != null:
return newModerateQueueOrders(_that);case ApproveNameAndImage() when approveNameAndImage != null:
return approveNameAndImage(_that);case RejectNameApproveImage() when rejectNameApproveImage != null:
return rejectNameApproveImage(_that);case ApproveNameRejectImage() when approveNameRejectImage != null:
return approveNameRejectImage(_that);case RejectNameAndImage() when rejectNameAndImage != null:
return rejectNameAndImage(_that);case CompleteOrder() when completeOrder != null:
return completeOrder(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<Barista> baristas)?  newBaristas,TResult Function( List<LatteOrderMetadata> metadatas)?  newModerateQueueOrders,TResult Function( String orderId)?  approveNameAndImage,TResult Function( String orderId)?  rejectNameApproveImage,TResult Function( String orderId)?  approveNameRejectImage,TResult Function( String orderId)?  rejectNameAndImage,TResult Function( String orderId)?  completeOrder,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NewBaristas() when newBaristas != null:
return newBaristas(_that.baristas);case NewModerateQueueOrders() when newModerateQueueOrders != null:
return newModerateQueueOrders(_that.metadatas);case ApproveNameAndImage() when approveNameAndImage != null:
return approveNameAndImage(_that.orderId);case RejectNameApproveImage() when rejectNameApproveImage != null:
return rejectNameApproveImage(_that.orderId);case ApproveNameRejectImage() when approveNameRejectImage != null:
return approveNameRejectImage(_that.orderId);case RejectNameAndImage() when rejectNameAndImage != null:
return rejectNameAndImage(_that.orderId);case CompleteOrder() when completeOrder != null:
return completeOrder(_that.orderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<Barista> baristas)  newBaristas,required TResult Function( List<LatteOrderMetadata> metadatas)  newModerateQueueOrders,required TResult Function( String orderId)  approveNameAndImage,required TResult Function( String orderId)  rejectNameApproveImage,required TResult Function( String orderId)  approveNameRejectImage,required TResult Function( String orderId)  rejectNameAndImage,required TResult Function( String orderId)  completeOrder,}) {final _that = this;
switch (_that) {
case NewBaristas():
return newBaristas(_that.baristas);case NewModerateQueueOrders():
return newModerateQueueOrders(_that.metadatas);case ApproveNameAndImage():
return approveNameAndImage(_that.orderId);case RejectNameApproveImage():
return rejectNameApproveImage(_that.orderId);case ApproveNameRejectImage():
return approveNameRejectImage(_that.orderId);case RejectNameAndImage():
return rejectNameAndImage(_that.orderId);case CompleteOrder():
return completeOrder(_that.orderId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<Barista> baristas)?  newBaristas,TResult? Function( List<LatteOrderMetadata> metadatas)?  newModerateQueueOrders,TResult? Function( String orderId)?  approveNameAndImage,TResult? Function( String orderId)?  rejectNameApproveImage,TResult? Function( String orderId)?  approveNameRejectImage,TResult? Function( String orderId)?  rejectNameAndImage,TResult? Function( String orderId)?  completeOrder,}) {final _that = this;
switch (_that) {
case NewBaristas() when newBaristas != null:
return newBaristas(_that.baristas);case NewModerateQueueOrders() when newModerateQueueOrders != null:
return newModerateQueueOrders(_that.metadatas);case ApproveNameAndImage() when approveNameAndImage != null:
return approveNameAndImage(_that.orderId);case RejectNameApproveImage() when rejectNameApproveImage != null:
return rejectNameApproveImage(_that.orderId);case ApproveNameRejectImage() when approveNameRejectImage != null:
return approveNameRejectImage(_that.orderId);case RejectNameAndImage() when rejectNameAndImage != null:
return rejectNameAndImage(_that.orderId);case CompleteOrder() when completeOrder != null:
return completeOrder(_that.orderId);case _:
  return null;

}
}

}

/// @nodoc


class NewBaristas implements ModeratorHomeEvent {
  const NewBaristas(final  List<Barista> baristas): _baristas = baristas;
  

 final  List<Barista> _baristas;
 List<Barista> get baristas {
  if (_baristas is EqualUnmodifiableListView) return _baristas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_baristas);
}


/// Create a copy of ModeratorHomeEvent
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
  return 'ModeratorHomeEvent.newBaristas(baristas: $baristas)';
}


}

/// @nodoc
abstract mixin class $NewBaristasCopyWith<$Res> implements $ModeratorHomeEventCopyWith<$Res> {
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

/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? baristas = null,}) {
  return _then(NewBaristas(
null == baristas ? _self._baristas : baristas // ignore: cast_nullable_to_non_nullable
as List<Barista>,
  ));
}


}

/// @nodoc


class NewModerateQueueOrders implements ModeratorHomeEvent {
  const NewModerateQueueOrders(final  List<LatteOrderMetadata> metadatas): _metadatas = metadatas;
  

 final  List<LatteOrderMetadata> _metadatas;
 List<LatteOrderMetadata> get metadatas {
  if (_metadatas is EqualUnmodifiableListView) return _metadatas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_metadatas);
}


/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewModerateQueueOrdersCopyWith<NewModerateQueueOrders> get copyWith => _$NewModerateQueueOrdersCopyWithImpl<NewModerateQueueOrders>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewModerateQueueOrders&&const DeepCollectionEquality().equals(other._metadatas, _metadatas));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_metadatas));

@override
String toString() {
  return 'ModeratorHomeEvent.newModerateQueueOrders(metadatas: $metadatas)';
}


}

/// @nodoc
abstract mixin class $NewModerateQueueOrdersCopyWith<$Res> implements $ModeratorHomeEventCopyWith<$Res> {
  factory $NewModerateQueueOrdersCopyWith(NewModerateQueueOrders value, $Res Function(NewModerateQueueOrders) _then) = _$NewModerateQueueOrdersCopyWithImpl;
@useResult
$Res call({
 List<LatteOrderMetadata> metadatas
});




}
/// @nodoc
class _$NewModerateQueueOrdersCopyWithImpl<$Res>
    implements $NewModerateQueueOrdersCopyWith<$Res> {
  _$NewModerateQueueOrdersCopyWithImpl(this._self, this._then);

  final NewModerateQueueOrders _self;
  final $Res Function(NewModerateQueueOrders) _then;

/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? metadatas = null,}) {
  return _then(NewModerateQueueOrders(
null == metadatas ? _self._metadatas : metadatas // ignore: cast_nullable_to_non_nullable
as List<LatteOrderMetadata>,
  ));
}


}

/// @nodoc


class ApproveNameAndImage implements ModeratorHomeEvent {
  const ApproveNameAndImage(this.orderId);
  

 final  String orderId;

/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApproveNameAndImageCopyWith<ApproveNameAndImage> get copyWith => _$ApproveNameAndImageCopyWithImpl<ApproveNameAndImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveNameAndImage&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'ModeratorHomeEvent.approveNameAndImage(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $ApproveNameAndImageCopyWith<$Res> implements $ModeratorHomeEventCopyWith<$Res> {
  factory $ApproveNameAndImageCopyWith(ApproveNameAndImage value, $Res Function(ApproveNameAndImage) _then) = _$ApproveNameAndImageCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class _$ApproveNameAndImageCopyWithImpl<$Res>
    implements $ApproveNameAndImageCopyWith<$Res> {
  _$ApproveNameAndImageCopyWithImpl(this._self, this._then);

  final ApproveNameAndImage _self;
  final $Res Function(ApproveNameAndImage) _then;

/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(ApproveNameAndImage(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RejectNameApproveImage implements ModeratorHomeEvent {
  const RejectNameApproveImage(this.orderId);
  

 final  String orderId;

/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RejectNameApproveImageCopyWith<RejectNameApproveImage> get copyWith => _$RejectNameApproveImageCopyWithImpl<RejectNameApproveImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RejectNameApproveImage&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'ModeratorHomeEvent.rejectNameApproveImage(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $RejectNameApproveImageCopyWith<$Res> implements $ModeratorHomeEventCopyWith<$Res> {
  factory $RejectNameApproveImageCopyWith(RejectNameApproveImage value, $Res Function(RejectNameApproveImage) _then) = _$RejectNameApproveImageCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class _$RejectNameApproveImageCopyWithImpl<$Res>
    implements $RejectNameApproveImageCopyWith<$Res> {
  _$RejectNameApproveImageCopyWithImpl(this._self, this._then);

  final RejectNameApproveImage _self;
  final $Res Function(RejectNameApproveImage) _then;

/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(RejectNameApproveImage(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ApproveNameRejectImage implements ModeratorHomeEvent {
  const ApproveNameRejectImage(this.orderId);
  

 final  String orderId;

/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApproveNameRejectImageCopyWith<ApproveNameRejectImage> get copyWith => _$ApproveNameRejectImageCopyWithImpl<ApproveNameRejectImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveNameRejectImage&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'ModeratorHomeEvent.approveNameRejectImage(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $ApproveNameRejectImageCopyWith<$Res> implements $ModeratorHomeEventCopyWith<$Res> {
  factory $ApproveNameRejectImageCopyWith(ApproveNameRejectImage value, $Res Function(ApproveNameRejectImage) _then) = _$ApproveNameRejectImageCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class _$ApproveNameRejectImageCopyWithImpl<$Res>
    implements $ApproveNameRejectImageCopyWith<$Res> {
  _$ApproveNameRejectImageCopyWithImpl(this._self, this._then);

  final ApproveNameRejectImage _self;
  final $Res Function(ApproveNameRejectImage) _then;

/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(ApproveNameRejectImage(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RejectNameAndImage implements ModeratorHomeEvent {
  const RejectNameAndImage(this.orderId);
  

 final  String orderId;

/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RejectNameAndImageCopyWith<RejectNameAndImage> get copyWith => _$RejectNameAndImageCopyWithImpl<RejectNameAndImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RejectNameAndImage&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'ModeratorHomeEvent.rejectNameAndImage(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $RejectNameAndImageCopyWith<$Res> implements $ModeratorHomeEventCopyWith<$Res> {
  factory $RejectNameAndImageCopyWith(RejectNameAndImage value, $Res Function(RejectNameAndImage) _then) = _$RejectNameAndImageCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class _$RejectNameAndImageCopyWithImpl<$Res>
    implements $RejectNameAndImageCopyWith<$Res> {
  _$RejectNameAndImageCopyWithImpl(this._self, this._then);

  final RejectNameAndImage _self;
  final $Res Function(RejectNameAndImage) _then;

/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(RejectNameAndImage(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CompleteOrder implements ModeratorHomeEvent {
  const CompleteOrder(this.orderId);
  

 final  String orderId;

/// Create a copy of ModeratorHomeEvent
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
  return 'ModeratorHomeEvent.completeOrder(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $CompleteOrderCopyWith<$Res> implements $ModeratorHomeEventCopyWith<$Res> {
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

/// Create a copy of ModeratorHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(CompleteOrder(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ModeratorHomeState {

 List<Latte> get moderationQueue; Map<String, Barista> get baristas;
/// Create a copy of ModeratorHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModeratorHomeStateCopyWith<ModeratorHomeState> get copyWith => _$ModeratorHomeStateCopyWithImpl<ModeratorHomeState>(this as ModeratorHomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModeratorHomeState&&const DeepCollectionEquality().equals(other.moderationQueue, moderationQueue)&&const DeepCollectionEquality().equals(other.baristas, baristas));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(moderationQueue),const DeepCollectionEquality().hash(baristas));

@override
String toString() {
  return 'ModeratorHomeState(moderationQueue: $moderationQueue, baristas: $baristas)';
}


}

/// @nodoc
abstract mixin class $ModeratorHomeStateCopyWith<$Res>  {
  factory $ModeratorHomeStateCopyWith(ModeratorHomeState value, $Res Function(ModeratorHomeState) _then) = _$ModeratorHomeStateCopyWithImpl;
@useResult
$Res call({
 List<Latte> moderationQueue, Map<String, Barista> baristas
});




}
/// @nodoc
class _$ModeratorHomeStateCopyWithImpl<$Res>
    implements $ModeratorHomeStateCopyWith<$Res> {
  _$ModeratorHomeStateCopyWithImpl(this._self, this._then);

  final ModeratorHomeState _self;
  final $Res Function(ModeratorHomeState) _then;

/// Create a copy of ModeratorHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? moderationQueue = null,Object? baristas = null,}) {
  return _then(_self.copyWith(
moderationQueue: null == moderationQueue ? _self.moderationQueue : moderationQueue // ignore: cast_nullable_to_non_nullable
as List<Latte>,baristas: null == baristas ? _self.baristas : baristas // ignore: cast_nullable_to_non_nullable
as Map<String, Barista>,
  ));
}

}


/// Adds pattern-matching-related methods to [ModeratorHomeState].
extension ModeratorHomeStatePatterns on ModeratorHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModeratorHomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModeratorHomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModeratorHomeState value)  $default,){
final _that = this;
switch (_that) {
case _ModeratorHomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModeratorHomeState value)?  $default,){
final _that = this;
switch (_that) {
case _ModeratorHomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Latte> moderationQueue,  Map<String, Barista> baristas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModeratorHomeState() when $default != null:
return $default(_that.moderationQueue,_that.baristas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Latte> moderationQueue,  Map<String, Barista> baristas)  $default,) {final _that = this;
switch (_that) {
case _ModeratorHomeState():
return $default(_that.moderationQueue,_that.baristas);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Latte> moderationQueue,  Map<String, Barista> baristas)?  $default,) {final _that = this;
switch (_that) {
case _ModeratorHomeState() when $default != null:
return $default(_that.moderationQueue,_that.baristas);case _:
  return null;

}
}

}

/// @nodoc


class _ModeratorHomeState extends ModeratorHomeState {
  const _ModeratorHomeState({required final  List<Latte> moderationQueue, final  Map<String, Barista> baristas = const {}}): _moderationQueue = moderationQueue,_baristas = baristas,super._();
  

 final  List<Latte> _moderationQueue;
@override List<Latte> get moderationQueue {
  if (_moderationQueue is EqualUnmodifiableListView) return _moderationQueue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moderationQueue);
}

 final  Map<String, Barista> _baristas;
@override@JsonKey() Map<String, Barista> get baristas {
  if (_baristas is EqualUnmodifiableMapView) return _baristas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_baristas);
}


/// Create a copy of ModeratorHomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModeratorHomeStateCopyWith<_ModeratorHomeState> get copyWith => __$ModeratorHomeStateCopyWithImpl<_ModeratorHomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModeratorHomeState&&const DeepCollectionEquality().equals(other._moderationQueue, _moderationQueue)&&const DeepCollectionEquality().equals(other._baristas, _baristas));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_moderationQueue),const DeepCollectionEquality().hash(_baristas));

@override
String toString() {
  return 'ModeratorHomeState(moderationQueue: $moderationQueue, baristas: $baristas)';
}


}

/// @nodoc
abstract mixin class _$ModeratorHomeStateCopyWith<$Res> implements $ModeratorHomeStateCopyWith<$Res> {
  factory _$ModeratorHomeStateCopyWith(_ModeratorHomeState value, $Res Function(_ModeratorHomeState) _then) = __$ModeratorHomeStateCopyWithImpl;
@override @useResult
$Res call({
 List<Latte> moderationQueue, Map<String, Barista> baristas
});




}
/// @nodoc
class __$ModeratorHomeStateCopyWithImpl<$Res>
    implements _$ModeratorHomeStateCopyWith<$Res> {
  __$ModeratorHomeStateCopyWithImpl(this._self, this._then);

  final _ModeratorHomeState _self;
  final $Res Function(_ModeratorHomeState) _then;

/// Create a copy of ModeratorHomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? moderationQueue = null,Object? baristas = null,}) {
  return _then(_ModeratorHomeState(
moderationQueue: null == moderationQueue ? _self._moderationQueue : moderationQueue // ignore: cast_nullable_to_non_nullable
as List<Latte>,baristas: null == baristas ? _self._baristas : baristas // ignore: cast_nullable_to_non_nullable
as Map<String, Barista>,
  ));
}


}

// dart format on
