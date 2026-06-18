// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/kiosk/home/kiosk_home.dart';
import 'package:genlatte/src/screens/kiosk/home/steps/steps.dart';
import 'package:genlatte/src/screens/kiosk/widgets/widgets.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template KioskHomeScreen}
/// Initial Kiosk home screen.
/// {@endtemplate}
class KioskHomeScreen extends StatefulWidget {
  /// {@macro KioskHomeScreen}
  const KioskHomeScreen({
    super.key,
    this.bloc,
  });

  /// Optional bloc, primarily used for testing.
  final KioskHomeBloc? bloc;

  @override
  State<KioskHomeScreen> createState() => _KioskHomeScreenState();
}

class _KioskHomeScreenState extends State<KioskHomeScreen> {
  late final KioskHomeBloc bloc = widget.bloc ?? KioskHomeBloc();

  final _shownHappyPlaceModerationIds = <String>{};

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, info) {
        return BlocListener<KioskHomeBloc, KioskHomeState>(
          bloc: bloc,
          listener: (context, state) async {
            if (state.happyPlaceModerationEvent != null) {
              // Short-circuit if we've already seen this moderation event.
              if (_shownHappyPlaceModerationIds.contains(
                state.happyPlaceModerationEvent!.id,
              )) {
                return;
              }

              _shownHappyPlaceModerationIds.add(
                state.happyPlaceModerationEvent!.id,
              );
              bloc.add(const HappyPlaceModerationReasonShown());
              final message = state.happyPlaceModerationEvent!.reason
                  .capitalize();
              showToast(
                context: context,
                builder: (BuildContext context, ToastOverlay overlay) {
                  return SurfaceCard(
                    child: Basic(
                      title: const Text(
                        'Happy Place rejected',
                        style: TextStyle(color: AppColors.googleIntroRed),
                      ).large,
                      subtitle: Text(
                        message,
                        style: const TextStyle(color: AppColors.black),
                      ).base,
                      trailing: OutlineButton(
                        // size: ButtonSize.small,
                        onPressed: overlay.close,
                        child: const Text(
                          'OK',
                          style: TextStyle(color: AppColors.googleIntroRed),
                        ),
                      ),
                      trailingAlignment: Alignment.bottomCenter,
                    ),
                  );
                },
                location: ToastLocation.bottomCenter,
                showDuration: const Duration(seconds: 10),
                // onClosed: () {},
              );
            }
          },
          child: BlocBuilder<KioskHomeBloc, KioskHomeState>(
            bloc: bloc,
            builder: (context, state) {
              return SafeArea(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: GenLatteScaffold(
                        headers: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeOut,
                            child:
                                // TODO(filiph): Use a less drastic measure
                                //               to reclaim vertical space
                                //               when keyboard is shown
                                (MediaQuery.viewInsetsOf(context).bottom == 0)
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      top: 48,
                                      left: 12,
                                      right: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: .spaceBetween,
                                      children: <Widget>[
                                        const Spacer(),
                                        Column(
                                          children: <Widget>[
                                            TripleTapDetector(
                                              semanticLabel: 'GenLatte',
                                              semanticHint:
                                                  'Triple tap to reset '
                                                  'the GenLatte '
                                                  'ordering process',
                                              onPressed: () async {
                                                bloc.add(const StartOver());
                                                await GetIt.I
                                                    .get<FirebaseAnalytics>()
                                                    .logEvent(
                                                      name: 'kiosk_start_over',
                                                    );
                                              },
                                              child: const Text('GenLatte').h4,
                                            ),
                                            if (!state
                                                .currentStep
                                                .isFirstStep) ...[
                                              const SizedBox(height: 8),
                                              SegmentedProgress(
                                                currentStep: state
                                                    .currentStep
                                                    .progressIndicatorIndex,
                                                totalSteps: 4,
                                              ),
                                            ],
                                            if (state
                                                .currentStep
                                                .isFirstStep) ...[
                                              // 20 + 8, for the above sized box
                                              // and the above active height
                                              // of 20
                                              const SizedBox(height: 28),
                                            ],
                                          ],
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                        footers: [
                          if (MediaQuery.viewInsetsOf(context).bottom == 0)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 48),
                              child: TripleTapDetector(
                                semanticLabel: 'Footer',
                                semanticHint: 'Triple tap to log out',
                                onPressed: () =>
                                    GetIt.I<FirebaseAuth>().signOut(),
                                child: Footer(
                                  uiScale: max(1, info.width / 1080),
                                ),
                              ),
                            ),
                        ],
                        child: Padding(
                          padding: info.orientation.isPortrait
                              ? EdgeInsets.zero
                              : EdgeInsets.symmetric(
                                  horizontal: (info.width * 0.05).clamp(
                                    12,
                                    24,
                                  ),
                                ),
                          child: Center(
                            child: ZipPageView(
                              currentIndex: state.currentStep.stepIndex,
                              builder: (context, index) {
                                return buildStep(context, state, info, index);
                              },
                              itemCount: KioskWizardStep.values.length,
                              onNewPage: (int newPageIndex) {
                                bloc.add(
                                  KioskHomeEvent.onNewPage(
                                    KioskWizardStep.fromIndex(newPageIndex),
                                  ),
                                );
                              },
                              key: const ValueKey('zip-page-view'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!state.currentStep.isFirstStep &&
                        !state.currentStep.isLastStep)
                      Positioned(
                        left: 32,
                        top: 32,
                        child: GenLatteFilledButton(
                          onPressed: () async {
                            bloc.add(const KioskHomeEvent.goBack());
                            await GetIt.I.get<FirebaseAnalytics>().logEvent(
                              name: 'kiosk_go_back',
                              parameters: {'from': state.currentStep.name},
                            );
                          },
                          label: info.orientation.isPortrait ? null : 'Back',
                          icon: Icons.arrow_back,
                        ),
                      ),
                    if (state.currentStep != .submitOrder &&
                        state.currentStep != .confirmation &&
                        state.metadata?.imageUrl != null)
                      Positioned(
                        right: 32,
                        top: 32,
                        child: GenLatteFilledButton(
                          onPressed: () => bloc.add(
                            const KioskHomeEvent.goToStep(.submitOrder),
                          ),
                          label: info.orientation.isPortrait ? null : 'Submit',
                          trailingIcon: Icons.arrow_forward,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildStep(
    BuildContext context,
    KioskHomeState state,
    LayoutInformation info,
    int pageIndex,
  ) {
    final child = switch (KioskWizardStep.fromIndex(pageIndex)) {
      .intro => KioskIntro(
        key: const ValueKey('step-intro'),
        advance: () {
          bloc.add(const KioskHomeEvent.goToStep(.name));
        },
      ),
      .name => KioskDrinkOrderName(
        key: const Key('step-name'),
        advance: !state.isSubmitting
            ? (String name) async {
                bloc.add(SubmitUserName(name));
                await GetIt.I.get<FirebaseAnalytics>().logEvent(
                  name: 'kiosk_submit_name',
                );
              }
            : null,
        name: state.order?.name,
      ),
      .milkAndSweetener => KioskDrinkMilkSweetener(
        key: const Key('step-milk-sweetener'),
        advance:
            !state.isSubmitting &&
                state.order?.milk != null &&
                state.order?.sweetener != null
            ? () async {
                bloc.add(const SubmitMilkAndSweetener());
                await GetIt.I.get<FirebaseAnalytics>().logEvent(
                  name: 'kiosk_submit_milk_sweetener',
                  parameters: {
                    'milk': state.order?.milk ?? 'missing-milk-wtf',
                    'sweetener':
                        state.order?.sweetener ?? 'missing-sweetener-wtf',
                  },
                );
              }
            : null,
        milkOptions: state.milkOptions,
        selectedMilk: state.order?.milk,
        selectedSweetener: state.order?.sweetener,
        selectMilk: (milk) => bloc.add(SelectMilk(milk)),
        selectSweetener: (sweetener) => bloc.add(SelectSweetener(sweetener)),
        sweetenerOptions: state.sweetenerOptions,
        username: state.order!.name!,
      ),
      .happyPlace => KioskHappyPlace(
        key: const Key('step-happy-place'),
        happyPlace: state.order!.happyPlace,
        submitHappyPlace: !state.isSubmitting
            ? (String happyPlace) async {
                bloc.add(SubmitHappyPlace(happyPlace));
                await GetIt.I.get<FirebaseAnalytics>().logEvent(
                  name: 'kiosk_submit_happy_place',
                );
              }
            : null,
      ),
      .chooseAnImage => KioskChooseAnImage(
        key: const Key('step-choose-image'),
        imageGenerationStartTime: state.imageGenerationStartTime,
        advanceToAcceptOrder: () async {
          bloc.add(const AcceptImage());
          await GetIt.I.get<FirebaseAnalytics>().logEvent(
            name: 'kiosk_accept_image',
          );
        },
        advanceToTweakImage: () async {
          bloc.add(const KioskHomeEvent.goToStep(.tweakImage));
          await GetIt.I.get<FirebaseAnalytics>().logEvent(
            name: 'kiosk_tweak_image',
          );
        },
        isSubmitting: state.isSubmitting,
        imagesBatch: state.imagesBatch,
        selectedIndex: state.selectedImageIndex,
        onSelectImage: (int index) async {
          bloc.add(KioskHomeEvent.selectImage(index));
          await GetIt.I.get<FirebaseAnalytics>().logEvent(
            name: 'kiosk_select_image',
          );
        },
      ),
      .tweakImage => KioskTweakImage(
        key: const Key('step-tweak-image'),
        advance:
            !state.isSubmitting && state.questions.every((q) => q.isAnswered)
            ? () async {
                bloc.add(const KioskHomeEvent.generateRevisedImages());
                await GetIt.I.get<FirebaseAnalytics>().logEvent(
                  name: 'kiosk_generate_revised_images',
                );
              }
            : null,
        questions: state.questions.take(4).toList(),
        onAnswer: (Question question, Object? answer) {
          bloc.add(AnswerQuestion(question, answer));
        },
      ),
      .chooseATweakedImage => KioskChooseAnImage(
        key: const Key('step-choose-tweaked'),
        imageGenerationStartTime: state.imageGenerationStartTime,
        advanceToAcceptOrder: () async {
          bloc.add(const AcceptImage());
          await GetIt.I.get<FirebaseAnalytics>().logEvent(
            name: 'kiosk_accept_tweaked_image',
          );
        },
        advanceToTweakImage: null,
        imagesBatch: state.imagesBatch,
        isSubmitting: state.isSubmitting,
        selectedIndex: state.selectedImageIndex,
        onSelectImage: (int index) async {
          bloc.add(KioskHomeEvent.selectImage(index));
          await GetIt.I.get<FirebaseAnalytics>().logEvent(
            name: 'kiosk_select_image',
          );
        },
      ),
      .submitOrder => KioskSubmitOrder(
        key: const Key('step-submit-order'),
        advance: !state.isSubmitting
            ? () async {
                bloc.add(const SubmitOrder());
                await GetIt.I.get<FirebaseAnalytics>().logEvent(
                  name: 'kiosk_submit_order',
                );
              }
            : null,
        metadata: state.metadata!,
        order: state.order!,
        returnToLatteConfig: () async {
          bloc.add(const KioskHomeEvent.goToStep(.milkAndSweetener));
          await GetIt.I.get<FirebaseAnalytics>().logEvent(
            name: 'kiosk_return_to_latte_config',
          );
        },
      ),
      .confirmation => KioskConfirmation(
        key: const Key('step-confirmation'),
        onNewOrder: () => bloc.add(const StartOver()),
        orderNumber: state.metadata!.orderNumber!,
      ),
    };

    final Widget? header = switch (KioskWizardStep.fromIndex(pageIndex)) {
      .intro ||
      .name ||
      .milkAndSweetener ||
      .happyPlace ||
      .tweakImage ||
      .submitOrder ||
      .confirmation => null,
      .chooseAnImage => const KioskChooseAnImageHeader(),
      .chooseATweakedImage =>
        state.imagesBatch != null
            ? KioskChooseATweakedImageHeader(
                isReverting: state.isReverting,
                onRevert: !state.isSubmitting
                    ? () async {
                        bloc.add(const RejectImageBatch());
                        await GetIt.I.get<FirebaseAnalytics>().logEvent(
                          name: 'kiosk_reject_image_batch',
                        );
                      }
                    : null,
              )
            : null,
    };
    return KioskStep(
      header: header,
      child: child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close().ignore();
  }
}

extension on String {
  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
