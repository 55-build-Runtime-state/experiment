// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QueueHomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueHomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueHomeEvent()';
}


}

/// @nodoc
class $QueueHomeEventCopyWith<$Res>  {
$QueueHomeEventCopyWith(QueueHomeEvent _, $Res Function(QueueHomeEvent) __);
}


/// Adds pattern-matching-related methods to [QueueHomeEvent].
extension QueueHomeEventPatterns on QueueHomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrdersUpdated value)?  ordersUpdated,TResult Function( RefreshPages value)?  refreshPages,TResult Function( SetPageUpdatePeriod value)?  setPageUpdatePeriod,TResult Function( SetRecency value)?  setRecency,TResult Function( SetShard value)?  setShard,TResult Function( SetTargetRowHeight value)?  setTargetRowHeight,TResult Function( SetTopSettings value)?  setTopSettings,TResult Function( SlotsCounted value)?  slotsCounted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrdersUpdated() when ordersUpdated != null:
return ordersUpdated(_that);case RefreshPages() when refreshPages != null:
return refreshPages(_that);case SetPageUpdatePeriod() when setPageUpdatePeriod != null:
return setPageUpdatePeriod(_that);case SetRecency() when setRecency != null:
return setRecency(_that);case SetShard() when setShard != null:
return setShard(_that);case SetTargetRowHeight() when setTargetRowHeight != null:
return setTargetRowHeight(_that);case SetTopSettings() when setTopSettings != null:
return setTopSettings(_that);case SlotsCounted() when slotsCounted != null:
return slotsCounted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrdersUpdated value)  ordersUpdated,required TResult Function( RefreshPages value)  refreshPages,required TResult Function( SetPageUpdatePeriod value)  setPageUpdatePeriod,required TResult Function( SetRecency value)  setRecency,required TResult Function( SetShard value)  setShard,required TResult Function( SetTargetRowHeight value)  setTargetRowHeight,required TResult Function( SetTopSettings value)  setTopSettings,required TResult Function( SlotsCounted value)  slotsCounted,}){
final _that = this;
switch (_that) {
case OrdersUpdated():
return ordersUpdated(_that);case RefreshPages():
return refreshPages(_that);case SetPageUpdatePeriod():
return setPageUpdatePeriod(_that);case SetRecency():
return setRecency(_that);case SetShard():
return setShard(_that);case SetTargetRowHeight():
return setTargetRowHeight(_that);case SetTopSettings():
return setTopSettings(_that);case SlotsCounted():
return slotsCounted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrdersUpdated value)?  ordersUpdated,TResult? Function( RefreshPages value)?  refreshPages,TResult? Function( SetPageUpdatePeriod value)?  setPageUpdatePeriod,TResult? Function( SetRecency value)?  setRecency,TResult? Function( SetShard value)?  setShard,TResult? Function( SetTargetRowHeight value)?  setTargetRowHeight,TResult? Function( SetTopSettings value)?  setTopSettings,TResult? Function( SlotsCounted value)?  slotsCounted,}){
final _that = this;
switch (_that) {
case OrdersUpdated() when ordersUpdated != null:
return ordersUpdated(_that);case RefreshPages() when refreshPages != null:
return refreshPages(_that);case SetPageUpdatePeriod() when setPageUpdatePeriod != null:
return setPageUpdatePeriod(_that);case SetRecency() when setRecency != null:
return setRecency(_that);case SetShard() when setShard != null:
return setShard(_that);case SetTargetRowHeight() when setTargetRowHeight != null:
return setTargetRowHeight(_that);case SetTopSettings() when setTopSettings != null:
return setTopSettings(_that);case SlotsCounted() when slotsCounted != null:
return slotsCounted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<LatteOrderMetadata> metadatas)?  ordersUpdated,TResult Function()?  refreshPages,TResult Function( Duration pageUpdatePeriod)?  setPageUpdatePeriod,TResult Function( Duration maxRecentAge,  Duration maxShowAge)?  setRecency,TResult Function( int shardNumber,  int shardTotal)?  setShard,TResult Function( double height)?  setTargetRowHeight,TResult Function( bool isTopScreen,  int topOrdersCount)?  setTopSettings,TResult Function( int slotCount)?  slotsCounted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrdersUpdated() when ordersUpdated != null:
return ordersUpdated(_that.metadatas);case RefreshPages() when refreshPages != null:
return refreshPages();case SetPageUpdatePeriod() when setPageUpdatePeriod != null:
return setPageUpdatePeriod(_that.pageUpdatePeriod);case SetRecency() when setRecency != null:
return setRecency(_that.maxRecentAge,_that.maxShowAge);case SetShard() when setShard != null:
return setShard(_that.shardNumber,_that.shardTotal);case SetTargetRowHeight() when setTargetRowHeight != null:
return setTargetRowHeight(_that.height);case SetTopSettings() when setTopSettings != null:
return setTopSettings(_that.isTopScreen,_that.topOrdersCount);case SlotsCounted() when slotsCounted != null:
return slotsCounted(_that.slotCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<LatteOrderMetadata> metadatas)  ordersUpdated,required TResult Function()  refreshPages,required TResult Function( Duration pageUpdatePeriod)  setPageUpdatePeriod,required TResult Function( Duration maxRecentAge,  Duration maxShowAge)  setRecency,required TResult Function( int shardNumber,  int shardTotal)  setShard,required TResult Function( double height)  setTargetRowHeight,required TResult Function( bool isTopScreen,  int topOrdersCount)  setTopSettings,required TResult Function( int slotCount)  slotsCounted,}) {final _that = this;
switch (_that) {
case OrdersUpdated():
return ordersUpdated(_that.metadatas);case RefreshPages():
return refreshPages();case SetPageUpdatePeriod():
return setPageUpdatePeriod(_that.pageUpdatePeriod);case SetRecency():
return setRecency(_that.maxRecentAge,_that.maxShowAge);case SetShard():
return setShard(_that.shardNumber,_that.shardTotal);case SetTargetRowHeight():
return setTargetRowHeight(_that.height);case SetTopSettings():
return setTopSettings(_that.isTopScreen,_that.topOrdersCount);case SlotsCounted():
return slotsCounted(_that.slotCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<LatteOrderMetadata> metadatas)?  ordersUpdated,TResult? Function()?  refreshPages,TResult? Function( Duration pageUpdatePeriod)?  setPageUpdatePeriod,TResult? Function( Duration maxRecentAge,  Duration maxShowAge)?  setRecency,TResult? Function( int shardNumber,  int shardTotal)?  setShard,TResult? Function( double height)?  setTargetRowHeight,TResult? Function( bool isTopScreen,  int topOrdersCount)?  setTopSettings,TResult? Function( int slotCount)?  slotsCounted,}) {final _that = this;
switch (_that) {
case OrdersUpdated() when ordersUpdated != null:
return ordersUpdated(_that.metadatas);case RefreshPages() when refreshPages != null:
return refreshPages();case SetPageUpdatePeriod() when setPageUpdatePeriod != null:
return setPageUpdatePeriod(_that.pageUpdatePeriod);case SetRecency() when setRecency != null:
return setRecency(_that.maxRecentAge,_that.maxShowAge);case SetShard() when setShard != null:
return setShard(_that.shardNumber,_that.shardTotal);case SetTargetRowHeight() when setTargetRowHeight != null:
return setTargetRowHeight(_that.height);case SetTopSettings() when setTopSettings != null:
return setTopSettings(_that.isTopScreen,_that.topOrdersCount);case SlotsCounted() when slotsCounted != null:
return slotsCounted(_that.slotCount);case _:
  return null;

}
}

}

