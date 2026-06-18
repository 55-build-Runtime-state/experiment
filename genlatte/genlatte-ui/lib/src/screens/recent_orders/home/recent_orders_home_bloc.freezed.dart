// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_orders_home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecentOrdersHomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentOrdersHomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecentOrdersHomeEvent()';
}


}

/// @nodoc
class $RecentOrdersHomeEventCopyWith<$Res>  {
$RecentOrdersHomeEventCopyWith(RecentOrdersHomeEvent _, $Res Function(RecentOrdersHomeEvent) __);
}


/// Adds pattern-matching-related methods to [RecentOrdersHomeEvent].
extension RecentOrdersHomeEventPatterns on RecentOrdersHomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UpdatedRecentImages value)?  updatedRecentImages,TResult Function( SetActiveImage value)?  setActiveImage,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UpdatedRecentImages() when updatedRecentImages != null:
return updatedRecentImages(_that);case SetActiveImage() when setActiveImage != null:
return setActiveImage(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UpdatedRecentImages value)  updatedRecentImages,required TResult Function( SetActiveImage value)  setActiveImage,}){
final _that = this;
switch (_that) {
case UpdatedRecentImages():
return updatedRecentImages(_that);case SetActiveImage():
return setActiveImage(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UpdatedRecentImages value)?  updatedRecentImages,TResult? Function( SetActiveImage value)?  setActiveImage,}){
final _that = this;
switch (_that) {
case UpdatedRecentImages() when updatedRecentImages != null:
return updatedRecentImages(_that);case SetActiveImage() when setActiveImage != null:
return setActiveImage(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<RecentLatteImage> images)?  updatedRecentImages,TResult Function( RecentLatteImage? activeImage)?  setActiveImage,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UpdatedRecentImages() when updatedRecentImages != null:
return updatedRecentImages(_that.images);case SetActiveImage() when setActiveImage != null:
return setActiveImage(_that.activeImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<RecentLatteImage> images)  updatedRecentImages,required TResult Function( RecentLatteImage? activeImage)  setActiveImage,}) {final _that = this;
switch (_that) {
case UpdatedRecentImages():
return updatedRecentImages(_that.images);case SetActiveImage():
return setActiveImage(_that.activeImage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<RecentLatteImage> images)?  updatedRecentImages,TResult? Function( RecentLatteImage? activeImage)?  setActiveImage,}) {final _that = this;
switch (_that) {
case UpdatedRecentImages() when updatedRecentImages != null:
return updatedRecentImages(_that.images);case SetActiveImage() when setActiveImage != null:
return setActiveImage(_that.activeImage);case _:
  return null;

}
}

}

/// @nodoc


class UpdatedRecentImages implements RecentOrdersHomeEvent {
  const UpdatedRecentImages(final  List<RecentLatteImage> images): _images = images;
  

 final  List<RecentLatteImage> _images;
 List<RecentLatteImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of RecentOrdersHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdatedRecentImagesCopyWith<UpdatedRecentImages> get copyWith => _$UpdatedRecentImagesCopyWithImpl<UpdatedRecentImages>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdatedRecentImages&&const DeepCollectionEquality().equals(other._images, _images));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_images));

@override
String toString() {
  return 'RecentOrdersHomeEvent.updatedRecentImages(images: $images)';
}


}

/// @nodoc
abstract mixin class $UpdatedRecentImagesCopyWith<$Res> implements $RecentOrdersHomeEventCopyWith<$Res> {
  factory $UpdatedRecentImagesCopyWith(UpdatedRecentImages value, $Res Function(UpdatedRecentImages) _then) = _$UpdatedRecentImagesCopyWithImpl;
@useResult
$Res call({
 List<RecentLatteImage> images
});




}
/// @nodoc
class _$UpdatedRecentImagesCopyWithImpl<$Res>
    implements $UpdatedRecentImagesCopyWith<$Res> {
  _$UpdatedRecentImagesCopyWithImpl(this._self, this._then);

  final UpdatedRecentImages _self;
  final $Res Function(UpdatedRecentImages) _then;

/// Create a copy of RecentOrdersHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? images = null,}) {
  return _then(UpdatedRecentImages(
null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<RecentLatteImage>,
  ));
}


}

