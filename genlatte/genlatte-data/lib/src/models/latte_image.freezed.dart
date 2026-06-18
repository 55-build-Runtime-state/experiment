// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latte_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LatteImageBatch {

 String get id; String get orderId;@LatteImageConverter() LatteImage? get image0;@LatteImageConverter() LatteImage? get image1;@LatteImageConverter() LatteImage? get image2;@LatteImageConverter() LatteImage? get image3;@LatteImageBatchParentConverter() LatteImageBatchParent? get parent;
/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatteImageBatchCopyWith<LatteImageBatch> get copyWith => _$LatteImageBatchCopyWithImpl<LatteImageBatch>(this as LatteImageBatch, _$identity);

  /// Serializes this LatteImageBatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatteImageBatch&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.image0, image0) || other.image0 == image0)&&(identical(other.image1, image1) || other.image1 == image1)&&(identical(other.image2, image2) || other.image2 == image2)&&(identical(other.image3, image3) || other.image3 == image3)&&(identical(other.parent, parent) || other.parent == parent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,image0,image1,image2,image3,parent);

@override
String toString() {
  return 'LatteImageBatch(id: $id, orderId: $orderId, image0: $image0, image1: $image1, image2: $image2, image3: $image3, parent: $parent)';
}


}

/// @nodoc
abstract mixin class $LatteImageBatchCopyWith<$Res>  {
  factory $LatteImageBatchCopyWith(LatteImageBatch value, $Res Function(LatteImageBatch) _then) = _$LatteImageBatchCopyWithImpl;
@useResult
$Res call({
 String id, String orderId,@LatteImageConverter() LatteImage? image0,@LatteImageConverter() LatteImage? image1,@LatteImageConverter() LatteImage? image2,@LatteImageConverter() LatteImage? image3,@LatteImageBatchParentConverter() LatteImageBatchParent? parent
});


$LatteImageCopyWith<$Res>? get image0;$LatteImageCopyWith<$Res>? get image1;$LatteImageCopyWith<$Res>? get image2;$LatteImageCopyWith<$Res>? get image3;$LatteImageBatchParentCopyWith<$Res>? get parent;

}
/// @nodoc
class _$LatteImageBatchCopyWithImpl<$Res>
    implements $LatteImageBatchCopyWith<$Res> {
  _$LatteImageBatchCopyWithImpl(this._self, this._then);

  final LatteImageBatch _self;
  final $Res Function(LatteImageBatch) _then;

/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? image0 = freezed,Object? image1 = freezed,Object? image2 = freezed,Object? image3 = freezed,Object? parent = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,image0: freezed == image0 ? _self.image0 : image0 // ignore: cast_nullable_to_non_nullable
as LatteImage?,image1: freezed == image1 ? _self.image1 : image1 // ignore: cast_nullable_to_non_nullable
as LatteImage?,image2: freezed == image2 ? _self.image2 : image2 // ignore: cast_nullable_to_non_nullable
as LatteImage?,image3: freezed == image3 ? _self.image3 : image3 // ignore: cast_nullable_to_non_nullable
as LatteImage?,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as LatteImageBatchParent?,
  ));
}
/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageCopyWith<$Res>? get image0 {
    if (_self.image0 == null) {
    return null;
  }

  return $LatteImageCopyWith<$Res>(_self.image0!, (value) {
    return _then(_self.copyWith(image0: value));
  });
}/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageCopyWith<$Res>? get image1 {
    if (_self.image1 == null) {
    return null;
  }

  return $LatteImageCopyWith<$Res>(_self.image1!, (value) {
    return _then(_self.copyWith(image1: value));
  });
}/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageCopyWith<$Res>? get image2 {
    if (_self.image2 == null) {
    return null;
  }

  return $LatteImageCopyWith<$Res>(_self.image2!, (value) {
    return _then(_self.copyWith(image2: value));
  });
}/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageCopyWith<$Res>? get image3 {
    if (_self.image3 == null) {
    return null;
  }

  return $LatteImageCopyWith<$Res>(_self.image3!, (value) {
    return _then(_self.copyWith(image3: value));
  });
}/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageBatchParentCopyWith<$Res>? get parent {
    if (_self.parent == null) {
    return null;
  }

  return $LatteImageBatchParentCopyWith<$Res>(_self.parent!, (value) {
    return _then(_self.copyWith(parent: value));
  });
}
}


