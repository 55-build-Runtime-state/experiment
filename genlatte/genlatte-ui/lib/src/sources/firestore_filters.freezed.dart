// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
OrdersFilter _$OrdersFilterFromJson(
  Map<String, dynamic> json
) {
    return IncompleteFilter.fromJson(
      json
    );
}

/// @nodoc
mixin _$OrdersFilter {



  /// Serializes this OrdersFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersFilter);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrdersFilter()';
}


}

/// @nodoc
class $OrdersFilterCopyWith<$Res>  {
$OrdersFilterCopyWith(OrdersFilter _, $Res Function(OrdersFilter) __);
}


/// Adds pattern-matching-related methods to [OrdersFilter].
extension OrdersFilterPatterns on OrdersFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( IncompleteFilter value)?  incompleteOrders,required TResult orElse(),}){
final _that = this;
switch (_that) {
case IncompleteFilter() when incompleteOrders != null:
return incompleteOrders(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( IncompleteFilter value)  incompleteOrders,}){
final _that = this;
switch (_that) {
case IncompleteFilter():
return incompleteOrders(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( IncompleteFilter value)?  incompleteOrders,}){
final _that = this;
switch (_that) {
case IncompleteFilter() when incompleteOrders != null:
return incompleteOrders(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  incompleteOrders,required TResult orElse(),}) {final _that = this;
switch (_that) {
case IncompleteFilter() when incompleteOrders != null:
return incompleteOrders();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  incompleteOrders,}) {final _that = this;
switch (_that) {
case IncompleteFilter():
return incompleteOrders();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  incompleteOrders,}) {final _that = this;
switch (_that) {
case IncompleteFilter() when incompleteOrders != null:
return incompleteOrders();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class IncompleteFilter extends OrdersFilter {
  const IncompleteFilter(): super._();
  factory IncompleteFilter.fromJson(Map<String, dynamic> json) => _$IncompleteFilterFromJson(json);




@override
Map<String, dynamic> toJson() {
  return _$IncompleteFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncompleteFilter);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrdersFilter.incompleteOrders()';
}


}




// dart format on
