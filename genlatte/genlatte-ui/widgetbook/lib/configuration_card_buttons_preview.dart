// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:genlatte_data/models.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:genlatte/src/widgets/configuration_card.dart';
import 'package:widgetbook/widgetbook.dart';

@widgetbook.UseCase(name: 'Buttons', type: ConfigurationCard)
Widget buildButtonsConfigurationCardUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: context.knobs.double.slider(
        label: 'Width',
        initialValue: 600,
        min: 150,
        max: 2048,
      ),
      height: context.knobs.double.slider(
        label: 'Height',
        initialValue: 600,
        min: 12,
        max: 1536,
      ),
      child: Center(
        child: ConfigurationCard.buttons(
          flavor: context.knobs.object.segmented<Flavor>(
            label: 'Flavor',
            initialOption: .wood,
            labelBuilder: (Flavor flavor) => flavor.name,
            options: Flavor.values,
          ),
          onSelected: (String value) {},
          question: MultipleChoiceQuestion(
            id: 'abc',
            body: context.knobs.string(
              label: 'Question',
              initialValue: 'What time of day is it?',
            ),
            acceptableAnswers: ['Morning', 'Afternoon', 'Evening', 'Night'],
            selectedValue: 'Morning',
          ),
        ),
      ),
    ),
  );
}