/// Adds pattern-matching-related methods to [LatteImageBatch].
extension LatteImageBatchPatterns on LatteImageBatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatteImageBatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatteImageBatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatteImageBatch value)  $default,){
final _that = this;
switch (_that) {
case _LatteImageBatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatteImageBatch value)?  $default,){
final _that = this;
switch (_that) {
case _LatteImageBatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderId, @LatteImageConverter()  LatteImage? image0, @LatteImageConverter()  LatteImage? image1, @LatteImageConverter()  LatteImage? image2, @LatteImageConverter()  LatteImage? image3, @LatteImageBatchParentConverter()  LatteImageBatchParent? parent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatteImageBatch() when $default != null:
return $default(_that.id,_that.orderId,_that.image0,_that.image1,_that.image2,_that.image3,_that.parent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderId, @LatteImageConverter()  LatteImage? image0, @LatteImageConverter()  LatteImage? image1, @LatteImageConverter()  LatteImage? image2, @LatteImageConverter()  LatteImage? image3, @LatteImageBatchParentConverter()  LatteImageBatchParent? parent)  $default,) {final _that = this;
switch (_that) {
case _LatteImageBatch():
return $default(_that.id,_that.orderId,_that.image0,_that.image1,_that.image2,_that.image3,_that.parent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderId, @LatteImageConverter()  LatteImage? image0, @LatteImageConverter()  LatteImage? image1, @LatteImageConverter()  LatteImage? image2, @LatteImageConverter()  LatteImage? image3, @LatteImageBatchParentConverter()  LatteImageBatchParent? parent)?  $default,) {final _that = this;
switch (_that) {
case _LatteImageBatch() when $default != null:
return $default(_that.id,_that.orderId,_that.image0,_that.image1,_that.image2,_that.image3,_that.parent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatteImageBatch extends LatteImageBatch {
  const _LatteImageBatch({required this.id, required this.orderId, @LatteImageConverter() required this.image0, @LatteImageConverter() required this.image1, @LatteImageConverter() required this.image2, @LatteImageConverter() required this.image3, @LatteImageBatchParentConverter() this.parent}): super._();
  factory _LatteImageBatch.fromJson(Map<String, dynamic> json) => _$LatteImageBatchFromJson(json);

@override final  String id;
@override final  String orderId;
@override@LatteImageConverter() final  LatteImage? image0;
@override@LatteImageConverter() final  LatteImage? image1;
@override@LatteImageConverter() final  LatteImage? image2;
@override@LatteImageConverter() final  LatteImage? image3;
@override@LatteImageBatchParentConverter() final  LatteImageBatchParent? parent;

/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatteImageBatchCopyWith<_LatteImageBatch> get copyWith => __$LatteImageBatchCopyWithImpl<_LatteImageBatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatteImageBatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatteImageBatch&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.image0, image0) || other.image0 == image0)&&(identical(other.image1, image1) || other.image1 == image1)&&(identical(other.image2, image2) || other.image2 == image2)&&(identical(other.image3, image3) || other.image3 == image3)&&(identical(other.parent, parent) || other.parent == parent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,image0,image1,image2,image3,parent);

@override
String toString() {
  return 'LatteImageBatch(id: $id, orderId: $orderId, image0: $image0, image1: $image1, image2: $image2, image3: $image3, parent: $parent)';
}


}

/// @nodoc
abstract mixin class _$LatteImageBatchCopyWith<$Res> implements $LatteImageBatchCopyWith<$Res> {
  factory _$LatteImageBatchCopyWith(_LatteImageBatch value, $Res Function(_LatteImageBatch) _then) = __$LatteImageBatchCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderId,@LatteImageConverter() LatteImage? image0,@LatteImageConverter() LatteImage? image1,@LatteImageConverter() LatteImage? image2,@LatteImageConverter() LatteImage? image3,@LatteImageBatchParentConverter() LatteImageBatchParent? parent
});


@override $LatteImageCopyWith<$Res>? get image0;@override $LatteImageCopyWith<$Res>? get image1;@override $LatteImageCopyWith<$Res>? get image2;@override $LatteImageCopyWith<$Res>? get image3;@override $LatteImageBatchParentCopyWith<$Res>? get parent;

}
/// @nodoc
class __$LatteImageBatchCopyWithImpl<$Res>
    implements _$LatteImageBatchCopyWith<$Res> {
  __$LatteImageBatchCopyWithImpl(this._self, this._then);

  final _LatteImageBatch _self;
  final $Res Function(_LatteImageBatch) _then;

/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? image0 = freezed,Object? image1 = freezed,Object? image2 = freezed,Object? image3 = freezed,Object? parent = freezed,}) {
  return _then(_LatteImageBatch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,image0: freezed == image0 ? _self.image0 : image0 // ignore: cast_nullable_to_non_nullable
as LatteImage?,image1: freezed == image1 ? _self.image1 : image1 // ignore: cast_nullable_to_non_nullable
as LatteImage?,image2: freezed == image2 ? _self.image2 : image2 // ignore: cast_nullable_to_non_nullable
as LatteImage?,image3: freezed == image3 ? _self.image3 : image3 // ignore: cast_nullable_to_non_nullable
as LatteImage?,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as LatteImageBatchParent?,
  ));
}

