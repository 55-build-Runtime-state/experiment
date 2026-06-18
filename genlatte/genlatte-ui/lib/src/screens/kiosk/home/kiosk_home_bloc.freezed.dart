// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kiosk_home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KioskHomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KioskHomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KioskHomeEvent()';
}


}

/// @nodoc
class $KioskHomeEventCopyWith<$Res>  {
$KioskHomeEventCopyWith(KioskHomeEvent _, $Res Function(KioskHomeEvent) __);
}


/// Adds pattern-matching-related methods to [KioskHomeEvent].
extension KioskHomeEventPatterns on KioskHomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnNewPage value)?  onNewPage,TResult Function( StartOver value)?  startOver,TResult Function( _EjectData value)?  ejectData,TResult Function( LoadPreExistingOrders value)?  loadPreExistingOrders,TResult Function( ApplyPreExistingOrder value)?  applyPreExistingOrder,TResult Function( UpdateMilkOptions value)?  updateMilkOptions,TResult Function( UpdateSweetenerOptions value)?  updateSweetenerOptions,TResult Function( SelectMilk value)?  selectMilk,TResult Function( SelectSweetener value)?  selectSweetener,TResult Function( SubmitMilkAndSweetener value)?  submitMilkAndSweetener,TResult Function( SubmitHappyPlace value)?  submitHappyPlace,TResult Function( HappyPlaceRejected value)?  happyPlaceRejected,TResult Function( HappyPlaceModerationReasonShown value)?  happyPlaceModerationReasonShown,TResult Function( ServerOrderUpdate value)?  serverOrderUpdate,TResult Function( ServerMetadataUpdate value)?  serverMetadataUpdate,TResult Function( GoBackKioskWizard value)?  goBack,TResult Function( GoToStep value)?  goToStep,TResult Function( SubmitUserName value)?  submitUserName,TResult Function( SelectImage value)?  selectImage,TResult Function( UpdateLatteImages value)?  updateLatteImages,TResult Function( NewImageLatteBatch value)?  newImageLatteBatch,TResult Function( UpdateQuestions value)?  updateQuestions,TResult Function( AnswerQuestion value)?  answerQuestion,TResult Function( GenerateRevisedImages value)?  generateRevisedImages,TResult Function( RejectImageBatch value)?  rejectImageBatch,TResult Function( AcceptImage value)?  acceptImage,TResult Function( SubmitOrder value)?  submitOrder,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnNewPage() when onNewPage != null:
return onNewPage(_that);case StartOver() when startOver != null:
return startOver(_that);case _EjectData() when ejectData != null:
return ejectData(_that);case LoadPreExistingOrders() when loadPreExistingOrders != null:
return loadPreExistingOrders(_that);case ApplyPreExistingOrder() when applyPreExistingOrder != null:
return applyPreExistingOrder(_that);case UpdateMilkOptions() when updateMilkOptions != null:
return updateMilkOptions(_that);case UpdateSweetenerOptions() when updateSweetenerOptions != null:
return updateSweetenerOptions(_that);case SelectMilk() when selectMilk != null:
return selectMilk(_that);case SelectSweetener() when selectSweetener != null:
return selectSweetener(_that);case SubmitMilkAndSweetener() when submitMilkAndSweetener != null:
return submitMilkAndSweetener(_that);case SubmitHappyPlace() when submitHappyPlace != null:
return submitHappyPlace(_that);case HappyPlaceRejected() when happyPlaceRejected != null:
return happyPlaceRejected(_that);case HappyPlaceModerationReasonShown() when happyPlaceModerationReasonShown != null:
return happyPlaceModerationReasonShown(_that);case ServerOrderUpdate() when serverOrderUpdate != null:
return serverOrderUpdate(_that);case ServerMetadataUpdate() when serverMetadataUpdate != null:
return serverMetadataUpdate(_that);case GoBackKioskWizard() when goBack != null:
return goBack(_that);case GoToStep() when goToStep != null:
return goToStep(_that);case SubmitUserName() when submitUserName != null:
return submitUserName(_that);case SelectImage() when selectImage != null:
return selectImage(_that);case UpdateLatteImages() when updateLatteImages != null:
return updateLatteImages(_that);case NewImageLatteBatch() when newImageLatteBatch != null:
return newImageLatteBatch(_that);case UpdateQuestions() when updateQuestions != null:
return updateQuestions(_that);case AnswerQuestion() when answerQuestion != null:
return answerQuestion(_that);case GenerateRevisedImages() when generateRevisedImages != null:
return generateRevisedImages(_that);case RejectImageBatch() when rejectImageBatch != null:
return rejectImageBatch(_that);case AcceptImage() when acceptImage != null:
return acceptImage(_that);case SubmitOrder() when submitOrder != null:
return submitOrder(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnNewPage value)  onNewPage,required TResult Function( StartOver value)  startOver,required TResult Function( _EjectData value)  ejectData,required TResult Function( LoadPreExistingOrders value)  loadPreExistingOrders,required TResult Function( ApplyPreExistingOrder value)  applyPreExistingOrder,required TResult Function( UpdateMilkOptions value)  updateMilkOptions,required TResult Function( UpdateSweetenerOptions value)  updateSweetenerOptions,required TResult Function( SelectMilk value)  selectMilk,required TResult Function( SelectSweetener value)  selectSweetener,required TResult Function( SubmitMilkAndSweetener value)  submitMilkAndSweetener,required TResult Function( SubmitHappyPlace value)  submitHappyPlace,required TResult Function( HappyPlaceRejected value)  happyPlaceRejected,required TResult Function( HappyPlaceModerationReasonShown value)  happyPlaceModerationReasonShown,required TResult Function( ServerOrderUpdate value)  serverOrderUpdate,required TResult Function( ServerMetadataUpdate value)  serverMetadataUpdate,required TResult Function( GoBackKioskWizard value)  goBack,required TResult Function( GoToStep value)  goToStep,required TResult Function( SubmitUserName value)  submitUserName,required TResult Function( SelectImage value)  selectImage,required TResult Function( UpdateLatteImages value)  updateLatteImages,required TResult Function( NewImageLatteBatch value)  newImageLatteBatch,required TResult Function( UpdateQuestions value)  updateQuestions,required TResult Function( AnswerQuestion value)  answerQuestion,required TResult Function( GenerateRevisedImages value)  generateRevisedImages,required TResult Function( RejectImageBatch value)  rejectImageBatch,required TResult Function( AcceptImage value)  acceptImage,required TResult Function( SubmitOrder value)  submitOrder,}){
final _that = this;
switch (_that) {
case OnNewPage():
return onNewPage(_that);case StartOver():
return startOver(_that);case _EjectData():
return ejectData(_that);case LoadPreExistingOrders():
return loadPreExistingOrders(_that);case ApplyPreExistingOrder():
return applyPreExistingOrder(_that);case UpdateMilkOptions():
return updateMilkOptions(_that);case UpdateSweetenerOptions():
return updateSweetenerOptions(_that);case SelectMilk():
return selectMilk(_that);case SelectSweetener():
return selectSweetener(_that);case SubmitMilkAndSweetener():
return submitMilkAndSweetener(_that);case SubmitHappyPlace():
return submitHappyPlace(_that);case HappyPlaceRejected():
return happyPlaceRejected(_that);case HappyPlaceModerationReasonShown():
return happyPlaceModerationReasonShown(_that);case ServerOrderUpdate():
return serverOrderUpdate(_that);case ServerMetadataUpdate():
return serverMetadataUpdate(_that);case GoBackKioskWizard():
return goBack(_that);case GoToStep():
return goToStep(_that);case SubmitUserName():
return submitUserName(_that);case SelectImage():
return selectImage(_that);case UpdateLatteImages():
return updateLatteImages(_that);case NewImageLatteBatch():
return newImageLatteBatch(_that);case UpdateQuestions():
return updateQuestions(_that);case AnswerQuestion():
return answerQuestion(_that);case GenerateRevisedImages():
return generateRevisedImages(_that);case RejectImageBatch():
return rejectImageBatch(_that);case AcceptImage():
return acceptImage(_that);case SubmitOrder():
return submitOrder(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnNewPage value)?  onNewPage,TResult? Function( StartOver value)?  startOver,TResult? Function( _EjectData value)?  ejectData,TResult? Function( LoadPreExistingOrders value)?  loadPreExistingOrders,TResult? Function( ApplyPreExistingOrder value)?  applyPreExistingOrder,TResult? Function( UpdateMilkOptions value)?  updateMilkOptions,TResult? Function( UpdateSweetenerOptions value)?  updateSweetenerOptions,TResult? Function( SelectMilk value)?  selectMilk,TResult? Function( SelectSweetener value)?  selectSweetener,TResult? Function( SubmitMilkAndSweetener value)?  submitMilkAndSweetener,TResult? Function( SubmitHappyPlace value)?  submitHappyPlace,TResult? Function( HappyPlaceRejected value)?  happyPlaceRejected,TResult? Function( HappyPlaceModerationReasonShown value)?  happyPlaceModerationReasonShown,TResult? Function( ServerOrderUpdate value)?  serverOrderUpdate,TResult? Function( ServerMetadataUpdate value)?  serverMetadataUpdate,TResult? Function( GoBackKioskWizard value)?  goBack,TResult? Function( GoToStep value)?  goToStep,TResult? Function( SubmitUserName value)?  submitUserName,TResult? Function( SelectImage value)?  selectImage,TResult? Function( UpdateLatteImages value)?  updateLatteImages,TResult? Function( NewImageLatteBatch value)?  newImageLatteBatch,TResult? Function( UpdateQuestions value)?  updateQuestions,TResult? Function( AnswerQuestion value)?  answerQuestion,TResult? Function( GenerateRevisedImages value)?  generateRevisedImages,TResult? Function( RejectImageBatch value)?  rejectImageBatch,TResult? Function( AcceptImage value)?  acceptImage,TResult? Function( SubmitOrder value)?  submitOrder,}){
final _that = this;
switch (_that) {
case OnNewPage() when onNewPage != null:
return onNewPage(_that);case StartOver() when startOver != null:
return startOver(_that);case _EjectData() when ejectData != null:
return ejectData(_that);case LoadPreExistingOrders() when loadPreExistingOrders != null:
return loadPreExistingOrders(_that);case ApplyPreExistingOrder() when applyPreExistingOrder != null:
return applyPreExistingOrder(_that);case UpdateMilkOptions() when updateMilkOptions != null:
return updateMilkOptions(_that);case UpdateSweetenerOptions() when updateSweetenerOptions != null:
return updateSweetenerOptions(_that);case SelectMilk() when selectMilk != null:
return selectMilk(_that);case SelectSweetener() when selectSweetener != null:
return selectSweetener(_that);case SubmitMilkAndSweetener() when submitMilkAndSweetener != null:
return submitMilkAndSweetener(_that);case SubmitHappyPlace() when submitHappyPlace != null:
return submitHappyPlace(_that);case HappyPlaceRejected() when happyPlaceRejected != null:
return happyPlaceRejected(_that);case HappyPlaceModerationReasonShown() when happyPlaceModerationReasonShown != null:
return happyPlaceModerationReasonShown(_that);case ServerOrderUpdate() when serverOrderUpdate != null:
return serverOrderUpdate(_that);case ServerMetadataUpdate() when serverMetadataUpdate != null:
return serverMetadataUpdate(_that);case GoBackKioskWizard() when goBack != null:
return goBack(_that);case GoToStep() when goToStep != null:
return goToStep(_that);case SubmitUserName() when submitUserName != null:
return submitUserName(_that);case SelectImage() when selectImage != null:
return selectImage(_that);case UpdateLatteImages() when updateLatteImages != null:
return updateLatteImages(_that);case NewImageLatteBatch() when newImageLatteBatch != null:
return newImageLatteBatch(_that);case UpdateQuestions() when updateQuestions != null:
return updateQuestions(_that);case AnswerQuestion() when answerQuestion != null:
return answerQuestion(_that);case GenerateRevisedImages() when generateRevisedImages != null:
return generateRevisedImages(_that);case RejectImageBatch() when rejectImageBatch != null:
return rejectImageBatch(_that);case AcceptImage() when acceptImage != null:
return acceptImage(_that);case SubmitOrder() when submitOrder != null:
return submitOrder(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( KioskWizardStep newStep)?  onNewPage,TResult Function()?  startOver,TResult Function()?  ejectData,TResult Function( List<LatteOrder> orders)?  loadPreExistingOrders,TResult Function( LatteOrder order,  LatteOrderMetadata metadata)?  applyPreExistingOrder,TResult Function( List<LatteOption>? milkOptions)?  updateMilkOptions,TResult Function( List<LatteOption>? sweetenerOptions)?  updateSweetenerOptions,TResult Function( String milk)?  selectMilk,TResult Function( String sweetener)?  selectSweetener,TResult Function()?  submitMilkAndSweetener,TResult Function( String happyPlace)?  submitHappyPlace,TResult Function( String reason)?  happyPlaceRejected,TResult Function()?  happyPlaceModerationReasonShown,TResult Function( LatteOrder? order)?  serverOrderUpdate,TResult Function( LatteOrderMetadata? metadata)?  serverMetadataUpdate,TResult Function()?  goBack,TResult Function( KioskWizardStep step)?  goToStep,TResult Function( String name)?  submitUserName,TResult Function( int index)?  selectImage,TResult Function( LatteImageBatch? batch)?  updateLatteImages,TResult Function( String latteImageBatchId)?  newImageLatteBatch,TResult Function( List<Question> questions)?  updateQuestions,TResult Function( Question question,  Object? answer)?  answerQuestion,TResult Function()?  generateRevisedImages,TResult Function()?  rejectImageBatch,TResult Function()?  acceptImage,TResult Function()?  submitOrder,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnNewPage() when onNewPage != null:
return onNewPage(_that.newStep);case StartOver() when startOver != null:
return startOver();case _EjectData() when ejectData != null:
return ejectData();case LoadPreExistingOrders() when loadPreExistingOrders != null:
return loadPreExistingOrders(_that.orders);case ApplyPreExistingOrder() when applyPreExistingOrder != null:
return applyPreExistingOrder(_that.order,_that.metadata);case UpdateMilkOptions() when updateMilkOptions != null:
return updateMilkOptions(_that.milkOptions);case UpdateSweetenerOptions() when updateSweetenerOptions != null:
return updateSweetenerOptions(_that.sweetenerOptions);case SelectMilk() when selectMilk != null:
return selectMilk(_that.milk);case SelectSweetener() when selectSweetener != null:
return selectSweetener(_that.sweetener);case SubmitMilkAndSweetener() when submitMilkAndSweetener != null:
return submitMilkAndSweetener();case SubmitHappyPlace() when submitHappyPlace != null:
return submitHappyPlace(_that.happyPlace);case HappyPlaceRejected() when happyPlaceRejected != null:
return happyPlaceRejected(_that.reason);case HappyPlaceModerationReasonShown() when happyPlaceModerationReasonShown != null:
return happyPlaceModerationReasonShown();case ServerOrderUpdate() when serverOrderUpdate != null:
return serverOrderUpdate(_that.order);case ServerMetadataUpdate() when serverMetadataUpdate != null:
return serverMetadataUpdate(_that.metadata);case GoBackKioskWizard() when goBack != null:
return goBack();case GoToStep() when goToStep != null:
return goToStep(_that.step);case SubmitUserName() when submitUserName != null:
return submitUserName(_that.name);case SelectImage() when selectImage != null:
return selectImage(_that.index);case UpdateLatteImages() when updateLatteImages != null:
return updateLatteImages(_that.batch);case NewImageLatteBatch() when newImageLatteBatch != null:
return newImageLatteBatch(_that.latteImageBatchId);case UpdateQuestions() when updateQuestions != null:
return updateQuestions(_that.questions);case AnswerQuestion() when answerQuestion != null:
return answerQuestion(_that.question,_that.answer);case GenerateRevisedImages() when generateRevisedImages != null:
return generateRevisedImages();case RejectImageBatch() when rejectImageBatch != null:
return rejectImageBatch();case AcceptImage() when acceptImage != null:
return acceptImage();case SubmitOrder() when submitOrder != null:
return submitOrder();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( KioskWizardStep newStep)  onNewPage,required TResult Function()  startOver,required TResult Function()  ejectData,required TResult Function( List<LatteOrder> orders)  loadPreExistingOrders,required TResult Function( LatteOrder order,  LatteOrderMetadata metadata)  applyPreExistingOrder,required TResult Function( List<LatteOption>? milkOptions)  updateMilkOptions,required TResult Function( List<LatteOption>? sweetenerOptions)  updateSweetenerOptions,required TResult Function( String milk)  selectMilk,required TResult Function( String sweetener)  selectSweetener,required TResult Function()  submitMilkAndSweetener,required TResult Function( String happyPlace)  submitHappyPlace,required TResult Function( String reason)  happyPlaceRejected,required TResult Function()  happyPlaceModerationReasonShown,required TResult Function( LatteOrder? order)  serverOrderUpdate,required TResult Function( LatteOrderMetadata? metadata)  serverMetadataUpdate,required TResult Function()  goBack,required TResult Function( KioskWizardStep step)  goToStep,required TResult Function( String name)  submitUserName,required TResult Function( int index)  selectImage,required TResult Function( LatteImageBatch? batch)  updateLatteImages,required TResult Function( String latteImageBatchId)  newImageLatteBatch,required TResult Function( List<Question> questions)  updateQuestions,required TResult Function( Question question,  Object? answer)  answerQuestion,required TResult Function()  generateRevisedImages,required TResult Function()  rejectImageBatch,required TResult Function()  acceptImage,required TResult Function()  submitOrder,}) {final _that = this;
switch (_that) {
case OnNewPage():
return onNewPage(_that.newStep);case StartOver():
return startOver();case _EjectData():
return ejectData();case LoadPreExistingOrders():
return loadPreExistingOrders(_that.orders);case ApplyPreExistingOrder():
return applyPreExistingOrder(_that.order,_that.metadata);case UpdateMilkOptions():
return updateMilkOptions(_that.milkOptions);case UpdateSweetenerOptions():
return updateSweetenerOptions(_that.sweetenerOptions);case SelectMilk():
return selectMilk(_that.milk);case SelectSweetener():
return selectSweetener(_that.sweetener);case SubmitMilkAndSweetener():
return submitMilkAndSweetener();case SubmitHappyPlace():
return submitHappyPlace(_that.happyPlace);case HappyPlaceRejected():
return happyPlaceRejected(_that.reason);case HappyPlaceModerationReasonShown():
return happyPlaceModerationReasonShown();case ServerOrderUpdate():
return serverOrderUpdate(_that.order);case ServerMetadataUpdate():
return serverMetadataUpdate(_that.metadata);case GoBackKioskWizard():
return goBack();case GoToStep():
return goToStep(_that.step);case SubmitUserName():
return submitUserName(_that.name);case SelectImage():
return selectImage(_that.index);case UpdateLatteImages():
return updateLatteImages(_that.batch);case NewImageLatteBatch():
return newImageLatteBatch(_that.latteImageBatchId);case UpdateQuestions():
return updateQuestions(_that.questions);case AnswerQuestion():
return answerQuestion(_that.question,_that.answer);case GenerateRevisedImages():
return generateRevisedImages();case RejectImageBatch():
return rejectImageBatch();case AcceptImage():
return acceptImage();case SubmitOrder():
return submitOrder();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( KioskWizardStep newStep)?  onNewPage,TResult? Function()?  startOver,TResult? Function()?  ejectData,TResult? Function( List<LatteOrder> orders)?  loadPreExistingOrders,TResult? Function( LatteOrder order,  LatteOrderMetadata metadata)?  applyPreExistingOrder,TResult? Function( List<LatteOption>? milkOptions)?  updateMilkOptions,TResult? Function( List<LatteOption>? sweetenerOptions)?  updateSweetenerOptions,TResult? Function( String milk)?  selectMilk,TResult? Function( String sweetener)?  selectSweetener,TResult? Function()?  submitMilkAndSweetener,TResult? Function( String happyPlace)?  submitHappyPlace,TResult? Function( String reason)?  happyPlaceRejected,TResult? Function()?  happyPlaceModerationReasonShown,TResult? Function( LatteOrder? order)?  serverOrderUpdate,TResult? Function( LatteOrderMetadata? metadata)?  serverMetadataUpdate,TResult? Function()?  goBack,TResult? Function( KioskWizardStep step)?  goToStep,TResult? Function( String name)?  submitUserName,TResult? Function( int index)?  selectImage,TResult? Function( LatteImageBatch? batch)?  updateLatteImages,TResult? Function( String latteImageBatchId)?  newImageLatteBatch,TResult? Function( List<Question> questions)?  updateQuestions,TResult? Function( Question question,  Object? answer)?  answerQuestion,TResult? Function()?  generateRevisedImages,TResult? Function()?  rejectImageBatch,TResult? Function()?  acceptImage,TResult? Function()?  submitOrder,}) {final _that = this;
switch (_that) {
case OnNewPage() when onNewPage != null:
return onNewPage(_that.newStep);case StartOver() when startOver != null:
return startOver();case _EjectData() when ejectData != null:
return ejectData();case LoadPreExistingOrders() when loadPreExistingOrders != null:
return loadPreExistingOrders(_that.orders);case ApplyPreExistingOrder() when applyPreExistingOrder != null:
return applyPreExistingOrder(_that.order,_that.metadata);case UpdateMilkOptions() when updateMilkOptions != null:
return updateMilkOptions(_that.milkOptions);case UpdateSweetenerOptions() when updateSweetenerOptions != null:
return updateSweetenerOptions(_that.sweetenerOptions);case SelectMilk() when selectMilk != null:
return selectMilk(_that.milk);case SelectSweetener() when selectSweetener != null:
return selectSweetener(_that.sweetener);case SubmitMilkAndSweetener() when submitMilkAndSweetener != null:
return submitMilkAndSweetener();case SubmitHappyPlace() when submitHappyPlace != null:
return submitHappyPlace(_that.happyPlace);case HappyPlaceRejected() when happyPlaceRejected != null:
return happyPlaceRejected(_that.reason);case HappyPlaceModerationReasonShown() when happyPlaceModerationReasonShown != null:
return happyPlaceModerationReasonShown();case ServerOrderUpdate() when serverOrderUpdate != null:
return serverOrderUpdate(_that.order);case ServerMetadataUpdate() when serverMetadataUpdate != null:
return serverMetadataUpdate(_that.metadata);case GoBackKioskWizard() when goBack != null:
return goBack();case GoToStep() when goToStep != null:
return goToStep(_that.step);case SubmitUserName() when submitUserName != null:
return submitUserName(_that.name);case SelectImage() when selectImage != null:
return selectImage(_that.index);case UpdateLatteImages() when updateLatteImages != null:
return updateLatteImages(_that.batch);case NewImageLatteBatch() when newImageLatteBatch != null:
return newImageLatteBatch(_that.latteImageBatchId);case UpdateQuestions() when updateQuestions != null:
return updateQuestions(_that.questions);case AnswerQuestion() when answerQuestion != null:
return answerQuestion(_that.question,_that.answer);case GenerateRevisedImages() when generateRevisedImages != null:
return generateRevisedImages();case RejectImageBatch() when rejectImageBatch != null:
return rejectImageBatch();case AcceptImage() when acceptImage != null:
return acceptImage();case SubmitOrder() when submitOrder != null:
return submitOrder();case _:
  return null;

}
}

}

