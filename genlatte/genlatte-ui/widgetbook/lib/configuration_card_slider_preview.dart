// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:genlatte_data/models.dart' show ZeroToOneQuestion;
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:genlatte/src/widgets/configuration_card.dart';
import 'package:widgetbook/widgetbook.dart';

@widgetbook.UseCase(name: 'Slider', type: ConfigurationCard)
Widget buildSliderConfigurationCardUseCase(BuildContext context) {
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
        child: ConfigurationCard.slider(
          flavor: context.knobs.object.segmented<Flavor>(
            label: 'Flavor',
            initialOption: .wood,
            labelBuilder: (Flavor flavor) => flavor.name,
            options: Flavor.values,
          ),
          onSelected: (double value) {},
          question: ZeroToOneQuestion(
            id: 'abc',
            body: context.knobs.string(
              label: 'Question',
              initialValue: 'What time of day is it?',
            ),
            minValueLabel: context.knobs.string(
              label: 'Min Value Label',
              initialValue: 'Morning',
            ),
            maxValueLabel: context.knobs.string(
              label: 'Max Value Label',
              initialValue: 'Evening',
            ),
          ),
        ),
      ),
    ),
  );
}