/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageCopyWith<$Res>? get image0 {
    if (_self.image0 == null) {
    return null;
  }

  return $LatteImageCopyWith<$Res>(_self.image0!, (value) {
    return _then(_self.copyWith(image0: value));
  });
}/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageCopyWith<$Res>? get image1 {
    if (_self.image1 == null) {
    return null;
  }

  return $LatteImageCopyWith<$Res>(_self.image1!, (value) {
    return _then(_self.copyWith(image1: value));
  });
}/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageCopyWith<$Res>? get image2 {
    if (_self.image2 == null) {
    return null;
  }

  return $LatteImageCopyWith<$Res>(_self.image2!, (value) {
    return _then(_self.copyWith(image2: value));
  });
}/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageCopyWith<$Res>? get image3 {
    if (_self.image3 == null) {
    return null;
  }

  return $LatteImageCopyWith<$Res>(_self.image3!, (value) {
    return _then(_self.copyWith(image3: value));
  });
}/// Create a copy of LatteImageBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageBatchParentCopyWith<$Res>? get parent {
    if (_self.parent == null) {
    return null;
  }

  return $LatteImageBatchParentCopyWith<$Res>(_self.parent!, (value) {
    return _then(_self.copyWith(parent: value));
  });
}
}


/// @nodoc
mixin _$LatteImageBatchParent {

/// Firebase Id of the [LatteImageBatch] that this image batch forked from.
 String get id;/// "image0", "image1", "image2", or "image3". No other values are
/// acceptable.
 String get imageIndex;
/// Create a copy of LatteImageBatchParent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatteImageBatchParentCopyWith<LatteImageBatchParent> get copyWith => _$LatteImageBatchParentCopyWithImpl<LatteImageBatchParent>(this as LatteImageBatchParent, _$identity);

  /// Serializes this LatteImageBatchParent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatteImageBatchParent&&(identical(other.id, id) || other.id == id)&&(identical(other.imageIndex, imageIndex) || other.imageIndex == imageIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageIndex);

@override
String toString() {
  return 'LatteImageBatchParent(id: $id, imageIndex: $imageIndex)';
}


}