/// @nodoc


class OrdersUpdated implements QueueHomeEvent {
  const OrdersUpdated(final  List<LatteOrderMetadata> metadatas): _metadatas = metadatas;
  

 final  List<LatteOrderMetadata> _metadatas;
 List<LatteOrderMetadata> get metadatas {
  if (_metadatas is EqualUnmodifiableListView) return _metadatas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_metadatas);
}


/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrdersUpdatedCopyWith<OrdersUpdated> get copyWith => _$OrdersUpdatedCopyWithImpl<OrdersUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersUpdated&&const DeepCollectionEquality().equals(other._metadatas, _metadatas));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_metadatas));

@override
String toString() {
  return 'QueueHomeEvent.ordersUpdated(metadatas: $metadatas)';
}


}

/// @nodoc
abstract mixin class $OrdersUpdatedCopyWith<$Res> implements $QueueHomeEventCopyWith<$Res> {
  factory $OrdersUpdatedCopyWith(OrdersUpdated value, $Res Function(OrdersUpdated) _then) = _$OrdersUpdatedCopyWithImpl;
@useResult
$Res call({
 List<LatteOrderMetadata> metadatas
});




}
/// @nodoc
class _$OrdersUpdatedCopyWithImpl<$Res>
    implements $OrdersUpdatedCopyWith<$Res> {
  _$OrdersUpdatedCopyWithImpl(this._self, this._then);

  final OrdersUpdated _self;
  final $Res Function(OrdersUpdated) _then;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? metadatas = null,}) {
  return _then(OrdersUpdated(
null == metadatas ? _self._metadatas : metadatas // ignore: cast_nullable_to_non_nullable
as List<LatteOrderMetadata>,
  ));
}


}

