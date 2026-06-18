// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latte_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LatteOrder {

/// Firestore-generated document Id. Not a user-friendly identifier.
 String? get id;/// The name of the person ordering.
 String? get name;/// The coffee's milk type.
///
/// Null value for milk is not possible for a valid order, but is the
/// default order because the user must select a milk (as opposed to having
/// a default milk that they might overlook changing).
 String? get milk;/// The coffee's sweetener type, if any.
///
/// Null value for sweetener IS possible because no sweetener is allowed.
 String? get sweetener;/// The prompt for the user's generated image.
 String? get happyPlace;
/// Create a copy of LatteOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatteOrderCopyWith<LatteOrder> get copyWith => _$LatteOrderCopyWithImpl<LatteOrder>(this as LatteOrder, _$identity);

  /// Serializes this LatteOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatteOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.milk, milk) || other.milk == milk)&&(identical(other.sweetener, sweetener) || other.sweetener == sweetener)&&(identical(other.happyPlace, happyPlace) || other.happyPlace == happyPlace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,milk,sweetener,happyPlace);

@override
String toString() {
  return 'LatteOrder(id: $id, name: $name, milk: $milk, sweetener: $sweetener, happyPlace: $happyPlace)';
}


}

/// @nodoc
abstract mixin class $LatteOrderCopyWith<$Res>  {
  factory $LatteOrderCopyWith(LatteOrder value, $Res Function(LatteOrder) _then) = _$LatteOrderCopyWithImpl;
@useResult
$Res call({
 String? id, String? name, String? milk, String? sweetener, String? happyPlace
});




}
/// @nodoc
class _$LatteOrderCopyWithImpl<$Res>
    implements $LatteOrderCopyWith<$Res> {
  _$LatteOrderCopyWithImpl(this._self, this._then);

  final LatteOrder _self;
  final $Res Function(LatteOrder) _then;

/// Create a copy of LatteOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? milk = freezed,Object? sweetener = freezed,Object? happyPlace = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,milk: freezed == milk ? _self.milk : milk // ignore: cast_nullable_to_non_nullable
as String?,sweetener: freezed == sweetener ? _self.sweetener : sweetener // ignore: cast_nullable_to_non_nullable
as String?,happyPlace: freezed == happyPlace ? _self.happyPlace : happyPlace // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LatteOrder].
extension LatteOrderPatterns on LatteOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatteOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatteOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatteOrder value)  $default,){
final _that = this;
switch (_that) {
case _LatteOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatteOrder value)?  $default,){
final _that = this;
switch (_that) {
case _LatteOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? name,  String? milk,  String? sweetener,  String? happyPlace)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatteOrder() when $default != null:
return $default(_that.id,_that.name,_that.milk,_that.sweetener,_that.happyPlace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? name,  String? milk,  String? sweetener,  String? happyPlace)  $default,) {final _that = this;
switch (_that) {
case _LatteOrder():
return $default(_that.id,_that.name,_that.milk,_that.sweetener,_that.happyPlace);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? name,  String? milk,  String? sweetener,  String? happyPlace)?  $default,) {final _that = this;
switch (_that) {
case _LatteOrder() when $default != null:
return $default(_that.id,_that.name,_that.milk,_that.sweetener,_that.happyPlace);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatteOrder extends LatteOrder {
  const _LatteOrder({this.id, this.name, this.milk, this.sweetener, this.happyPlace}): super._();
  factory _LatteOrder.fromJson(Map<String, dynamic> json) => _$LatteOrderFromJson(json);

/// Firestore-generated document Id. Not a user-friendly identifier.
@override final  String? id;
/// The name of the person ordering.
@override final  String? name;
/// The coffee's milk type.
///
/// Null value for milk is not possible for a valid order, but is the
/// default order because the user must select a milk (as opposed to having
/// a default milk that they might overlook changing).
@override final  String? milk;
/// The coffee's sweetener type, if any.
///
/// Null value for sweetener IS possible because no sweetener is allowed.
@override final  String? sweetener;
/// The prompt for the user's generated image.
@override final  String? happyPlace;

/// Create a copy of LatteOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatteOrderCopyWith<_LatteOrder> get copyWith => __$LatteOrderCopyWithImpl<_LatteOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatteOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatteOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.milk, milk) || other.milk == milk)&&(identical(other.sweetener, sweetener) || other.sweetener == sweetener)&&(identical(other.happyPlace, happyPlace) || other.happyPlace == happyPlace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,milk,sweetener,happyPlace);

@override
String toString() {
  return 'LatteOrder(id: $id, name: $name, milk: $milk, sweetener: $sweetener, happyPlace: $happyPlace)';
}


}

/// @nodoc
abstract mixin class _$LatteOrderCopyWith<$Res> implements $LatteOrderCopyWith<$Res> {
  factory _$LatteOrderCopyWith(_LatteOrder value, $Res Function(_LatteOrder) _then) = __$LatteOrderCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name, String? milk, String? sweetener, String? happyPlace
});




}
/// @nodoc
class __$LatteOrderCopyWithImpl<$Res>
    implements _$LatteOrderCopyWith<$Res> {
  __$LatteOrderCopyWithImpl(this._self, this._then);

  final _LatteOrder _self;
  final $Res Function(_LatteOrder) _then;

/// Create a copy of LatteOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? milk = freezed,Object? sweetener = freezed,Object? happyPlace = freezed,}) {
  return _then(_LatteOrder(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,milk: freezed == milk ? _self.milk : milk // ignore: cast_nullable_to_non_nullable
as String?,sweetener: freezed == sweetener ? _self.sweetener : sweetener // ignore: cast_nullable_to_non_nullable
as String?,happyPlace: freezed == happyPlace ? _self.happyPlace : happyPlace // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LatteOrderMetadata {

/// Firestore-generated document Id. Not a user-friendly identifier.
/// This value is guaranteed to be the same as the corresponding
/// [LatteOrder.id].
 String? get id;/// Sequential order number, set by the server and visible in the queue.
 int? get orderNumber;/// Gemini sets this to false or true upon moderation. Baristas optionally
/// set this to true when advancing an order's status to
/// [LatteOrderStatus.validated]. Additionally, a value of `true` is
/// required for this user's name to be shown on the big boards.
 bool? get isNameApproved;/// Gemini sets this to false or true upon moderation. Image generation is
/// gated by Gemini setting this value to `true`. Later, baristas may
/// override this to `false` when advancing an order's status to
/// [LatteOrderStatus.validated]. If a barista does this, the user will
/// receive a fallback image on their latte.
 bool? get isHappyPlaceApproved;/// The reason Gemini rejected the user's happy place prompt. If the image
/// was moderated by the barista, then this value should say
/// "barista_moderation".
 String? get happyPlaceModerationReason;/// Set to true once a barista provides final manual approval of the image.
/// This value must be true for an [LatteOrder] to advance to
/// [LatteOrderStatus.inProgress].
 bool? get isImageApproved;/// The active image batch.
 String? get imageBatchId;/// Set once the user has committed to an image.
 String? get imageUrl;/// The reason an order was sent back from [LatteOrderStatus.submitted] to
/// [LatteOrderStatus.configuring] instead of being accepted and advanced to
/// [LatteOrderStatus.validated].
// LatteOrderValidationError? validationError,
/// {@macro LatteOrderStatus}
 LatteOrderStatus get status;/// Set to non-null once a barista claims the order.
 String? get baristaId;/// Set once the order status reaches [LatteOrderStatus.submitted].
 DateTime? get orderSubmittedTime;/// Set once the order status reaches [LatteOrderStatus.completed].
 DateTime? get completionTime;
/// Create a copy of LatteOrderMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatteOrderMetadataCopyWith<LatteOrderMetadata> get copyWith => _$LatteOrderMetadataCopyWithImpl<LatteOrderMetadata>(this as LatteOrderMetadata, _$identity);

  /// Serializes this LatteOrderMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatteOrderMetadata&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.isNameApproved, isNameApproved) || other.isNameApproved == isNameApproved)&&(identical(other.isHappyPlaceApproved, isHappyPlaceApproved) || other.isHappyPlaceApproved == isHappyPlaceApproved)&&(identical(other.happyPlaceModerationReason, happyPlaceModerationReason) || other.happyPlaceModerationReason == happyPlaceModerationReason)&&(identical(other.isImageApproved, isImageApproved) || other.isImageApproved == isImageApproved)&&(identical(other.imageBatchId, imageBatchId) || other.imageBatchId == imageBatchId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.baristaId, baristaId) || other.baristaId == baristaId)&&(identical(other.orderSubmittedTime, orderSubmittedTime) || other.orderSubmittedTime == orderSubmittedTime)&&(identical(other.completionTime, completionTime) || other.completionTime == completionTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,isNameApproved,isHappyPlaceApproved,happyPlaceModerationReason,isImageApproved,imageBatchId,imageUrl,status,baristaId,orderSubmittedTime,completionTime);

@override
String toString() {
  return 'LatteOrderMetadata(id: $id, orderNumber: $orderNumber, isNameApproved: $isNameApproved, isHappyPlaceApproved: $isHappyPlaceApproved, happyPlaceModerationReason: $happyPlaceModerationReason, isImageApproved: $isImageApproved, imageBatchId: $imageBatchId, imageUrl: $imageUrl, status: $status, baristaId: $baristaId, orderSubmittedTime: $orderSubmittedTime, completionTime: $completionTime)';
}


}

/// @nodoc
abstract mixin class $LatteOrderMetadataCopyWith<$Res>  {
  factory $LatteOrderMetadataCopyWith(LatteOrderMetadata value, $Res Function(LatteOrderMetadata) _then) = _$LatteOrderMetadataCopyWithImpl;
@useResult
$Res call({
 String? id, int? orderNumber, bool? isNameApproved, bool? isHappyPlaceApproved, String? happyPlaceModerationReason, bool? isImageApproved, String? imageBatchId, String? imageUrl, LatteOrderStatus status, String? baristaId, DateTime? orderSubmittedTime, DateTime? completionTime
});




}
/// @nodoc
class _$LatteOrderMetadataCopyWithImpl<$Res>
    implements $LatteOrderMetadataCopyWith<$Res> {
  _$LatteOrderMetadataCopyWithImpl(this._self, this._then);

  final LatteOrderMetadata _self;
  final $Res Function(LatteOrderMetadata) _then;

/// Create a copy of LatteOrderMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? orderNumber = freezed,Object? isNameApproved = freezed,Object? isHappyPlaceApproved = freezed,Object? happyPlaceModerationReason = freezed,Object? isImageApproved = freezed,Object? imageBatchId = freezed,Object? imageUrl = freezed,Object? status = null,Object? baristaId = freezed,Object? orderSubmittedTime = freezed,Object? completionTime = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,orderNumber: freezed == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as int?,isNameApproved: freezed == isNameApproved ? _self.isNameApproved : isNameApproved // ignore: cast_nullable_to_non_nullable
as bool?,isHappyPlaceApproved: freezed == isHappyPlaceApproved ? _self.isHappyPlaceApproved : isHappyPlaceApproved // ignore: cast_nullable_to_non_nullable
as bool?,happyPlaceModerationReason: freezed == happyPlaceModerationReason ? _self.happyPlaceModerationReason : happyPlaceModerationReason // ignore: cast_nullable_to_non_nullable
as String?,isImageApproved: freezed == isImageApproved ? _self.isImageApproved : isImageApproved // ignore: cast_nullable_to_non_nullable
as bool?,imageBatchId: freezed == imageBatchId ? _self.imageBatchId : imageBatchId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LatteOrderStatus,baristaId: freezed == baristaId ? _self.baristaId : baristaId // ignore: cast_nullable_to_non_nullable
as String?,orderSubmittedTime: freezed == orderSubmittedTime ? _self.orderSubmittedTime : orderSubmittedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,completionTime: freezed == completionTime ? _self.completionTime : completionTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LatteOrderMetadata].
extension LatteOrderMetadataPatterns on LatteOrderMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatteOrderMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatteOrderMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatteOrderMetadata value)  $default,){
final _that = this;
switch (_that) {
case _LatteOrderMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatteOrderMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _LatteOrderMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  int? orderNumber,  bool? isNameApproved,  bool? isHappyPlaceApproved,  String? happyPlaceModerationReason,  bool? isImageApproved,  String? imageBatchId,  String? imageUrl,  LatteOrderStatus status,  String? baristaId,  DateTime? orderSubmittedTime,  DateTime? completionTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatteOrderMetadata() when $default != null:
return $default(_that.id,_that.orderNumber,_that.isNameApproved,_that.isHappyPlaceApproved,_that.happyPlaceModerationReason,_that.isImageApproved,_that.imageBatchId,_that.imageUrl,_that.status,_that.baristaId,_that.orderSubmittedTime,_that.completionTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  int? orderNumber,  bool? isNameApproved,  bool? isHappyPlaceApproved,  String? happyPlaceModerationReason,  bool? isImageApproved,  String? imageBatchId,  String? imageUrl,  LatteOrderStatus status,  String? baristaId,  DateTime? orderSubmittedTime,  DateTime? completionTime)  $default,) {final _that = this;
switch (_that) {
case _LatteOrderMetadata():
return $default(_that.id,_that.orderNumber,_that.isNameApproved,_that.isHappyPlaceApproved,_that.happyPlaceModerationReason,_that.isImageApproved,_that.imageBatchId,_that.imageUrl,_that.status,_that.baristaId,_that.orderSubmittedTime,_that.completionTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  int? orderNumber,  bool? isNameApproved,  bool? isHappyPlaceApproved,  String? happyPlaceModerationReason,  bool? isImageApproved,  String? imageBatchId,  String? imageUrl,  LatteOrderStatus status,  String? baristaId,  DateTime? orderSubmittedTime,  DateTime? completionTime)?  $default,) {final _that = this;
switch (_that) {
case _LatteOrderMetadata() when $default != null:
return $default(_that.id,_that.orderNumber,_that.isNameApproved,_that.isHappyPlaceApproved,_that.happyPlaceModerationReason,_that.isImageApproved,_that.imageBatchId,_that.imageUrl,_that.status,_that.baristaId,_that.orderSubmittedTime,_that.completionTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatteOrderMetadata extends LatteOrderMetadata {
  const _LatteOrderMetadata({this.id, this.orderNumber, this.isNameApproved, this.isHappyPlaceApproved, this.happyPlaceModerationReason, this.isImageApproved, this.imageBatchId, this.imageUrl, this.status = LatteOrderStatus.configuring, this.baristaId, this.orderSubmittedTime, this.completionTime}): super._();
  factory _LatteOrderMetadata.fromJson(Map<String, dynamic> json) => _$LatteOrderMetadataFromJson(json);

/// Firestore-generated document Id. Not a user-friendly identifier.
/// This value is guaranteed to be the same as the corresponding
/// [LatteOrder.id].
@override final  String? id;
/// Sequential order number, set by the server and visible in the queue.
@override final  int? orderNumber;
/// Gemini sets this to false or true upon moderation. Baristas optionally
/// set this to true when advancing an order's status to
/// [LatteOrderStatus.validated]. Additionally, a value of `true` is
/// required for this user's name to be shown on the big boards.
@override final  bool? isNameApproved;
/// Gemini sets this to false or true upon moderation. Image generation is
/// gated by Gemini setting this value to `true`. Later, baristas may
/// override this to `false` when advancing an order's status to
/// [LatteOrderStatus.validated]. If a barista does this, the user will
/// receive a fallback image on their latte.
@override final  bool? isHappyPlaceApproved;
/// The reason Gemini rejected the user's happy place prompt. If the image
/// was moderated by the barista, then this value should say
/// "barista_moderation".
@override final  String? happyPlaceModerationReason;
/// Set to true once a barista provides final manual approval of the image.
/// This value must be true for an [LatteOrder] to advance to
/// [LatteOrderStatus.inProgress].
@override final  bool? isImageApproved;
/// The active image batch.
@override final  String? imageBatchId;
/// Set once the user has committed to an image.
@override final  String? imageUrl;
/// The reason an order was sent back from [LatteOrderStatus.submitted] to
/// [LatteOrderStatus.configuring] instead of being accepted and advanced to
/// [LatteOrderStatus.validated].
// LatteOrderValidationError? validationError,
/// {@macro LatteOrderStatus}
@override@JsonKey() final  LatteOrderStatus status;
/// Set to non-null once a barista claims the order.
@override final  String? baristaId;
/// Set once the order status reaches [LatteOrderStatus.submitted].
@override final  DateTime? orderSubmittedTime;
/// Set once the order status reaches [LatteOrderStatus.completed].
@override final  DateTime? completionTime;

/// Create a copy of LatteOrderMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatteOrderMetadataCopyWith<_LatteOrderMetadata> get copyWith => __$LatteOrderMetadataCopyWithImpl<_LatteOrderMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatteOrderMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatteOrderMetadata&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.isNameApproved, isNameApproved) || other.isNameApproved == isNameApproved)&&(identical(other.isHappyPlaceApproved, isHappyPlaceApproved) || other.isHappyPlaceApproved == isHappyPlaceApproved)&&(identical(other.happyPlaceModerationReason, happyPlaceModerationReason) || other.happyPlaceModerationReason == happyPlaceModerationReason)&&(identical(other.isImageApproved, isImageApproved) || other.isImageApproved == isImageApproved)&&(identical(other.imageBatchId, imageBatchId) || other.imageBatchId == imageBatchId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.baristaId, baristaId) || other.baristaId == baristaId)&&(identical(other.orderSubmittedTime, orderSubmittedTime) || other.orderSubmittedTime == orderSubmittedTime)&&(identical(other.completionTime, completionTime) || other.completionTime == completionTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,isNameApproved,isHappyPlaceApproved,happyPlaceModerationReason,isImageApproved,imageBatchId,imageUrl,status,baristaId,orderSubmittedTime,completionTime);

@override
String toString() {
  return 'LatteOrderMetadata(id: $id, orderNumber: $orderNumber, isNameApproved: $isNameApproved, isHappyPlaceApproved: $isHappyPlaceApproved, happyPlaceModerationReason: $happyPlaceModerationReason, isImageApproved: $isImageApproved, imageBatchId: $imageBatchId, imageUrl: $imageUrl, status: $status, baristaId: $baristaId, orderSubmittedTime: $orderSubmittedTime, completionTime: $completionTime)';
}


}

/// @nodoc
abstract mixin class _$LatteOrderMetadataCopyWith<$Res> implements $LatteOrderMetadataCopyWith<$Res> {
  factory _$LatteOrderMetadataCopyWith(_LatteOrderMetadata value, $Res Function(_LatteOrderMetadata) _then) = __$LatteOrderMetadataCopyWithImpl;
@override @useResult
$Res call({
 String? id, int? orderNumber, bool? isNameApproved, bool? isHappyPlaceApproved, String? happyPlaceModerationReason, bool? isImageApproved, String? imageBatchId, String? imageUrl, LatteOrderStatus status, String? baristaId, DateTime? orderSubmittedTime, DateTime? completionTime
});




}
/// @nodoc
class __$LatteOrderMetadataCopyWithImpl<$Res>
    implements _$LatteOrderMetadataCopyWith<$Res> {
  __$LatteOrderMetadataCopyWithImpl(this._self, this._then);

  final _LatteOrderMetadata _self;
  final $Res Function(_LatteOrderMetadata) _then;

/// Create a copy of LatteOrderMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? orderNumber = freezed,Object? isNameApproved = freezed,Object? isHappyPlaceApproved = freezed,Object? happyPlaceModerationReason = freezed,Object? isImageApproved = freezed,Object? imageBatchId = freezed,Object? imageUrl = freezed,Object? status = null,Object? baristaId = freezed,Object? orderSubmittedTime = freezed,Object? completionTime = freezed,}) {
  return _then(_LatteOrderMetadata(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,orderNumber: freezed == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as int?,isNameApproved: freezed == isNameApproved ? _self.isNameApproved : isNameApproved // ignore: cast_nullable_to_non_nullable
as bool?,isHappyPlaceApproved: freezed == isHappyPlaceApproved ? _self.isHappyPlaceApproved : isHappyPlaceApproved // ignore: cast_nullable_to_non_nullable
as bool?,happyPlaceModerationReason: freezed == happyPlaceModerationReason ? _self.happyPlaceModerationReason : happyPlaceModerationReason // ignore: cast_nullable_to_non_nullable
as String?,isImageApproved: freezed == isImageApproved ? _self.isImageApproved : isImageApproved // ignore: cast_nullable_to_non_nullable
as bool?,imageBatchId: freezed == imageBatchId ? _self.imageBatchId : imageBatchId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LatteOrderStatus,baristaId: freezed == baristaId ? _self.baristaId : baristaId // ignore: cast_nullable_to_non_nullable
as String?,orderSubmittedTime: freezed == orderSubmittedTime ? _self.orderSubmittedTime : orderSubmittedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,completionTime: freezed == completionTime ? _self.completionTime : completionTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Latte {

 LatteOrder get order; LatteOrderMetadata get metadata;
/// Create a copy of Latte
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatteCopyWith<Latte> get copyWith => _$LatteCopyWithImpl<Latte>(this as Latte, _$identity);

  /// Serializes this Latte to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Latte&&(identical(other.order, order) || other.order == order)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,metadata);

@override
String toString() {
  return 'Latte(order: $order, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $LatteCopyWith<$Res>  {
  factory $LatteCopyWith(Latte value, $Res Function(Latte) _then) = _$LatteCopyWithImpl;
@useResult
$Res call({
 LatteOrder order, LatteOrderMetadata metadata
});


$LatteOrderCopyWith<$Res> get order;$LatteOrderMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$LatteCopyWithImpl<$Res>
    implements $LatteCopyWith<$Res> {
  _$LatteCopyWithImpl(this._self, this._then);

  final Latte _self;
  final $Res Function(Latte) _then;

/// Create a copy of Latte
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as LatteOrder,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as LatteOrderMetadata,
  ));
}
/// Create a copy of Latte
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderCopyWith<$Res> get order {
  
  return $LatteOrderCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}/// Create a copy of Latte
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderMetadataCopyWith<$Res> get metadata {
  
  return $LatteOrderMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [Latte].
extension LattePatterns on Latte {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Latte value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Latte() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Latte value)  $default,){
final _that = this;
switch (_that) {
case _Latte():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Latte value)?  $default,){
final _that = this;
switch (_that) {
case _Latte() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LatteOrder order,  LatteOrderMetadata metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Latte() when $default != null:
return $default(_that.order,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LatteOrder order,  LatteOrderMetadata metadata)  $default,) {final _that = this;
switch (_that) {
case _Latte():
return $default(_that.order,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LatteOrder order,  LatteOrderMetadata metadata)?  $default,) {final _that = this;
switch (_that) {
case _Latte() when $default != null:
return $default(_that.order,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Latte extends Latte {
  const _Latte({required this.order, required this.metadata}): super._();
  factory _Latte.fromJson(Map<String, dynamic> json) => _$LatteFromJson(json);

@override final  LatteOrder order;
@override final  LatteOrderMetadata metadata;

/// Create a copy of Latte
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatteCopyWith<_Latte> get copyWith => __$LatteCopyWithImpl<_Latte>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Latte&&(identical(other.order, order) || other.order == order)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,metadata);

@override
String toString() {
  return 'Latte(order: $order, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$LatteCopyWith<$Res> implements $LatteCopyWith<$Res> {
  factory _$LatteCopyWith(_Latte value, $Res Function(_Latte) _then) = __$LatteCopyWithImpl;
@override @useResult
$Res call({
 LatteOrder order, LatteOrderMetadata metadata
});


@override $LatteOrderCopyWith<$Res> get order;@override $LatteOrderMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$LatteCopyWithImpl<$Res>
    implements _$LatteCopyWith<$Res> {
  __$LatteCopyWithImpl(this._self, this._then);

  final _Latte _self;
  final $Res Function(_Latte) _then;

/// Create a copy of Latte
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? metadata = null,}) {
  return _then(_Latte(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as LatteOrder,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as LatteOrderMetadata,
  ));
}

/// Create a copy of Latte
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderCopyWith<$Res> get order {
  
  return $LatteOrderCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}/// Create a copy of Latte
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderMetadataCopyWith<$Res> get metadata {
  
  return $LatteOrderMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