/// @nodoc
abstract mixin class $LatteImageBatchParentCopyWith<$Res>  {
  factory $LatteImageBatchParentCopyWith(LatteImageBatchParent value, $Res Function(LatteImageBatchParent) _then) = _$LatteImageBatchParentCopyWithImpl;
@useResult
$Res call({
 String id, String imageIndex
});




}
/// @nodoc
class _$LatteImageBatchParentCopyWithImpl<$Res>
    implements $LatteImageBatchParentCopyWith<$Res> {
  _$LatteImageBatchParentCopyWithImpl(this._self, this._then);

  final LatteImageBatchParent _self;
  final $Res Function(LatteImageBatchParent) _then;

/// Create a copy of LatteImageBatchParent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageIndex = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageIndex: null == imageIndex ? _self.imageIndex : imageIndex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LatteImageBatchParent].
extension LatteImageBatchParentPatterns on LatteImageBatchParent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatteImageBatchParent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatteImageBatchParent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatteImageBatchParent value)  $default,){
final _that = this;
switch (_that) {
case _LatteImageBatchParent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatteImageBatchParent value)?  $default,){
final _that = this;
switch (_that) {
case _LatteImageBatchParent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String imageIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatteImageBatchParent() when $default != null:
return $default(_that.id,_that.imageIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String imageIndex)  $default,) {final _that = this;
switch (_that) {
case _LatteImageBatchParent():
return $default(_that.id,_that.imageIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String imageIndex)?  $default,) {final _that = this;
switch (_that) {
case _LatteImageBatchParent() when $default != null:
return $default(_that.id,_that.imageIndex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatteImageBatchParent implements LatteImageBatchParent {
  const _LatteImageBatchParent({required this.id, required this.imageIndex});
  factory _LatteImageBatchParent.fromJson(Map<String, dynamic> json) => _$LatteImageBatchParentFromJson(json);

/// Firebase Id of the [LatteImageBatch] that this image batch forked from.
@override final  String id;
/// "image0", "image1", "image2", or "image3". No other values are
/// acceptable.
@override final  String imageIndex;

/// Create a copy of LatteImageBatchParent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatteImageBatchParentCopyWith<_LatteImageBatchParent> get copyWith => __$LatteImageBatchParentCopyWithImpl<_LatteImageBatchParent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatteImageBatchParentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatteImageBatchParent&&(identical(other.id, id) || other.id == id)&&(identical(other.imageIndex, imageIndex) || other.imageIndex == imageIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageIndex);

@override
String toString() {
  return 'LatteImageBatchParent(id: $id, imageIndex: $imageIndex)';
}


}

/// @nodoc
abstract mixin class _$LatteImageBatchParentCopyWith<$Res> implements $LatteImageBatchParentCopyWith<$Res> {
  factory _$LatteImageBatchParentCopyWith(_LatteImageBatchParent value, $Res Function(_LatteImageBatchParent) _then) = __$LatteImageBatchParentCopyWithImpl;
@override @useResult
$Res call({
 String id, String imageIndex
});




}
/// @nodoc
class __$LatteImageBatchParentCopyWithImpl<$Res>
    implements _$LatteImageBatchParentCopyWith<$Res> {
  __$LatteImageBatchParentCopyWithImpl(this._self, this._then);

  final _LatteImageBatchParent _self;
  final $Res Function(_LatteImageBatchParent) _then;

/// Create a copy of LatteImageBatchParent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageIndex = null,}) {
  return _then(_LatteImageBatchParent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageIndex: null == imageIndex ? _self.imageIndex : imageIndex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LatteImage {

/// The URL of the generated image.
 String get imageUrl;/// The upgraded prompt sent to Gemini.
 String get prompt;@QuestionConverter() List<Question>? get questions;/// A description of the generated image.
 String get description;
/// Create a copy of LatteImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatteImageCopyWith<LatteImage> get copyWith => _$LatteImageCopyWithImpl<LatteImage>(this as LatteImage, _$identity);

  /// Serializes this LatteImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatteImage&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,prompt,const DeepCollectionEquality().hash(questions),description);

@override
String toString() {
  return 'LatteImage(imageUrl: $imageUrl, prompt: $prompt, questions: $questions, description: $description)';
}


}

/// @nodoc
abstract mixin class $LatteImageCopyWith<$Res>  {
  factory $LatteImageCopyWith(LatteImage value, $Res Function(LatteImage) _then) = _$LatteImageCopyWithImpl;
@useResult
$Res call({
 String imageUrl, String prompt,@QuestionConverter() List<Question>? questions, String description
});




}
/// @nodoc
class _$LatteImageCopyWithImpl<$Res>
    implements $LatteImageCopyWith<$Res> {
  _$LatteImageCopyWithImpl(this._self, this._then);

  final LatteImage _self;
  final $Res Function(LatteImage) _then;

/// Create a copy of LatteImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,Object? prompt = null,Object? questions = freezed,Object? description = null,}) {
  return _then(_self.copyWith(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,questions: freezed == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LatteImage].
extension LatteImagePatterns on LatteImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatteImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatteImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatteImage value)  $default,){
final _that = this;
switch (_that) {
case _LatteImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatteImage value)?  $default,){
final _that = this;
switch (_that) {
case _LatteImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String imageUrl,  String prompt, @QuestionConverter()  List<Question>? questions,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatteImage() when $default != null:
return $default(_that.imageUrl,_that.prompt,_that.questions,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String imageUrl,  String prompt, @QuestionConverter()  List<Question>? questions,  String description)  $default,) {final _that = this;
switch (_that) {
case _LatteImage():
return $default(_that.imageUrl,_that.prompt,_that.questions,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String imageUrl,  String prompt, @QuestionConverter()  List<Question>? questions,  String description)?  $default,) {final _that = this;
switch (_that) {
case _LatteImage() when $default != null:
return $default(_that.imageUrl,_that.prompt,_that.questions,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatteImage extends LatteImage {
  const _LatteImage({required this.imageUrl, required this.prompt, @QuestionConverter() required final  List<Question>? questions, required this.description}): _questions = questions,super._();
  factory _LatteImage.fromJson(Map<String, dynamic> json) => _$LatteImageFromJson(json);

/// The URL of the generated image.
@override final  String imageUrl;
/// The upgraded prompt sent to Gemini.
@override final  String prompt;
 final  List<Question>? _questions;
@override@QuestionConverter() List<Question>? get questions {
  final value = _questions;
  if (value == null) return null;
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// A description of the generated image.
@override final  String description;

/// Create a copy of LatteImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatteImageCopyWith<_LatteImage> get copyWith => __$LatteImageCopyWithImpl<_LatteImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatteImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatteImage&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,prompt,const DeepCollectionEquality().hash(_questions),description);

@override
String toString() {
  return 'LatteImage(imageUrl: $imageUrl, prompt: $prompt, questions: $questions, description: $description)';
}


}

/// @nodoc
abstract mixin class _$LatteImageCopyWith<$Res> implements $LatteImageCopyWith<$Res> {
  factory _$LatteImageCopyWith(_LatteImage value, $Res Function(_LatteImage) _then) = __$LatteImageCopyWithImpl;
@override @useResult
$Res call({
 String imageUrl, String prompt,@QuestionConverter() List<Question>? questions, String description
});




}
/// @nodoc
class __$LatteImageCopyWithImpl<$Res>
    implements _$LatteImageCopyWith<$Res> {
  __$LatteImageCopyWithImpl(this._self, this._then);

  final _LatteImage _self;
  final $Res Function(_LatteImage) _then;

/// Create a copy of LatteImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,Object? prompt = null,Object? questions = freezed,Object? description = null,}) {
  return _then(_LatteImage(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,questions: freezed == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RecentLatteImage {

/// The URL of the generated image.
 String get imageUrl;/// The upgraded prompt sent to Gemini.
 String get prompt;/// The happy place that was used to generate the image.
 String get happyPlace;/// A description of the generated image.
 String get description;/// The name of the user who created this image.
 String get name;/// The time the originating [LatteOrder] was submitted and this document
/// was created.
 DateTime get createdAt;/// The ID of the generated image.
 String? get id;
/// Create a copy of RecentLatteImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentLatteImageCopyWith<RecentLatteImage> get copyWith => _$RecentLatteImageCopyWithImpl<RecentLatteImage>(this as RecentLatteImage, _$identity);

  /// Serializes this RecentLatteImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentLatteImage&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.happyPlace, happyPlace) || other.happyPlace == happyPlace)&&(identical(other.description, description) || other.description == description)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,prompt,happyPlace,description,name,createdAt,id);

@override
String toString() {
  return 'RecentLatteImage(imageUrl: $imageUrl, prompt: $prompt, happyPlace: $happyPlace, description: $description, name: $name, createdAt: $createdAt, id: $id)';
}


}

/// @nodoc
abstract mixin class $RecentLatteImageCopyWith<$Res>  {
  factory $RecentLatteImageCopyWith(RecentLatteImage value, $Res Function(RecentLatteImage) _then) = _$RecentLatteImageCopyWithImpl;
@useResult
$Res call({
 String imageUrl, String prompt, String happyPlace, String description, String name, DateTime createdAt, String? id
});




}
/// @nodoc
class _$RecentLatteImageCopyWithImpl<$Res>
    implements $RecentLatteImageCopyWith<$Res> {
  _$RecentLatteImageCopyWithImpl(this._self, this._then);

  final RecentLatteImage _self;
  final $Res Function(RecentLatteImage) _then;

/// Create a copy of RecentLatteImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,Object? prompt = null,Object? happyPlace = null,Object? description = null,Object? name = null,Object? createdAt = null,Object? id = freezed,}) {
  return _then(_self.copyWith(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,happyPlace: null == happyPlace ? _self.happyPlace : happyPlace // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentLatteImage].
extension RecentLatteImagePatterns on RecentLatteImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentLatteImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentLatteImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentLatteImage value)  $default,){
final _that = this;
switch (_that) {
case _RecentLatteImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentLatteImage value)?  $default,){
final _that = this;
switch (_that) {
case _RecentLatteImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String imageUrl,  String prompt,  String happyPlace,  String description,  String name,  DateTime createdAt,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentLatteImage() when $default != null:
return $default(_that.imageUrl,_that.prompt,_that.happyPlace,_that.description,_that.name,_that.createdAt,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String imageUrl,  String prompt,  String happyPlace,  String description,  String name,  DateTime createdAt,  String? id)  $default,) {final _that = this;
switch (_that) {
case _RecentLatteImage():
return $default(_that.imageUrl,_that.prompt,_that.happyPlace,_that.description,_that.name,_that.createdAt,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String imageUrl,  String prompt,  String happyPlace,  String description,  String name,  DateTime createdAt,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _RecentLatteImage() when $default != null:
return $default(_that.imageUrl,_that.prompt,_that.happyPlace,_that.description,_that.name,_that.createdAt,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecentLatteImage extends RecentLatteImage {
  const _RecentLatteImage({required this.imageUrl, required this.prompt, required this.happyPlace, required this.description, required this.name, required this.createdAt, this.id}): super._();
  factory _RecentLatteImage.fromJson(Map<String, dynamic> json) => _$RecentLatteImageFromJson(json);

/// The URL of the generated image.
@override final  String imageUrl;
/// The upgraded prompt sent to Gemini.
@override final  String prompt;
/// The happy place that was used to generate the image.
@override final  String happyPlace;
/// A description of the generated image.
@override final  String description;
/// The name of the user who created this image.
@override final  String name;
/// The time the originating [LatteOrder] was submitted and this document
/// was created.
@override final  DateTime createdAt;
/// The ID of the generated image.
@override final  String? id;

/// Create a copy of RecentLatteImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentLatteImageCopyWith<_RecentLatteImage> get copyWith => __$RecentLatteImageCopyWithImpl<_RecentLatteImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentLatteImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentLatteImage&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.happyPlace, happyPlace) || other.happyPlace == happyPlace)&&(identical(other.description, description) || other.description == description)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,prompt,happyPlace,description,name,createdAt,id);

@override
String toString() {
  return 'RecentLatteImage(imageUrl: $imageUrl, prompt: $prompt, happyPlace: $happyPlace, description: $description, name: $name, createdAt: $createdAt, id: $id)';
}


}

/// @nodoc
abstract mixin class _$RecentLatteImageCopyWith<$Res> implements $RecentLatteImageCopyWith<$Res> {
  factory _$RecentLatteImageCopyWith(_RecentLatteImage value, $Res Function(_RecentLatteImage) _then) = __$RecentLatteImageCopyWithImpl;
@override @useResult
$Res call({
 String imageUrl, String prompt, String happyPlace, String description, String name, DateTime createdAt, String? id
});




}
/// @nodoc
class __$RecentLatteImageCopyWithImpl<$Res>
    implements _$RecentLatteImageCopyWith<$Res> {
  __$RecentLatteImageCopyWithImpl(this._self, this._then);

  final _RecentLatteImage _self;
  final $Res Function(_RecentLatteImage) _then;

/// Create a copy of RecentLatteImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,Object? prompt = null,Object? happyPlace = null,Object? description = null,Object? name = null,Object? createdAt = null,Object? id = freezed,}) {
  return _then(_RecentLatteImage(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,happyPlace: null == happyPlace ? _self.happyPlace : happyPlace // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