/// @nodoc


class OnNewPage implements KioskHomeEvent {
  const OnNewPage(this.newStep);
  

 final  KioskWizardStep newStep;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnNewPageCopyWith<OnNewPage> get copyWith => _$OnNewPageCopyWithImpl<OnNewPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnNewPage&&(identical(other.newStep, newStep) || other.newStep == newStep));
}


@override
int get hashCode => Object.hash(runtimeType,newStep);

@override
String toString() {
  return 'KioskHomeEvent.onNewPage(newStep: $newStep)';
}


}

/// @nodoc
abstract mixin class $OnNewPageCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $OnNewPageCopyWith(OnNewPage value, $Res Function(OnNewPage) _then) = _$OnNewPageCopyWithImpl;
@useResult
$Res call({
 KioskWizardStep newStep
});




}
/// @nodoc
class _$OnNewPageCopyWithImpl<$Res>
    implements $OnNewPageCopyWith<$Res> {
  _$OnNewPageCopyWithImpl(this._self, this._then);

  final OnNewPage _self;
  final $Res Function(OnNewPage) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? newStep = null,}) {
  return _then(OnNewPage(
null == newStep ? _self.newStep : newStep // ignore: cast_nullable_to_non_nullable
as KioskWizardStep,
  ));
}


}

/// @nodoc