/// @nodoc


class RefreshPages implements QueueHomeEvent {
  const RefreshPages();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshPages);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueHomeEvent.refreshPages()';
}


}




/// @nodoc


class SetPageUpdatePeriod implements QueueHomeEvent {
  const SetPageUpdatePeriod(this.pageUpdatePeriod);
  

 final  Duration pageUpdatePeriod;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetPageUpdatePeriodCopyWith<SetPageUpdatePeriod> get copyWith => _$SetPageUpdatePeriodCopyWithImpl<SetPageUpdatePeriod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetPageUpdatePeriod&&(identical(other.pageUpdatePeriod, pageUpdatePeriod) || other.pageUpdatePeriod == pageUpdatePeriod));
}


@override
int get hashCode => Object.hash(runtimeType,pageUpdatePeriod);

@override
String toString() {
  return 'QueueHomeEvent.setPageUpdatePeriod(pageUpdatePeriod: $pageUpdatePeriod)';
}


}

/// @nodoc
abstract mixin class $SetPageUpdatePeriodCopyWith<$Res> implements $QueueHomeEventCopyWith<$Res> {
  factory $SetPageUpdatePeriodCopyWith(SetPageUpdatePeriod value, $Res Function(SetPageUpdatePeriod) _then) = _$SetPageUpdatePeriodCopyWithImpl;
@useResult
$Res call({
 Duration pageUpdatePeriod
});




}
/// @nodoc
class _$SetPageUpdatePeriodCopyWithImpl<$Res>
    implements $SetPageUpdatePeriodCopyWith<$Res> {
  _$SetPageUpdatePeriodCopyWithImpl(this._self, this._then);

  final SetPageUpdatePeriod _self;
  final $Res Function(SetPageUpdatePeriod) _then;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pageUpdatePeriod = null,}) {
  return _then(SetPageUpdatePeriod(
null == pageUpdatePeriod ? _self.pageUpdatePeriod : pageUpdatePeriod // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc


class SetRecency implements QueueHomeEvent {
  const SetRecency(this.maxRecentAge, this.maxShowAge);
  

 final  Duration maxRecentAge;
 final  Duration maxShowAge;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetRecencyCopyWith<SetRecency> get copyWith => _$SetRecencyCopyWithImpl<SetRecency>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetRecency&&(identical(other.maxRecentAge, maxRecentAge) || other.maxRecentAge == maxRecentAge)&&(identical(other.maxShowAge, maxShowAge) || other.maxShowAge == maxShowAge));
}


@override
int get hashCode => Object.hash(runtimeType,maxRecentAge,maxShowAge);

@override
String toString() {
  return 'QueueHomeEvent.setRecency(maxRecentAge: $maxRecentAge, maxShowAge: $maxShowAge)';
}


}

/// @nodoc
abstract mixin class $SetRecencyCopyWith<$Res> implements $QueueHomeEventCopyWith<$Res> {
  factory $SetRecencyCopyWith(SetRecency value, $Res Function(SetRecency) _then) = _$SetRecencyCopyWithImpl;
@useResult
$Res call({
 Duration maxRecentAge, Duration maxShowAge
});




}
/// @nodoc
class _$SetRecencyCopyWithImpl<$Res>
    implements $SetRecencyCopyWith<$Res> {
  _$SetRecencyCopyWithImpl(this._self, this._then);

  final SetRecency _self;
  final $Res Function(SetRecency) _then;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? maxRecentAge = null,Object? maxShowAge = null,}) {
  return _then(SetRecency(
null == maxRecentAge ? _self.maxRecentAge : maxRecentAge // ignore: cast_nullable_to_non_nullable
as Duration,null == maxShowAge ? _self.maxShowAge : maxShowAge // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc


class SetShard implements QueueHomeEvent {
  const SetShard(this.shardNumber, this.shardTotal);
  

 final  int shardNumber;
 final  int shardTotal;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetShardCopyWith<SetShard> get copyWith => _$SetShardCopyWithImpl<SetShard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetShard&&(identical(other.shardNumber, shardNumber) || other.shardNumber == shardNumber)&&(identical(other.shardTotal, shardTotal) || other.shardTotal == shardTotal));
}


@override
int get hashCode => Object.hash(runtimeType,shardNumber,shardTotal);

@override
String toString() {
  return 'QueueHomeEvent.setShard(shardNumber: $shardNumber, shardTotal: $shardTotal)';
}


}

/// @nodoc
abstract mixin class $SetShardCopyWith<$Res> implements $QueueHomeEventCopyWith<$Res> {
  factory $SetShardCopyWith(SetShard value, $Res Function(SetShard) _then) = _$SetShardCopyWithImpl;
@useResult
$Res call({
 int shardNumber, int shardTotal
});




}
/// @nodoc
class _$SetShardCopyWithImpl<$Res>
    implements $SetShardCopyWith<$Res> {
  _$SetShardCopyWithImpl(this._self, this._then);

  final SetShard _self;
  final $Res Function(SetShard) _then;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shardNumber = null,Object? shardTotal = null,}) {
  return _then(SetShard(
null == shardNumber ? _self.shardNumber : shardNumber // ignore: cast_nullable_to_non_nullable
as int,null == shardTotal ? _self.shardTotal : shardTotal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SetTargetRowHeight implements QueueHomeEvent {
  const SetTargetRowHeight(this.height);
  

 final  double height;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetTargetRowHeightCopyWith<SetTargetRowHeight> get copyWith => _$SetTargetRowHeightCopyWithImpl<SetTargetRowHeight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetTargetRowHeight&&(identical(other.height, height) || other.height == height));
}


@override
int get hashCode => Object.hash(runtimeType,height);

@override
String toString() {
  return 'QueueHomeEvent.setTargetRowHeight(height: $height)';
}


}

/// @nodoc
abstract mixin class $SetTargetRowHeightCopyWith<$Res> implements $QueueHomeEventCopyWith<$Res> {
  factory $SetTargetRowHeightCopyWith(SetTargetRowHeight value, $Res Function(SetTargetRowHeight) _then) = _$SetTargetRowHeightCopyWithImpl;
@useResult
$Res call({
 double height
});




}
/// @nodoc
class _$SetTargetRowHeightCopyWithImpl<$Res>
    implements $SetTargetRowHeightCopyWith<$Res> {
  _$SetTargetRowHeightCopyWithImpl(this._self, this._then);

  final SetTargetRowHeight _self;
  final $Res Function(SetTargetRowHeight) _then;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? height = null,}) {
  return _then(SetTargetRowHeight(
null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class SetTopSettings implements QueueHomeEvent {
  const SetTopSettings({required this.isTopScreen, required this.topOrdersCount});
  

 final  bool isTopScreen;
 final  int topOrdersCount;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetTopSettingsCopyWith<SetTopSettings> get copyWith => _$SetTopSettingsCopyWithImpl<SetTopSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetTopSettings&&(identical(other.isTopScreen, isTopScreen) || other.isTopScreen == isTopScreen)&&(identical(other.topOrdersCount, topOrdersCount) || other.topOrdersCount == topOrdersCount));
}


@override
int get hashCode => Object.hash(runtimeType,isTopScreen,topOrdersCount);

@override
String toString() {
  return 'QueueHomeEvent.setTopSettings(isTopScreen: $isTopScreen, topOrdersCount: $topOrdersCount)';
}


}

/// @nodoc
abstract mixin class $SetTopSettingsCopyWith<$Res> implements $QueueHomeEventCopyWith<$Res> {
  factory $SetTopSettingsCopyWith(SetTopSettings value, $Res Function(SetTopSettings) _then) = _$SetTopSettingsCopyWithImpl;
@useResult
$Res call({
 bool isTopScreen, int topOrdersCount
});




}
/// @nodoc
class _$SetTopSettingsCopyWithImpl<$Res>
    implements $SetTopSettingsCopyWith<$Res> {
  _$SetTopSettingsCopyWithImpl(this._self, this._then);

  final SetTopSettings _self;
  final $Res Function(SetTopSettings) _then;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isTopScreen = null,Object? topOrdersCount = null,}) {
  return _then(SetTopSettings(
isTopScreen: null == isTopScreen ? _self.isTopScreen : isTopScreen // ignore: cast_nullable_to_non_nullable
as bool,topOrdersCount: null == topOrdersCount ? _self.topOrdersCount : topOrdersCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SlotsCounted implements QueueHomeEvent {
  const SlotsCounted(this.slotCount);
  

 final  int slotCount;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotsCountedCopyWith<SlotsCounted> get copyWith => _$SlotsCountedCopyWithImpl<SlotsCounted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotsCounted&&(identical(other.slotCount, slotCount) || other.slotCount == slotCount));
}


@override
int get hashCode => Object.hash(runtimeType,slotCount);

@override
String toString() {
  return 'QueueHomeEvent.slotsCounted(slotCount: $slotCount)';
}


}

/// @nodoc
abstract mixin class $SlotsCountedCopyWith<$Res> implements $QueueHomeEventCopyWith<$Res> {
  factory $SlotsCountedCopyWith(SlotsCounted value, $Res Function(SlotsCounted) _then) = _$SlotsCountedCopyWithImpl;
@useResult
$Res call({
 int slotCount
});




}
/// @nodoc
class _$SlotsCountedCopyWithImpl<$Res>
    implements $SlotsCountedCopyWith<$Res> {
  _$SlotsCountedCopyWithImpl(this._self, this._then);

  final SlotsCounted _self;
  final $Res Function(SlotsCounted) _then;

/// Create a copy of QueueHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? slotCount = null,}) {
  return _then(SlotsCounted(
null == slotCount ? _self.slotCount : slotCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$QueueHomeState {

/// The setup of the queue. Persisted.
 QueueSettingsState get settings;/// The number of orders that the UI can show at a time. Depends on screen
/// configuration, and informs how many orders will be in each [OrderPage].
 int get uiSlotCapacity;/// The orders to show. Will be split into pages by [uiSlotCapacity].
 List<OrderPage> get shownPages;/// When this is true, we know that no orders are currently in the pipeline.
/// This is different from simply no orders being available
/// for _this shard_. The UI can show a message or a "screen saver".
 bool get noOrdersInAnyShard;
/// Create a copy of QueueHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueHomeStateCopyWith<QueueHomeState> get copyWith => _$QueueHomeStateCopyWithImpl<QueueHomeState>(this as QueueHomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueHomeState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.uiSlotCapacity, uiSlotCapacity) || other.uiSlotCapacity == uiSlotCapacity)&&const DeepCollectionEquality().equals(other.shownPages, shownPages)&&(identical(other.noOrdersInAnyShard, noOrdersInAnyShard) || other.noOrdersInAnyShard == noOrdersInAnyShard));
}


@override
int get hashCode => Object.hash(runtimeType,settings,uiSlotCapacity,const DeepCollectionEquality().hash(shownPages),noOrdersInAnyShard);

@override
String toString() {
  return 'QueueHomeState(settings: $settings, uiSlotCapacity: $uiSlotCapacity, shownPages: $shownPages, noOrdersInAnyShard: $noOrdersInAnyShard)';
}


}

/// @nodoc
abstract mixin class $QueueHomeStateCopyWith<$Res>  {
  factory $QueueHomeStateCopyWith(QueueHomeState value, $Res Function(QueueHomeState) _then) = _$QueueHomeStateCopyWithImpl;
@useResult
$Res call({
 QueueSettingsState settings, int uiSlotCapacity, List<OrderPage> shownPages, bool noOrdersInAnyShard
});


$QueueSettingsStateCopyWith<$Res> get settings;

}
/// @nodoc
class _$QueueHomeStateCopyWithImpl<$Res>
    implements $QueueHomeStateCopyWith<$Res> {
  _$QueueHomeStateCopyWithImpl(this._self, this._then);

  final QueueHomeState _self;
  final $Res Function(QueueHomeState) _then;

/// Create a copy of QueueHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? uiSlotCapacity = null,Object? shownPages = null,Object? noOrdersInAnyShard = null,}) {
  return _then(_self.copyWith(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as QueueSettingsState,uiSlotCapacity: null == uiSlotCapacity ? _self.uiSlotCapacity : uiSlotCapacity // ignore: cast_nullable_to_non_nullable
as int,shownPages: null == shownPages ? _self.shownPages : shownPages // ignore: cast_nullable_to_non_nullable
as List<OrderPage>,noOrdersInAnyShard: null == noOrdersInAnyShard ? _self.noOrdersInAnyShard : noOrdersInAnyShard // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of QueueHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueSettingsStateCopyWith<$Res> get settings {
  
  return $QueueSettingsStateCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// Adds pattern-matching-related methods to [QueueHomeState].
extension QueueHomeStatePatterns on QueueHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueHomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueHomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueHomeState value)  $default,){
final _that = this;
switch (_that) {
case _QueueHomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueHomeState value)?  $default,){
final _that = this;
switch (_that) {
case _QueueHomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QueueSettingsState settings,  int uiSlotCapacity,  List<OrderPage> shownPages,  bool noOrdersInAnyShard)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueHomeState() when $default != null:
return $default(_that.settings,_that.uiSlotCapacity,_that.shownPages,_that.noOrdersInAnyShard);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QueueSettingsState settings,  int uiSlotCapacity,  List<OrderPage> shownPages,  bool noOrdersInAnyShard)  $default,) {final _that = this;
switch (_that) {
case _QueueHomeState():
return $default(_that.settings,_that.uiSlotCapacity,_that.shownPages,_that.noOrdersInAnyShard);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QueueSettingsState settings,  int uiSlotCapacity,  List<OrderPage> shownPages,  bool noOrdersInAnyShard)?  $default,) {final _that = this;
switch (_that) {
case _QueueHomeState() when $default != null:
return $default(_that.settings,_that.uiSlotCapacity,_that.shownPages,_that.noOrdersInAnyShard);case _:
  return null;

}
}

}

/// @nodoc


class _QueueHomeState extends QueueHomeState {
  const _QueueHomeState({required this.settings, this.uiSlotCapacity = 0, final  List<OrderPage> shownPages = const [], this.noOrdersInAnyShard = false}): _shownPages = shownPages,super._();
  

/// The setup of the queue. Persisted.
@override final  QueueSettingsState settings;
/// The number of orders that the UI can show at a time. Depends on screen
/// configuration, and informs how many orders will be in each [OrderPage].
@override@JsonKey() final  int uiSlotCapacity;
/// The orders to show. Will be split into pages by [uiSlotCapacity].
 final  List<OrderPage> _shownPages;
/// The orders to show. Will be split into pages by [uiSlotCapacity].
@override@JsonKey() List<OrderPage> get shownPages {
  if (_shownPages is EqualUnmodifiableListView) return _shownPages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shownPages);
}

/// When this is true, we know that no orders are currently in the pipeline.
/// This is different from simply no orders being available
/// for _this shard_. The UI can show a message or a "screen saver".
@override@JsonKey() final  bool noOrdersInAnyShard;

/// Create a copy of QueueHomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueHomeStateCopyWith<_QueueHomeState> get copyWith => __$QueueHomeStateCopyWithImpl<_QueueHomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueHomeState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.uiSlotCapacity, uiSlotCapacity) || other.uiSlotCapacity == uiSlotCapacity)&&const DeepCollectionEquality().equals(other._shownPages, _shownPages)&&(identical(other.noOrdersInAnyShard, noOrdersInAnyShard) || other.noOrdersInAnyShard == noOrdersInAnyShard));
}


@override
int get hashCode => Object.hash(runtimeType,settings,uiSlotCapacity,const DeepCollectionEquality().hash(_shownPages),noOrdersInAnyShard);

@override
String toString() {
  return 'QueueHomeState(settings: $settings, uiSlotCapacity: $uiSlotCapacity, shownPages: $shownPages, noOrdersInAnyShard: $noOrdersInAnyShard)';
}


}

