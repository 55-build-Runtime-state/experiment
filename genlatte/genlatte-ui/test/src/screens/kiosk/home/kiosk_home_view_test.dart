// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genlatte/src/screens/kiosk/home/kiosk_home_bloc.dart';
import 'package:genlatte/src/screens/kiosk/home/kiosk_home_view.dart';
import 'package:genlatte/src/screens/kiosk/home/steps/steps.dart';
import 'package:genlatte_data/models.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MockKioskHomeBloc extends MockBloc<KioskHomeEvent, KioskHomeState>
    implements KioskHomeBloc {}

void main() {
  late MockKioskHomeBloc mockBloc;

  setUp(() {
    mockBloc = MockKioskHomeBloc();
    when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildSubject({
    required Size size,
    required KioskHomeBloc bloc,
  }) {
    return ShadcnApp(
      title: 'GenLatte',
      home: Scaffold(
        child: MediaQuery(
          data: MediaQueryData(size: size),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return KioskHomeScreen(bloc: bloc);
            },
          ),
        ),
      ),
    );
  }

  group('KioskHomeScreen layout tests', () {
    const landscapeSize = Size(1920, 1080);
    const portraitSize = Size(1080, 1920);

    for (final size in [landscapeSize, portraitSize]) {
      final isLandscape = size.width > size.height;
      final orientationName = isLandscape ? 'Landscape' : 'Portrait';

      group('in $orientationName', () {
        testWidgets('renders KioskIntro when on .intro step', (tester) async {
          when(() => mockBloc.state).thenReturn(
            KioskHomeState.initial().copyWith(
              currentStep: KioskWizardStep.intro,
            ),
          );

          await tester.pumpWidget(
            buildSubject(size: size, bloc: mockBloc),
          );
          await tester.pumpAndSettle();

          expect(find.byKey(const ValueKey('step-intro')), findsOneWidget);
        });

        testWidgets('renders KioskDrinkOrderName when on .name step', (
          tester,
        ) async {
          when(() => mockBloc.state).thenReturn(
            KioskHomeState.initial().copyWith(
              currentStep: KioskWizardStep.name,
              order: const LatteOrder(id: '1', name: 'Test User'),
            ),
          );

          await tester.pumpWidget(
            buildSubject(size: size, bloc: mockBloc),
          );
          await tester.pumpAndSettle();

          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is KioskDrinkOrderName && widget.name == 'Test User',
            ),
            findsOneWidget,
          );
        });

        testWidgets(
          'renders KioskDrinkMilkSweetener when on .milkAndSweetener step',
          (tester) async {
            when(() => mockBloc.state).thenReturn(
              KioskHomeState.initial().copyWith(
                currentStep: KioskWizardStep.milkAndSweetener,
                order: const LatteOrder(id: '1', name: 'Test User'),
                milkOptions: [
                  const LatteOption(name: 'Oat'),
                  const LatteOption(name: 'Almond'),
                ],
                sweetenerOptions: [
                  const LatteOption(name: 'Vanilla'),
                  const LatteOption(name: 'None'),
                ],
              ),
            );

            await tester.pumpWidget(
              buildSubject(size: size, bloc: mockBloc),
            );
            await tester.pumpAndSettle();

            expect(
              find.byWidgetPredicate(
                (widget) =>
                    widget is KioskDrinkMilkSweetener &&
                    widget.username == 'Test User',
              ),
              findsOneWidget,
            );
          },
        );

        testWidgets('renders KioskHappyPlace when on .happyPlace step', (
          tester,
        ) async {
          when(() => mockBloc.state).thenReturn(
            KioskHomeState.initial().copyWith(
              currentStep: KioskWizardStep.happyPlace,
              order: const LatteOrder(
                id: '1',
                name: 'Test User',
                happyPlace: 'Mountain top',
              ),
            ),
          );

          await tester.pumpWidget(
            buildSubject(size: size, bloc: mockBloc),
          );
          await tester.pumpAndSettle();

          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is KioskHappyPlace &&
                  widget.happyPlace == 'Mountain top',
            ),
            findsOneWidget,
          );
        });

        testWidgets('renders KioskChooseAnImage when on .chooseAnImage step', (
          tester,
        ) async {
          await mockNetworkImagesFor(() async {
            const mockImagesBatch = LatteImageBatch(
              id: 'batch1',
              orderId: '1',
              image0: LatteImage(
                imageUrl: 'img0',
                prompt: 'opt1',
                questions: [],
                description: 'd1',
              ),
              image1: LatteImage(
                imageUrl: 'img1',
                prompt: 'opt2',
                questions: [],
                description: 'd2',
              ),
              image2: LatteImage(
                imageUrl: 'img2',
                prompt: 'opt3',
                questions: [],
                description: 'd3',
              ),
              image3: LatteImage(
                imageUrl: 'img3',
                prompt: 'opt4',
                questions: [],
                description: 'd4',
              ),
            );

            when(() => mockBloc.state).thenReturn(
              KioskHomeState.initial().copyWith(
                currentStep: KioskWizardStep.chooseAnImage,
                imagesBatch: mockImagesBatch,
                selectedImageIndex: 0,
              ),
            );

            await tester.pumpWidget(
              buildSubject(size: size, bloc: mockBloc),
            );
            await tester.pumpAndSettle();

            expect(
              find.byWidgetPredicate(
                (widget) =>
                    widget is KioskChooseAnImage &&
                    widget.imagesBatch?.id == 'batch1',
              ),
              findsOneWidget,
            );
          });
        });

        testWidgets('renders KioskTweakImage when on .tweakImage step', (
          tester,
        ) async {
          when(() => mockBloc.state).thenReturn(
            KioskHomeState.initial().copyWith(
              currentStep: KioskWizardStep.tweakImage,
              selectedImageIndex: 0,
              questions: const [
                TextQuestion(id: 'q1', body: 'Which color?'),
                TextQuestion(id: 'q2', body: 'Which style?'),
              ],
            ),
          );

          await tester.pumpWidget(
            buildSubject(size: size, bloc: mockBloc),
          );
          await tester.pumpAndSettle();

          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is KioskTweakImage && widget.questions.length == 2,
            ),
            findsOneWidget,
          );
        });

        testWidgets('renders KioskSubmitOrder when on .submitOrder step', (
          tester,
        ) async {
          when(() => mockBloc.state).thenReturn(
            KioskHomeState.initial().copyWith(
              currentStep: KioskWizardStep.submitOrder,
              order: const LatteOrder(
                id: '1',
                name: 'Test User',
                sweetener: 'Sugar',
                milk: 'Whole',
              ),
              metadata: const LatteOrderMetadata(
                id: '1',
                imageUrl: 'path/to/image',
              ),
            ),
          );

          await mockNetworkImagesFor(() async {
            await tester.pumpWidget(
              buildSubject(size: size, bloc: mockBloc),
            );
            await tester.pumpAndSettle();
          });

          expect(
            find.byWidgetPredicate(
              (widget) => widget is KioskSubmitOrder && widget.order.id == '1',
            ),
            findsOneWidget,
          );
        });

        testWidgets('renders KioskConfirmation when on .confirmation step', (
          tester,
        ) async {
          when(() => mockBloc.state).thenReturn(
            KioskHomeState.initial().copyWith(
              currentStep: KioskWizardStep.confirmation,
              metadata: const LatteOrderMetadata(id: '1', orderNumber: 1234),
            ),
          );

          await tester.pumpWidget(
            buildSubject(size: size, bloc: mockBloc),
          );
          await tester.pumpAndSettle();

          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is KioskConfirmation && widget.orderNumber == 1234,
            ),
            findsOneWidget,
          );
        });
      });
    }
  });
}