class StartOver implements KioskHomeEvent {
  const StartOver();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartOver);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KioskHomeEvent.startOver()';
}


}




/// @nodoc


class _EjectData implements KioskHomeEvent {
  const _EjectData();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EjectData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KioskHomeEvent.ejectData()';
}


}




/// @nodoc


class LoadPreExistingOrders implements KioskHomeEvent {
  const LoadPreExistingOrders(final  List<LatteOrder> orders): _orders = orders;
  

 final  List<LatteOrder> _orders;
 List<LatteOrder> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}


/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadPreExistingOrdersCopyWith<LoadPreExistingOrders> get copyWith => _$LoadPreExistingOrdersCopyWithImpl<LoadPreExistingOrders>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadPreExistingOrders&&const DeepCollectionEquality().equals(other._orders, _orders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders));

@override
String toString() {
  return 'KioskHomeEvent.loadPreExistingOrders(orders: $orders)';
}


}

/// @nodoc
abstract mixin class $LoadPreExistingOrdersCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $LoadPreExistingOrdersCopyWith(LoadPreExistingOrders value, $Res Function(LoadPreExistingOrders) _then) = _$LoadPreExistingOrdersCopyWithImpl;
@useResult
$Res call({
 List<LatteOrder> orders
});




}
/// @nodoc
class _$LoadPreExistingOrdersCopyWithImpl<$Res>
    implements $LoadPreExistingOrdersCopyWith<$Res> {
  _$LoadPreExistingOrdersCopyWithImpl(this._self, this._then);

  final LoadPreExistingOrders _self;
  final $Res Function(LoadPreExistingOrders) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,}) {
  return _then(LoadPreExistingOrders(
null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<LatteOrder>,
  ));
}


}