/// @nodoc


class SetActiveImage implements RecentOrdersHomeEvent {
  const SetActiveImage(this.activeImage);
  

 final  RecentLatteImage? activeImage;

/// Create a copy of RecentOrdersHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetActiveImageCopyWith<SetActiveImage> get copyWith => _$SetActiveImageCopyWithImpl<SetActiveImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetActiveImage&&(identical(other.activeImage, activeImage) || other.activeImage == activeImage));
}


@override
int get hashCode => Object.hash(runtimeType,activeImage);

@override
String toString() {
  return 'RecentOrdersHomeEvent.setActiveImage(activeImage: $activeImage)';
}


}

/// @nodoc
abstract mixin class $SetActiveImageCopyWith<$Res> implements $RecentOrdersHomeEventCopyWith<$Res> {
  factory $SetActiveImageCopyWith(SetActiveImage value, $Res Function(SetActiveImage) _then) = _$SetActiveImageCopyWithImpl;
@useResult
$Res call({
 RecentLatteImage? activeImage
});


$RecentLatteImageCopyWith<$Res>? get activeImage;

}
/// @nodoc
class _$SetActiveImageCopyWithImpl<$Res>
    implements $SetActiveImageCopyWith<$Res> {
  _$SetActiveImageCopyWithImpl(this._self, this._then);

  final SetActiveImage _self;
  final $Res Function(SetActiveImage) _then;

/// Create a copy of RecentOrdersHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? activeImage = freezed,}) {
  return _then(SetActiveImage(
freezed == activeImage ? _self.activeImage : activeImage // ignore: cast_nullable_to_non_nullable
as RecentLatteImage?,
  ));
}

/// Create a copy of RecentOrdersHomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecentLatteImageCopyWith<$Res>? get activeImage {
    if (_self.activeImage == null) {
    return null;
  }

  return $RecentLatteImageCopyWith<$Res>(_self.activeImage!, (value) {
    return _then(_self.copyWith(activeImage: value));
  });
}
}

/// @nodoc
mixin _$RecentOrdersHomeState {

 List<RecentLatteImage> get images; RecentLatteImage? get activeImage;
/// Create a copy of RecentOrdersHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentOrdersHomeStateCopyWith<RecentOrdersHomeState> get copyWith => _$RecentOrdersHomeStateCopyWithImpl<RecentOrdersHomeState>(this as RecentOrdersHomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentOrdersHomeState&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.activeImage, activeImage) || other.activeImage == activeImage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(images),activeImage);

@override
String toString() {
  return 'RecentOrdersHomeState(images: $images, activeImage: $activeImage)';
}


}