/// @nodoc
abstract mixin class _$QueueHomeStateCopyWith<$Res> implements $QueueHomeStateCopyWith<$Res> {
  factory _$QueueHomeStateCopyWith(_QueueHomeState value, $Res Function(_QueueHomeState) _then) = __$QueueHomeStateCopyWithImpl;
@override @useResult
$Res call({
 QueueSettingsState settings, int uiSlotCapacity, List<OrderPage> shownPages, bool noOrdersInAnyShard
});


@override $QueueSettingsStateCopyWith<$Res> get settings;

}
/// @nodoc
class __$QueueHomeStateCopyWithImpl<$Res>
    implements _$QueueHomeStateCopyWith<$Res> {
  __$QueueHomeStateCopyWithImpl(this._self, this._then);

  final _QueueHomeState _self;
  final $Res Function(_QueueHomeState) _then;

/// Create a copy of QueueHomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? uiSlotCapacity = null,Object? shownPages = null,Object? noOrdersInAnyShard = null,}) {
  return _then(_QueueHomeState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as QueueSettingsState,uiSlotCapacity: null == uiSlotCapacity ? _self.uiSlotCapacity : uiSlotCapacity // ignore: cast_nullable_to_non_nullable
as int,shownPages: null == shownPages ? _self._shownPages : shownPages // ignore: cast_nullable_to_non_nullable
as List<OrderPage>,noOrdersInAnyShard: null == noOrdersInAnyShard ? _self.noOrdersInAnyShard : noOrdersInAnyShard // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of QueueHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueSettingsStateCopyWith<$Res> get settings {
  
  return $QueueSettingsStateCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