/// @nodoc


class ApplyPreExistingOrder implements KioskHomeEvent {
  const ApplyPreExistingOrder(this.order, this.metadata);
  

 final  LatteOrder order;
 final  LatteOrderMetadata metadata;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplyPreExistingOrderCopyWith<ApplyPreExistingOrder> get copyWith => _$ApplyPreExistingOrderCopyWithImpl<ApplyPreExistingOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplyPreExistingOrder&&(identical(other.order, order) || other.order == order)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}


@override
int get hashCode => Object.hash(runtimeType,order,metadata);

@override
String toString() {
  return 'KioskHomeEvent.applyPreExistingOrder(order: $order, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ApplyPreExistingOrderCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $ApplyPreExistingOrderCopyWith(ApplyPreExistingOrder value, $Res Function(ApplyPreExistingOrder) _then) = _$ApplyPreExistingOrderCopyWithImpl;
@useResult
$Res call({
 LatteOrder order, LatteOrderMetadata metadata
});


$LatteOrderCopyWith<$Res> get order;$LatteOrderMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$ApplyPreExistingOrderCopyWithImpl<$Res>
    implements $ApplyPreExistingOrderCopyWith<$Res> {
  _$ApplyPreExistingOrderCopyWithImpl(this._self, this._then);

  final ApplyPreExistingOrder _self;
  final $Res Function(ApplyPreExistingOrder) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,Object? metadata = null,}) {
  return _then(ApplyPreExistingOrder(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as LatteOrder,null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as LatteOrderMetadata,
  ));
}

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderCopyWith<$Res> get order {
  
  return $LatteOrderCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderMetadataCopyWith<$Res> get metadata {
  
  return $LatteOrderMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

/// @nodoc


class UpdateMilkOptions implements KioskHomeEvent {
  const UpdateMilkOptions(final  List<LatteOption>? milkOptions): _milkOptions = milkOptions;
  

 final  List<LatteOption>? _milkOptions;
 List<LatteOption>? get milkOptions {
  final value = _milkOptions;
  if (value == null) return null;
  if (_milkOptions is EqualUnmodifiableListView) return _milkOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateMilkOptionsCopyWith<UpdateMilkOptions> get copyWith => _$UpdateMilkOptionsCopyWithImpl<UpdateMilkOptions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateMilkOptions&&const DeepCollectionEquality().equals(other._milkOptions, _milkOptions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_milkOptions));

@override
String toString() {
  return 'KioskHomeEvent.updateMilkOptions(milkOptions: $milkOptions)';
}


}

/// @nodoc
abstract mixin class $UpdateMilkOptionsCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $UpdateMilkOptionsCopyWith(UpdateMilkOptions value, $Res Function(UpdateMilkOptions) _then) = _$UpdateMilkOptionsCopyWithImpl;
@useResult
$Res call({
 List<LatteOption>? milkOptions
});




}
/// @nodoc
class _$UpdateMilkOptionsCopyWithImpl<$Res>
    implements $UpdateMilkOptionsCopyWith<$Res> {
  _$UpdateMilkOptionsCopyWithImpl(this._self, this._then);

  final UpdateMilkOptions _self;
  final $Res Function(UpdateMilkOptions) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? milkOptions = freezed,}) {
  return _then(UpdateMilkOptions(
freezed == milkOptions ? _self._milkOptions : milkOptions // ignore: cast_nullable_to_non_nullable
as List<LatteOption>?,
  ));
}


}

/// @nodoc


class UpdateSweetenerOptions implements KioskHomeEvent {
  const UpdateSweetenerOptions(final  List<LatteOption>? sweetenerOptions): _sweetenerOptions = sweetenerOptions;
  

 final  List<LatteOption>? _sweetenerOptions;
 List<LatteOption>? get sweetenerOptions {
  final value = _sweetenerOptions;
  if (value == null) return null;
  if (_sweetenerOptions is EqualUnmodifiableListView) return _sweetenerOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateSweetenerOptionsCopyWith<UpdateSweetenerOptions> get copyWith => _$UpdateSweetenerOptionsCopyWithImpl<UpdateSweetenerOptions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateSweetenerOptions&&const DeepCollectionEquality().equals(other._sweetenerOptions, _sweetenerOptions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sweetenerOptions));

@override
String toString() {
  return 'KioskHomeEvent.updateSweetenerOptions(sweetenerOptions: $sweetenerOptions)';
}


}

/// @nodoc
abstract mixin class $UpdateSweetenerOptionsCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $UpdateSweetenerOptionsCopyWith(UpdateSweetenerOptions value, $Res Function(UpdateSweetenerOptions) _then) = _$UpdateSweetenerOptionsCopyWithImpl;
@useResult
$Res call({
 List<LatteOption>? sweetenerOptions
});




}
/// @nodoc
class _$UpdateSweetenerOptionsCopyWithImpl<$Res>
    implements $UpdateSweetenerOptionsCopyWith<$Res> {
  _$UpdateSweetenerOptionsCopyWithImpl(this._self, this._then);

  final UpdateSweetenerOptions _self;
  final $Res Function(UpdateSweetenerOptions) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sweetenerOptions = freezed,}) {
  return _then(UpdateSweetenerOptions(
freezed == sweetenerOptions ? _self._sweetenerOptions : sweetenerOptions // ignore: cast_nullable_to_non_nullable
as List<LatteOption>?,
  ));
}


}

/// @nodoc


class SelectMilk implements KioskHomeEvent {
  const SelectMilk(this.milk);
  

 final  String milk;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectMilkCopyWith<SelectMilk> get copyWith => _$SelectMilkCopyWithImpl<SelectMilk>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectMilk&&(identical(other.milk, milk) || other.milk == milk));
}


@override
int get hashCode => Object.hash(runtimeType,milk);

@override
String toString() {
  return 'KioskHomeEvent.selectMilk(milk: $milk)';
}


}

/// @nodoc
abstract mixin class $SelectMilkCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $SelectMilkCopyWith(SelectMilk value, $Res Function(SelectMilk) _then) = _$SelectMilkCopyWithImpl;
@useResult
$Res call({
 String milk
});




}
/// @nodoc
class _$SelectMilkCopyWithImpl<$Res>
    implements $SelectMilkCopyWith<$Res> {
  _$SelectMilkCopyWithImpl(this._self, this._then);

  final SelectMilk _self;
  final $Res Function(SelectMilk) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? milk = null,}) {
  return _then(SelectMilk(
null == milk ? _self.milk : milk // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SelectSweetener implements KioskHomeEvent {
  const SelectSweetener(this.sweetener);
  

 final  String sweetener;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectSweetenerCopyWith<SelectSweetener> get copyWith => _$SelectSweetenerCopyWithImpl<SelectSweetener>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectSweetener&&(identical(other.sweetener, sweetener) || other.sweetener == sweetener));
}


@override
int get hashCode => Object.hash(runtimeType,sweetener);

@override
String toString() {
  return 'KioskHomeEvent.selectSweetener(sweetener: $sweetener)';
}


}

/// @nodoc
abstract mixin class $SelectSweetenerCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $SelectSweetenerCopyWith(SelectSweetener value, $Res Function(SelectSweetener) _then) = _$SelectSweetenerCopyWithImpl;
@useResult
$Res call({
 String sweetener
});




}
/// @nodoc
class _$SelectSweetenerCopyWithImpl<$Res>
    implements $SelectSweetenerCopyWith<$Res> {
  _$SelectSweetenerCopyWithImpl(this._self, this._then);

  final SelectSweetener _self;
  final $Res Function(SelectSweetener) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sweetener = null,}) {
  return _then(SelectSweetener(
null == sweetener ? _self.sweetener : sweetener // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SubmitMilkAndSweetener implements KioskHomeEvent {
  const SubmitMilkAndSweetener();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitMilkAndSweetener);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KioskHomeEvent.submitMilkAndSweetener()';
}


}




/// @nodoc


class SubmitHappyPlace implements KioskHomeEvent {
  const SubmitHappyPlace(this.happyPlace);
  

 final  String happyPlace;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitHappyPlaceCopyWith<SubmitHappyPlace> get copyWith => _$SubmitHappyPlaceCopyWithImpl<SubmitHappyPlace>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitHappyPlace&&(identical(other.happyPlace, happyPlace) || other.happyPlace == happyPlace));
}