/// @nodoc
abstract mixin class $RecentOrdersHomeStateCopyWith<$Res>  {
  factory $RecentOrdersHomeStateCopyWith(RecentOrdersHomeState value, $Res Function(RecentOrdersHomeState) _then) = _$RecentOrdersHomeStateCopyWithImpl;
@useResult
$Res call({
 List<RecentLatteImage> images, RecentLatteImage? activeImage
});


$RecentLatteImageCopyWith<$Res>? get activeImage;

}
/// @nodoc
class _$RecentOrdersHomeStateCopyWithImpl<$Res>
    implements $RecentOrdersHomeStateCopyWith<$Res> {
  _$RecentOrdersHomeStateCopyWithImpl(this._self, this._then);

  final RecentOrdersHomeState _self;
  final $Res Function(RecentOrdersHomeState) _then;

/// Create a copy of RecentOrdersHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? images = null,Object? activeImage = freezed,}) {
  return _then(_self.copyWith(
images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<RecentLatteImage>,activeImage: freezed == activeImage ? _self.activeImage : activeImage // ignore: cast_nullable_to_non_nullable
as RecentLatteImage?,
  ));
}
/// Create a copy of RecentOrdersHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecentLatteImageCopyWith<$Res>? get activeImage {
    if (_self.activeImage == null) {
    return null;
  }

  return $RecentLatteImageCopyWith<$Res>(_self.activeImage!, (value) {
    return _then(_self.copyWith(activeImage: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecentOrdersHomeState].
extension RecentOrdersHomeStatePatterns on RecentOrdersHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentOrdersHomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentOrdersHomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentOrdersHomeState value)  $default,){
final _that = this;
switch (_that) {
case _RecentOrdersHomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentOrdersHomeState value)?  $default,){
final _that = this;
switch (_that) {
case _RecentOrdersHomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RecentLatteImage> images,  RecentLatteImage? activeImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentOrdersHomeState() when $default != null:
return $default(_that.images,_that.activeImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RecentLatteImage> images,  RecentLatteImage? activeImage)  $default,) {final _that = this;
switch (_that) {
case _RecentOrdersHomeState():
return $default(_that.images,_that.activeImage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RecentLatteImage> images,  RecentLatteImage? activeImage)?  $default,) {final _that = this;
switch (_that) {
case _RecentOrdersHomeState() when $default != null:
return $default(_that.images,_that.activeImage);case _:
  return null;

}
}

}

/// @nodoc


class _RecentOrdersHomeState extends RecentOrdersHomeState {
  const _RecentOrdersHomeState({final  List<RecentLatteImage> images = const <RecentLatteImage>[], this.activeImage}): _images = images,super._();
  

 final  List<RecentLatteImage> _images;
@override@JsonKey() List<RecentLatteImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  RecentLatteImage? activeImage;

/// Create a copy of RecentOrdersHomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentOrdersHomeStateCopyWith<_RecentOrdersHomeState> get copyWith => __$RecentOrdersHomeStateCopyWithImpl<_RecentOrdersHomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentOrdersHomeState&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.activeImage, activeImage) || other.activeImage == activeImage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_images),activeImage);

@override
String toString() {
  return 'RecentOrdersHomeState(images: $images, activeImage: $activeImage)';
}


}

/// @nodoc
abstract mixin class _$RecentOrdersHomeStateCopyWith<$Res> implements $RecentOrdersHomeStateCopyWith<$Res> {
  factory _$RecentOrdersHomeStateCopyWith(_RecentOrdersHomeState value, $Res Function(_RecentOrdersHomeState) _then) = __$RecentOrdersHomeStateCopyWithImpl;
@override @useResult
$Res call({
 List<RecentLatteImage> images, RecentLatteImage? activeImage
});


@override $RecentLatteImageCopyWith<$Res>? get activeImage;

}
/// @nodoc
class __$RecentOrdersHomeStateCopyWithImpl<$Res>
    implements _$RecentOrdersHomeStateCopyWith<$Res> {
  __$RecentOrdersHomeStateCopyWithImpl(this._self, this._then);

  final _RecentOrdersHomeState _self;
  final $Res Function(_RecentOrdersHomeState) _then;

/// Create a copy of RecentOrdersHomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? images = null,Object? activeImage = freezed,}) {
  return _then(_RecentOrdersHomeState(
images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<RecentLatteImage>,activeImage: freezed == activeImage ? _self.activeImage : activeImage // ignore: cast_nullable_to_non_nullable
as RecentLatteImage?,
  ));
}

/// Create a copy of RecentOrdersHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecentLatteImageCopyWith<$Res>? get activeImage {
    if (_self.activeImage == null) {
    return null;
  }

  return $RecentLatteImageCopyWith<$Res>(_self.activeImage!, (value) {
    return _then(_self.copyWith(activeImage: value));
  });
}
}

// dart format on
