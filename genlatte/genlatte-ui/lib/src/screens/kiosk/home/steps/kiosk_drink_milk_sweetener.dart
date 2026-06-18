// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:genlatte/src/screens/kiosk/widgets/zip_item.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';

/// Milk / sweetener configuration screen.
class KioskDrinkMilkSweetener extends StatefulWidget {
  /// Creates a new [KioskDrinkMilkSweetener].
  const KioskDrinkMilkSweetener({
    required this.advance,
    required this.milkOptions,
    required this.sweetenerOptions,
    required this.selectedMilk,
    required this.selectedSweetener,
    required this.selectMilk,
    required this.selectSweetener,
    required this.username,
    super.key,
  });

  /// Callback to advance to the next step of the wizard.
  final VoidCallback? advance;

  /// The available milk options.
  final List<LatteOption>? milkOptions;

  /// The available sweetener options.
  final List<LatteOption>? sweetenerOptions;

  /// The selected milk.
  final String? selectedMilk;

  /// The selected sweetener.
  final String? selectedSweetener;

  /// Callback to select milk.
  final void Function(String) selectMilk;

  /// Callback to select sweetener.
  final void Function(String) selectSweetener;

  /// The name the user entered on the previous screen.
  final String username;

  @override
  State<KioskDrinkMilkSweetener> createState() =>
      _KioskDrinkMilkSweetenerState();
}

class _KioskDrinkMilkSweetenerState extends State<KioskDrinkMilkSweetener> {
  int? _forcedIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, layoutInfo) {
        return layoutInfo.aspectRatio > 1.6
            ? _buildRow(context)
            : _buildColumn(context);
      },
    );
  }

  Widget _buildRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: CardShape.tall.height,
        child: Align(
          child: Row(
            mainAxisAlignment: .center,
            children: [
              const Spacer(flex: 3),
              Expanded(
                flex: 4,
                child: _MilkChoiceCard(
                  milkOptions: widget.milkOptions,
                  selectedMilk: widget.selectedMilk,
                  selectMilk: widget.selectMilk,
                  username: widget.username,
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 4,
                child: _SweetenerChoiceCard(
                  sweetenerOptions: widget.sweetenerOptions,
                  selectedSweetener: widget.selectedSweetener,
                  selectSweetener: widget.selectSweetener,
                ),
              ),
              Expanded(
                flex: 3,
                child: ZipItem(
                  index: 0,
                  child: ResponsiveChevronButton(
                    onPressed: widget.advance,
                    style: .vertical,
                    scale: 0.6,
                    text: 'Next',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumn(BuildContext context) => Column(
    children: [
      const Spacer(),
      Expanded(
        flex: 9,
        child: SneakPeakCarousel(
          previewPercentage: 0.2,
          activeIndex: _forcedIndex,
          onIndexChanged: (index) {
            _forcedIndex = index;
          },
          children: [
            _MilkChoiceCard(
              milkOptions: widget.milkOptions,
              selectedMilk: widget.selectedMilk,
              selectMilk: widget.selectMilk,
              username: widget.username,
            ),
            _SweetenerChoiceCard(
              sweetenerOptions: widget.sweetenerOptions,
              selectedSweetener: widget.selectedSweetener,
              selectSweetener: widget.selectSweetener,
            ),
          ],
        ),
      ),
      Expanded(
        flex: 3,
        child: ZipItem(
          index: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ResponsiveChevronButton(
              onPressed:
                  widget.selectedMilk != null &&
                      widget.selectedSweetener == null
                  ? () {
                      setState(() {
                        _forcedIndex = 1;
                      });
                    }
                  : widget.advance,
              style: .flat,
              text: 'Next',
            ),
          ),
        ),
      ),
    ],
  );
}

class _MilkChoiceCard extends StatelessWidget {
  const _MilkChoiceCard({
    required this.milkOptions,
    required this.selectedMilk,
    required this.selectMilk,
    required this.username,
  });

  final List<LatteOption>? milkOptions;
  final String? selectedMilk;
  final void Function(String) selectMilk;
  final String username;

  @override
  Widget build(BuildContext context) {
    return ZipItem(
      index: 2,
      child: ConfigurationCard.buttons(
        flavor: Flavor.wood,
        onSelected: selectMilk,
        question: MultipleChoiceQuestion(
          id: 'milk',
          body:
              'Hey $username, what kind of milk would you like in your '
              'latte?',
          acceptableAnswers:
              milkOptions?.map((option) => option.name).toList() ?? const [],
          selectedValue: selectedMilk,
        ),
      ),
    );
  }
}

class _SweetenerChoiceCard extends StatelessWidget {
  const _SweetenerChoiceCard({
    required this.sweetenerOptions,
    required this.selectedSweetener,
    required this.selectSweetener,
  });

  final List<LatteOption>? sweetenerOptions;
  final String? selectedSweetener;
  final void Function(String) selectSweetener;

  @override
  Widget build(BuildContext context) {
    return ZipItem(
      index: 1,
      child: ConfigurationCard.buttons(
        flavor: .seaFoam,
        onSelected: selectSweetener,
        question: MultipleChoiceQuestion(
          id: 'sweetener',
          body: 'What kind of sweetener would you like?',
          acceptableAnswers:
              sweetenerOptions?.map((option) => option.name).toList() ??
              const [],
          selectedValue: selectedSweetener,
        ),
      ),
    );
  }
}