@override
int get hashCode => Object.hash(runtimeType,happyPlace);

@override
String toString() {
  return 'KioskHomeEvent.submitHappyPlace(happyPlace: $happyPlace)';
}


}

/// @nodoc
abstract mixin class $SubmitHappyPlaceCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $SubmitHappyPlaceCopyWith(SubmitHappyPlace value, $Res Function(SubmitHappyPlace) _then) = _$SubmitHappyPlaceCopyWithImpl;
@useResult
$Res call({
 String happyPlace
});




}
/// @nodoc
class _$SubmitHappyPlaceCopyWithImpl<$Res>
    implements $SubmitHappyPlaceCopyWith<$Res> {
  _$SubmitHappyPlaceCopyWithImpl(this._self, this._then);

  final SubmitHappyPlace _self;
  final $Res Function(SubmitHappyPlace) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? happyPlace = null,}) {
  return _then(SubmitHappyPlace(
null == happyPlace ? _self.happyPlace : happyPlace // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class HappyPlaceRejected implements KioskHomeEvent {
  const HappyPlaceRejected(this.reason);
  

 final  String reason;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HappyPlaceRejectedCopyWith<HappyPlaceRejected> get copyWith => _$HappyPlaceRejectedCopyWithImpl<HappyPlaceRejected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HappyPlaceRejected&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'KioskHomeEvent.happyPlaceRejected(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $HappyPlaceRejectedCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $HappyPlaceRejectedCopyWith(HappyPlaceRejected value, $Res Function(HappyPlaceRejected) _then) = _$HappyPlaceRejectedCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$HappyPlaceRejectedCopyWithImpl<$Res>
    implements $HappyPlaceRejectedCopyWith<$Res> {
  _$HappyPlaceRejectedCopyWithImpl(this._self, this._then);

  final HappyPlaceRejected _self;
  final $Res Function(HappyPlaceRejected) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(HappyPlaceRejected(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class HappyPlaceModerationReasonShown implements KioskHomeEvent {
  const HappyPlaceModerationReasonShown();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HappyPlaceModerationReasonShown);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KioskHomeEvent.happyPlaceModerationReasonShown()';
}


}




/// @nodoc


class ServerOrderUpdate implements KioskHomeEvent {
  const ServerOrderUpdate(this.order);
  

 final  LatteOrder? order;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerOrderUpdateCopyWith<ServerOrderUpdate> get copyWith => _$ServerOrderUpdateCopyWithImpl<ServerOrderUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerOrderUpdate&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'KioskHomeEvent.serverOrderUpdate(order: $order)';
}


}

/// @nodoc
abstract mixin class $ServerOrderUpdateCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $ServerOrderUpdateCopyWith(ServerOrderUpdate value, $Res Function(ServerOrderUpdate) _then) = _$ServerOrderUpdateCopyWithImpl;
@useResult
$Res call({
 LatteOrder? order
});


$LatteOrderCopyWith<$Res>? get order;

}
/// @nodoc
class _$ServerOrderUpdateCopyWithImpl<$Res>
    implements $ServerOrderUpdateCopyWith<$Res> {
  _$ServerOrderUpdateCopyWithImpl(this._self, this._then);

  final ServerOrderUpdate _self;
  final $Res Function(ServerOrderUpdate) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = freezed,}) {
  return _then(ServerOrderUpdate(
freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as LatteOrder?,
  ));
}

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderCopyWith<$Res>? get order {
    if (_self.order == null) {
    return null;
  }

  return $LatteOrderCopyWith<$Res>(_self.order!, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}

/// @nodoc


class ServerMetadataUpdate implements KioskHomeEvent {
  const ServerMetadataUpdate(this.metadata);
  

 final  LatteOrderMetadata? metadata;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerMetadataUpdateCopyWith<ServerMetadataUpdate> get copyWith => _$ServerMetadataUpdateCopyWithImpl<ServerMetadataUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMetadataUpdate&&(identical(other.metadata, metadata) || other.metadata == metadata));
}


@override
int get hashCode => Object.hash(runtimeType,metadata);

@override
String toString() {
  return 'KioskHomeEvent.serverMetadataUpdate(metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ServerMetadataUpdateCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $ServerMetadataUpdateCopyWith(ServerMetadataUpdate value, $Res Function(ServerMetadataUpdate) _then) = _$ServerMetadataUpdateCopyWithImpl;
@useResult
$Res call({
 LatteOrderMetadata? metadata
});


$LatteOrderMetadataCopyWith<$Res>? get metadata;

}
/// @nodoc
class _$ServerMetadataUpdateCopyWithImpl<$Res>
    implements $ServerMetadataUpdateCopyWith<$Res> {
  _$ServerMetadataUpdateCopyWithImpl(this._self, this._then);

  final ServerMetadataUpdate _self;
  final $Res Function(ServerMetadataUpdate) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? metadata = freezed,}) {
  return _then(ServerMetadataUpdate(
freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as LatteOrderMetadata?,
  ));
}

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
    return null;
  }

  return $LatteOrderMetadataCopyWith<$Res>(_self.metadata!, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

/// @nodoc


class GoBackKioskWizard implements KioskHomeEvent {
  const GoBackKioskWizard();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoBackKioskWizard);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KioskHomeEvent.goBack()';
}


}




/// @nodoc


class GoToStep implements KioskHomeEvent {
  const GoToStep(this.step);
  

 final  KioskWizardStep step;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoToStepCopyWith<GoToStep> get copyWith => _$GoToStepCopyWithImpl<GoToStep>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoToStep&&(identical(other.step, step) || other.step == step));
}


@override
int get hashCode => Object.hash(runtimeType,step);

@override
String toString() {
  return 'KioskHomeEvent.goToStep(step: $step)';
}


}

/// @nodoc
abstract mixin class $GoToStepCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $GoToStepCopyWith(GoToStep value, $Res Function(GoToStep) _then) = _$GoToStepCopyWithImpl;
@useResult
$Res call({
 KioskWizardStep step
});




}
/// @nodoc
class _$GoToStepCopyWithImpl<$Res>
    implements $GoToStepCopyWith<$Res> {
  _$GoToStepCopyWithImpl(this._self, this._then);

  final GoToStep _self;
  final $Res Function(GoToStep) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,}) {
  return _then(GoToStep(
null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as KioskWizardStep,
  ));
}


}

/// @nodoc


class SubmitUserName implements KioskHomeEvent {
  const SubmitUserName(this.name);
  

 final  String name;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitUserNameCopyWith<SubmitUserName> get copyWith => _$SubmitUserNameCopyWithImpl<SubmitUserName>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitUserName&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'KioskHomeEvent.submitUserName(name: $name)';
}


}

/// @nodoc
abstract mixin class $SubmitUserNameCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $SubmitUserNameCopyWith(SubmitUserName value, $Res Function(SubmitUserName) _then) = _$SubmitUserNameCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$SubmitUserNameCopyWithImpl<$Res>
    implements $SubmitUserNameCopyWith<$Res> {
  _$SubmitUserNameCopyWithImpl(this._self, this._then);

  final SubmitUserName _self;
  final $Res Function(SubmitUserName) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(SubmitUserName(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SelectImage implements KioskHomeEvent {
  const SelectImage(this.index);
  

 final  int index;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectImageCopyWith<SelectImage> get copyWith => _$SelectImageCopyWithImpl<SelectImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectImage&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'KioskHomeEvent.selectImage(index: $index)';
}


}

/// @nodoc
abstract mixin class $SelectImageCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $SelectImageCopyWith(SelectImage value, $Res Function(SelectImage) _then) = _$SelectImageCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$SelectImageCopyWithImpl<$Res>
    implements $SelectImageCopyWith<$Res> {
  _$SelectImageCopyWithImpl(this._self, this._then);

  final SelectImage _self;
  final $Res Function(SelectImage) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(SelectImage(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class UpdateLatteImages implements KioskHomeEvent {
  const UpdateLatteImages(this.batch);
  

 final  LatteImageBatch? batch;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateLatteImagesCopyWith<UpdateLatteImages> get copyWith => _$UpdateLatteImagesCopyWithImpl<UpdateLatteImages>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateLatteImages&&(identical(other.batch, batch) || other.batch == batch));
}


@override
int get hashCode => Object.hash(runtimeType,batch);

@override
String toString() {
  return 'KioskHomeEvent.updateLatteImages(batch: $batch)';
}


}

/// @nodoc
abstract mixin class $UpdateLatteImagesCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $UpdateLatteImagesCopyWith(UpdateLatteImages value, $Res Function(UpdateLatteImages) _then) = _$UpdateLatteImagesCopyWithImpl;
@useResult
$Res call({
 LatteImageBatch? batch
});


$LatteImageBatchCopyWith<$Res>? get batch;

}
/// @nodoc
class _$UpdateLatteImagesCopyWithImpl<$Res>
    implements $UpdateLatteImagesCopyWith<$Res> {
  _$UpdateLatteImagesCopyWithImpl(this._self, this._then);

  final UpdateLatteImages _self;
  final $Res Function(UpdateLatteImages) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? batch = freezed,}) {
  return _then(UpdateLatteImages(
freezed == batch ? _self.batch : batch // ignore: cast_nullable_to_non_nullable
as LatteImageBatch?,
  ));
}

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageBatchCopyWith<$Res>? get batch {
    if (_self.batch == null) {
    return null;
  }

  return $LatteImageBatchCopyWith<$Res>(_self.batch!, (value) {
    return _then(_self.copyWith(batch: value));
  });
}
}

/// @nodoc


class NewImageLatteBatch implements KioskHomeEvent {
  const NewImageLatteBatch(this.latteImageBatchId);
  

 final  String latteImageBatchId;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewImageLatteBatchCopyWith<NewImageLatteBatch> get copyWith => _$NewImageLatteBatchCopyWithImpl<NewImageLatteBatch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewImageLatteBatch&&(identical(other.latteImageBatchId, latteImageBatchId) || other.latteImageBatchId == latteImageBatchId));
}


@override
int get hashCode => Object.hash(runtimeType,latteImageBatchId);

@override
String toString() {
  return 'KioskHomeEvent.newImageLatteBatch(latteImageBatchId: $latteImageBatchId)';
}


}

/// @nodoc
abstract mixin class $NewImageLatteBatchCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $NewImageLatteBatchCopyWith(NewImageLatteBatch value, $Res Function(NewImageLatteBatch) _then) = _$NewImageLatteBatchCopyWithImpl;
@useResult
$Res call({
 String latteImageBatchId
});




}
/// @nodoc
class _$NewImageLatteBatchCopyWithImpl<$Res>
    implements $NewImageLatteBatchCopyWith<$Res> {
  _$NewImageLatteBatchCopyWithImpl(this._self, this._then);

  final NewImageLatteBatch _self;
  final $Res Function(NewImageLatteBatch) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? latteImageBatchId = null,}) {
  return _then(NewImageLatteBatch(
null == latteImageBatchId ? _self.latteImageBatchId : latteImageBatchId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UpdateQuestions implements KioskHomeEvent {
  const UpdateQuestions(final  List<Question> questions): _questions = questions;
  

 final  List<Question> _questions;
 List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateQuestionsCopyWith<UpdateQuestions> get copyWith => _$UpdateQuestionsCopyWithImpl<UpdateQuestions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateQuestions&&const DeepCollectionEquality().equals(other._questions, _questions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'KioskHomeEvent.updateQuestions(questions: $questions)';
}


}

/// @nodoc
abstract mixin class $UpdateQuestionsCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $UpdateQuestionsCopyWith(UpdateQuestions value, $Res Function(UpdateQuestions) _then) = _$UpdateQuestionsCopyWithImpl;
@useResult
$Res call({
 List<Question> questions
});




}
/// @nodoc
class _$UpdateQuestionsCopyWithImpl<$Res>
    implements $UpdateQuestionsCopyWith<$Res> {
  _$UpdateQuestionsCopyWithImpl(this._self, this._then);

  final UpdateQuestions _self;
  final $Res Function(UpdateQuestions) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? questions = null,}) {
  return _then(UpdateQuestions(
null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,
  ));
}


}

/// @nodoc


class AnswerQuestion implements KioskHomeEvent {
  const AnswerQuestion(this.question, this.answer);
  

 final  Question question;
 final  Object? answer;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnswerQuestionCopyWith<AnswerQuestion> get copyWith => _$AnswerQuestionCopyWithImpl<AnswerQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnswerQuestion&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.answer, answer));
}


@override
int get hashCode => Object.hash(runtimeType,question,const DeepCollectionEquality().hash(answer));

@override
String toString() {
  return 'KioskHomeEvent.answerQuestion(question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $AnswerQuestionCopyWith<$Res> implements $KioskHomeEventCopyWith<$Res> {
  factory $AnswerQuestionCopyWith(AnswerQuestion value, $Res Function(AnswerQuestion) _then) = _$AnswerQuestionCopyWithImpl;
@useResult
$Res call({
 Question question, Object? answer
});


$QuestionCopyWith<$Res> get question;

}
/// @nodoc
class _$AnswerQuestionCopyWithImpl<$Res>
    implements $AnswerQuestionCopyWith<$Res> {
  _$AnswerQuestionCopyWithImpl(this._self, this._then);

  final AnswerQuestion _self;
  final $Res Function(AnswerQuestion) _then;

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? question = null,Object? answer = freezed,}) {
  return _then(AnswerQuestion(
null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as Question,freezed == answer ? _self.answer : answer ,
  ));
}

/// Create a copy of KioskHomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionCopyWith<$Res> get question {
  
  return $QuestionCopyWith<$Res>(_self.question, (value) {
    return _then(_self.copyWith(question: value));
  });
}
}

/// @nodoc


class GenerateRevisedImages implements KioskHomeEvent {
  const GenerateRevisedImages();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerateRevisedImages);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KioskHomeEvent.generateRevisedImages()';
}


}




/// @nodoc


class RejectImageBatch implements KioskHomeEvent {
  const RejectImageBatch();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RejectImageBatch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KioskHomeEvent.rejectImageBatch()';
}


}




/// @nodoc


class AcceptImage implements KioskHomeEvent {
  const AcceptImage();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcceptImage);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KioskHomeEvent.acceptImage()';
}


}




/// @nodoc


class SubmitOrder implements KioskHomeEvent {
  const SubmitOrder();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitOrder);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KioskHomeEvent.submitOrder()';
}


}




/// @nodoc
mixin _$KioskHomeState {

 KioskWizardStep get currentStep; LatteOrder? get order; LatteOrderMetadata? get metadata; ModerationEvent? get happyPlaceModerationEvent; bool get isSubmitting; bool get isReverting;/// When the user submits a happy place, or a tweak,
/// the clock starts ticking on image generation.
/// We want to track this time. If for nothing else, it helps us show
/// a progress bar that doesn't depend on widget states being mounted
/// throughout the image generation without gaps.
 DateTime? get imageGenerationStartTime;/// When an image's questions are requested before they exist, we store the
/// need here so that we add them to the state once they arrive.
 bool get awaitingQuestions;/// The current batch of 4 images to choose from. This is deduced by the
/// [LatteOrderMetadata]'s `latteBatchId` field.
 LatteImageBatch? get imagesBatch;/// Copy of the active [LatteImage]'s questions, only set once the user
/// chooses an image and clicks the "tweak image" button. This copy is used
/// instead of the questions in the [LatteImage] to isolate the user's
/// answers from changes to the [LatteImageBatch]. The critical detail is
/// that answers are not persisted to Firebase, which means anything that
/// overwrites the [LatteImageBatch] would clobber the user's answers.
 List<Question> get questions;/// Values loaded straight from Firebase.
@LatteOptionConverter() List<LatteOption>? get milkOptions;/// Values loaded straight from Firebase.
@LatteOptionConverter() List<LatteOption>? get sweetenerOptions;/// True if the user is starting over and we want to eject data upon
/// returning to the .intro screen.
 bool get shouldClearData; int? get selectedImageIndex;
/// Create a copy of KioskHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KioskHomeStateCopyWith<KioskHomeState> get copyWith => _$KioskHomeStateCopyWithImpl<KioskHomeState>(this as KioskHomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KioskHomeState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.order, order) || other.order == order)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.happyPlaceModerationEvent, happyPlaceModerationEvent) || other.happyPlaceModerationEvent == happyPlaceModerationEvent)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isReverting, isReverting) || other.isReverting == isReverting)&&(identical(other.imageGenerationStartTime, imageGenerationStartTime) || other.imageGenerationStartTime == imageGenerationStartTime)&&(identical(other.awaitingQuestions, awaitingQuestions) || other.awaitingQuestions == awaitingQuestions)&&(identical(other.imagesBatch, imagesBatch) || other.imagesBatch == imagesBatch)&&const DeepCollectionEquality().equals(other.questions, questions)&&const DeepCollectionEquality().equals(other.milkOptions, milkOptions)&&const DeepCollectionEquality().equals(other.sweetenerOptions, sweetenerOptions)&&(identical(other.shouldClearData, shouldClearData) || other.shouldClearData == shouldClearData)&&(identical(other.selectedImageIndex, selectedImageIndex) || other.selectedImageIndex == selectedImageIndex));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,order,metadata,happyPlaceModerationEvent,isSubmitting,isReverting,imageGenerationStartTime,awaitingQuestions,imagesBatch,const DeepCollectionEquality().hash(questions),const DeepCollectionEquality().hash(milkOptions),const DeepCollectionEquality().hash(sweetenerOptions),shouldClearData,selectedImageIndex);

@override
String toString() {
  return 'KioskHomeState(currentStep: $currentStep, order: $order, metadata: $metadata, happyPlaceModerationEvent: $happyPlaceModerationEvent, isSubmitting: $isSubmitting, isReverting: $isReverting, imageGenerationStartTime: $imageGenerationStartTime, awaitingQuestions: $awaitingQuestions, imagesBatch: $imagesBatch, questions: $questions, milkOptions: $milkOptions, sweetenerOptions: $sweetenerOptions, shouldClearData: $shouldClearData, selectedImageIndex: $selectedImageIndex)';
}


}

/// @nodoc
abstract mixin class $KioskHomeStateCopyWith<$Res>  {
  factory $KioskHomeStateCopyWith(KioskHomeState value, $Res Function(KioskHomeState) _then) = _$KioskHomeStateCopyWithImpl;
@useResult
$Res call({
 KioskWizardStep currentStep, LatteOrder? order, LatteOrderMetadata? metadata, ModerationEvent? happyPlaceModerationEvent, bool isSubmitting, bool isReverting, DateTime? imageGenerationStartTime, bool awaitingQuestions, LatteImageBatch? imagesBatch, List<Question> questions,@LatteOptionConverter() List<LatteOption>? milkOptions,@LatteOptionConverter() List<LatteOption>? sweetenerOptions, bool shouldClearData, int? selectedImageIndex
});


$LatteOrderCopyWith<$Res>? get order;$LatteOrderMetadataCopyWith<$Res>? get metadata;$LatteImageBatchCopyWith<$Res>? get imagesBatch;

}
/// @nodoc
class _$KioskHomeStateCopyWithImpl<$Res>
    implements $KioskHomeStateCopyWith<$Res> {
  _$KioskHomeStateCopyWithImpl(this._self, this._then);

  final KioskHomeState _self;
  final $Res Function(KioskHomeState) _then;

/// Create a copy of KioskHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,Object? order = freezed,Object? metadata = freezed,Object? happyPlaceModerationEvent = freezed,Object? isSubmitting = null,Object? isReverting = null,Object? imageGenerationStartTime = freezed,Object? awaitingQuestions = null,Object? imagesBatch = freezed,Object? questions = null,Object? milkOptions = freezed,Object? sweetenerOptions = freezed,Object? shouldClearData = null,Object? selectedImageIndex = freezed,}) {
  return _then(_self.copyWith(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as KioskWizardStep,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as LatteOrder?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as LatteOrderMetadata?,happyPlaceModerationEvent: freezed == happyPlaceModerationEvent ? _self.happyPlaceModerationEvent : happyPlaceModerationEvent // ignore: cast_nullable_to_non_nullable
as ModerationEvent?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isReverting: null == isReverting ? _self.isReverting : isReverting // ignore: cast_nullable_to_non_nullable
as bool,imageGenerationStartTime: freezed == imageGenerationStartTime ? _self.imageGenerationStartTime : imageGenerationStartTime // ignore: cast_nullable_to_non_nullable
as DateTime?,awaitingQuestions: null == awaitingQuestions ? _self.awaitingQuestions : awaitingQuestions // ignore: cast_nullable_to_non_nullable
as bool,imagesBatch: freezed == imagesBatch ? _self.imagesBatch : imagesBatch // ignore: cast_nullable_to_non_nullable
as LatteImageBatch?,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,milkOptions: freezed == milkOptions ? _self.milkOptions : milkOptions // ignore: cast_nullable_to_non_nullable
as List<LatteOption>?,sweetenerOptions: freezed == sweetenerOptions ? _self.sweetenerOptions : sweetenerOptions // ignore: cast_nullable_to_non_nullable
as List<LatteOption>?,shouldClearData: null == shouldClearData ? _self.shouldClearData : shouldClearData // ignore: cast_nullable_to_non_nullable
as bool,selectedImageIndex: freezed == selectedImageIndex ? _self.selectedImageIndex : selectedImageIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of KioskHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderCopyWith<$Res>? get order {
    if (_self.order == null) {
    return null;
  }

  return $LatteOrderCopyWith<$Res>(_self.order!, (value) {
    return _then(_self.copyWith(order: value));
  });
}/// Create a copy of KioskHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
    return null;
  }

  return $LatteOrderMetadataCopyWith<$Res>(_self.metadata!, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}/// Create a copy of KioskHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageBatchCopyWith<$Res>? get imagesBatch {
    if (_self.imagesBatch == null) {
    return null;
  }

  return $LatteImageBatchCopyWith<$Res>(_self.imagesBatch!, (value) {
    return _then(_self.copyWith(imagesBatch: value));
  });
}
}


/// Adds pattern-matching-related methods to [KioskHomeState].
extension KioskHomeStatePatterns on KioskHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KioskHomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KioskHomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KioskHomeState value)  $default,){
final _that = this;
switch (_that) {
case _KioskHomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KioskHomeState value)?  $default,){
final _that = this;
switch (_that) {
case _KioskHomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KioskWizardStep currentStep,  LatteOrder? order,  LatteOrderMetadata? metadata,  ModerationEvent? happyPlaceModerationEvent,  bool isSubmitting,  bool isReverting,  DateTime? imageGenerationStartTime,  bool awaitingQuestions,  LatteImageBatch? imagesBatch,  List<Question> questions, @LatteOptionConverter()  List<LatteOption>? milkOptions, @LatteOptionConverter()  List<LatteOption>? sweetenerOptions,  bool shouldClearData,  int? selectedImageIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KioskHomeState() when $default != null:
return $default(_that.currentStep,_that.order,_that.metadata,_that.happyPlaceModerationEvent,_that.isSubmitting,_that.isReverting,_that.imageGenerationStartTime,_that.awaitingQuestions,_that.imagesBatch,_that.questions,_that.milkOptions,_that.sweetenerOptions,_that.shouldClearData,_that.selectedImageIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KioskWizardStep currentStep,  LatteOrder? order,  LatteOrderMetadata? metadata,  ModerationEvent? happyPlaceModerationEvent,  bool isSubmitting,  bool isReverting,  DateTime? imageGenerationStartTime,  bool awaitingQuestions,  LatteImageBatch? imagesBatch,  List<Question> questions, @LatteOptionConverter()  List<LatteOption>? milkOptions, @LatteOptionConverter()  List<LatteOption>? sweetenerOptions,  bool shouldClearData,  int? selectedImageIndex)  $default,) {final _that = this;
switch (_that) {
case _KioskHomeState():
return $default(_that.currentStep,_that.order,_that.metadata,_that.happyPlaceModerationEvent,_that.isSubmitting,_that.isReverting,_that.imageGenerationStartTime,_that.awaitingQuestions,_that.imagesBatch,_that.questions,_that.milkOptions,_that.sweetenerOptions,_that.shouldClearData,_that.selectedImageIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KioskWizardStep currentStep,  LatteOrder? order,  LatteOrderMetadata? metadata,  ModerationEvent? happyPlaceModerationEvent,  bool isSubmitting,  bool isReverting,  DateTime? imageGenerationStartTime,  bool awaitingQuestions,  LatteImageBatch? imagesBatch,  List<Question> questions, @LatteOptionConverter()  List<LatteOption>? milkOptions, @LatteOptionConverter()  List<LatteOption>? sweetenerOptions,  bool shouldClearData,  int? selectedImageIndex)?  $default,) {final _that = this;
switch (_that) {
case _KioskHomeState() when $default != null:
return $default(_that.currentStep,_that.order,_that.metadata,_that.happyPlaceModerationEvent,_that.isSubmitting,_that.isReverting,_that.imageGenerationStartTime,_that.awaitingQuestions,_that.imagesBatch,_that.questions,_that.milkOptions,_that.sweetenerOptions,_that.shouldClearData,_that.selectedImageIndex);case _:
  return null;

}
}

}

/// @nodoc


class _KioskHomeState extends KioskHomeState {
  const _KioskHomeState({required this.currentStep, this.order, this.metadata, this.happyPlaceModerationEvent, this.isSubmitting = false, this.isReverting = false, this.imageGenerationStartTime, this.awaitingQuestions = false, this.imagesBatch, final  List<Question> questions = const [], @LatteOptionConverter() final  List<LatteOption>? milkOptions, @LatteOptionConverter() final  List<LatteOption>? sweetenerOptions, this.shouldClearData = false, this.selectedImageIndex}): _questions = questions,_milkOptions = milkOptions,_sweetenerOptions = sweetenerOptions,super._();
  

@override final  KioskWizardStep currentStep;
@override final  LatteOrder? order;
@override final  LatteOrderMetadata? metadata;
@override final  ModerationEvent? happyPlaceModerationEvent;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isReverting;
/// When the user submits a happy place, or a tweak,
/// the clock starts ticking on image generation.
/// We want to track this time. If for nothing else, it helps us show
/// a progress bar that doesn't depend on widget states being mounted
/// throughout the image generation without gaps.
@override final  DateTime? imageGenerationStartTime;
/// When an image's questions are requested before they exist, we store the
/// need here so that we add them to the state once they arrive.
@override@JsonKey() final  bool awaitingQuestions;
/// The current batch of 4 images to choose from. This is deduced by the
/// [LatteOrderMetadata]'s `latteBatchId` field.
@override final  LatteImageBatch? imagesBatch;
/// Copy of the active [LatteImage]'s questions, only set once the user
/// chooses an image and clicks the "tweak image" button. This copy is used
/// instead of the questions in the [LatteImage] to isolate the user's
/// answers from changes to the [LatteImageBatch]. The critical detail is
/// that answers are not persisted to Firebase, which means anything that
/// overwrites the [LatteImageBatch] would clobber the user's answers.
 final  List<Question> _questions;
/// Copy of the active [LatteImage]'s questions, only set once the user
/// chooses an image and clicks the "tweak image" button. This copy is used
/// instead of the questions in the [LatteImage] to isolate the user's
/// answers from changes to the [LatteImageBatch]. The critical detail is
/// that answers are not persisted to Firebase, which means anything that
/// overwrites the [LatteImageBatch] would clobber the user's answers.
@override@JsonKey() List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

/// Values loaded straight from Firebase.
 final  List<LatteOption>? _milkOptions;
/// Values loaded straight from Firebase.
@override@LatteOptionConverter() List<LatteOption>? get milkOptions {
  final value = _milkOptions;
  if (value == null) return null;
  if (_milkOptions is EqualUnmodifiableListView) return _milkOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Values loaded straight from Firebase.
 final  List<LatteOption>? _sweetenerOptions;
/// Values loaded straight from Firebase.
@override@LatteOptionConverter() List<LatteOption>? get sweetenerOptions {
  final value = _sweetenerOptions;
  if (value == null) return null;
  if (_sweetenerOptions is EqualUnmodifiableListView) return _sweetenerOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// True if the user is starting over and we want to eject data upon
/// returning to the .intro screen.
@override@JsonKey() final  bool shouldClearData;
@override final  int? selectedImageIndex;

/// Create a copy of KioskHomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KioskHomeStateCopyWith<_KioskHomeState> get copyWith => __$KioskHomeStateCopyWithImpl<_KioskHomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KioskHomeState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.order, order) || other.order == order)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.happyPlaceModerationEvent, happyPlaceModerationEvent) || other.happyPlaceModerationEvent == happyPlaceModerationEvent)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isReverting, isReverting) || other.isReverting == isReverting)&&(identical(other.imageGenerationStartTime, imageGenerationStartTime) || other.imageGenerationStartTime == imageGenerationStartTime)&&(identical(other.awaitingQuestions, awaitingQuestions) || other.awaitingQuestions == awaitingQuestions)&&(identical(other.imagesBatch, imagesBatch) || other.imagesBatch == imagesBatch)&&const DeepCollectionEquality().equals(other._questions, _questions)&&const DeepCollectionEquality().equals(other._milkOptions, _milkOptions)&&const DeepCollectionEquality().equals(other._sweetenerOptions, _sweetenerOptions)&&(identical(other.shouldClearData, shouldClearData) || other.shouldClearData == shouldClearData)&&(identical(other.selectedImageIndex, selectedImageIndex) || other.selectedImageIndex == selectedImageIndex));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,order,metadata,happyPlaceModerationEvent,isSubmitting,isReverting,imageGenerationStartTime,awaitingQuestions,imagesBatch,const DeepCollectionEquality().hash(_questions),const DeepCollectionEquality().hash(_milkOptions),const DeepCollectionEquality().hash(_sweetenerOptions),shouldClearData,selectedImageIndex);

@override
String toString() {
  return 'KioskHomeState(currentStep: $currentStep, order: $order, metadata: $metadata, happyPlaceModerationEvent: $happyPlaceModerationEvent, isSubmitting: $isSubmitting, isReverting: $isReverting, imageGenerationStartTime: $imageGenerationStartTime, awaitingQuestions: $awaitingQuestions, imagesBatch: $imagesBatch, questions: $questions, milkOptions: $milkOptions, sweetenerOptions: $sweetenerOptions, shouldClearData: $shouldClearData, selectedImageIndex: $selectedImageIndex)';
}


}

/// @nodoc
abstract mixin class _$KioskHomeStateCopyWith<$Res> implements $KioskHomeStateCopyWith<$Res> {
  factory _$KioskHomeStateCopyWith(_KioskHomeState value, $Res Function(_KioskHomeState) _then) = __$KioskHomeStateCopyWithImpl;
@override @useResult
$Res call({
 KioskWizardStep currentStep, LatteOrder? order, LatteOrderMetadata? metadata, ModerationEvent? happyPlaceModerationEvent, bool isSubmitting, bool isReverting, DateTime? imageGenerationStartTime, bool awaitingQuestions, LatteImageBatch? imagesBatch, List<Question> questions,@LatteOptionConverter() List<LatteOption>? milkOptions,@LatteOptionConverter() List<LatteOption>? sweetenerOptions, bool shouldClearData, int? selectedImageIndex
});


@override $LatteOrderCopyWith<$Res>? get order;@override $LatteOrderMetadataCopyWith<$Res>? get metadata;@override $LatteImageBatchCopyWith<$Res>? get imagesBatch;

}
/// @nodoc
class __$KioskHomeStateCopyWithImpl<$Res>
    implements _$KioskHomeStateCopyWith<$Res> {
  __$KioskHomeStateCopyWithImpl(this._self, this._then);

  final _KioskHomeState _self;
  final $Res Function(_KioskHomeState) _then;

/// Create a copy of KioskHomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,Object? order = freezed,Object? metadata = freezed,Object? happyPlaceModerationEvent = freezed,Object? isSubmitting = null,Object? isReverting = null,Object? imageGenerationStartTime = freezed,Object? awaitingQuestions = null,Object? imagesBatch = freezed,Object? questions = null,Object? milkOptions = freezed,Object? sweetenerOptions = freezed,Object? shouldClearData = null,Object? selectedImageIndex = freezed,}) {
  return _then(_KioskHomeState(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as KioskWizardStep,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as LatteOrder?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as LatteOrderMetadata?,happyPlaceModerationEvent: freezed == happyPlaceModerationEvent ? _self.happyPlaceModerationEvent : happyPlaceModerationEvent // ignore: cast_nullable_to_non_nullable
as ModerationEvent?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isReverting: null == isReverting ? _self.isReverting : isReverting // ignore: cast_nullable_to_non_nullable
as bool,imageGenerationStartTime: freezed == imageGenerationStartTime ? _self.imageGenerationStartTime : imageGenerationStartTime // ignore: cast_nullable_to_non_nullable
as DateTime?,awaitingQuestions: null == awaitingQuestions ? _self.awaitingQuestions : awaitingQuestions // ignore: cast_nullable_to_non_nullable
as bool,imagesBatch: freezed == imagesBatch ? _self.imagesBatch : imagesBatch // ignore: cast_nullable_to_non_nullable
as LatteImageBatch?,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,milkOptions: freezed == milkOptions ? _self._milkOptions : milkOptions // ignore: cast_nullable_to_non_nullable
as List<LatteOption>?,sweetenerOptions: freezed == sweetenerOptions ? _self._sweetenerOptions : sweetenerOptions // ignore: cast_nullable_to_non_nullable
as List<LatteOption>?,shouldClearData: null == shouldClearData ? _self.shouldClearData : shouldClearData // ignore: cast_nullable_to_non_nullable
as bool,selectedImageIndex: freezed == selectedImageIndex ? _self.selectedImageIndex : selectedImageIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of KioskHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderCopyWith<$Res>? get order {
    if (_self.order == null) {
    return null;
  }

  return $LatteOrderCopyWith<$Res>(_self.order!, (value) {
    return _then(_self.copyWith(order: value));
  });
}/// Create a copy of KioskHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteOrderMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
    return null;
  }

  return $LatteOrderMetadataCopyWith<$Res>(_self.metadata!, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}/// Create a copy of KioskHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatteImageBatchCopyWith<$Res>? get imagesBatch {
    if (_self.imagesBatch == null) {
    return null;
  }

  return $LatteImageBatchCopyWith<$Res>(_self.imagesBatch!, (value) {
    return _then(_self.copyWith(imagesBatch: value));
  });
}
}

// dart format on
