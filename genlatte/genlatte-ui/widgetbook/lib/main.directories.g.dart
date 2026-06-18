// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _widgetbook;
import 'package:widgetbook_workspace/chevon_button_preview.dart'
    as _widgetbook_workspace_chevon_button_preview;
import 'package:widgetbook_workspace/configuration_card_buttons_preview.dart'
    as _widgetbook_workspace_configuration_card_buttons_preview;
import 'package:widgetbook_workspace/configuration_card_slider_preview.dart'
    as _widgetbook_workspace_configuration_card_slider_preview;
import 'package:widgetbook_workspace/configuration_card_text_preview.dart'
    as _widgetbook_workspace_configuration_card_text_preview;
import 'package:widgetbook_workspace/footer_preview.dart'
    as _widgetbook_workspace_footer_preview;
import 'package:widgetbook_workspace/genlatte_filled_button_preview.dart'
    as _widgetbook_workspace_genlatte_filled_button_preview;
import 'package:widgetbook_workspace/genlatte_outlined_button_preview.dart'
    as _widgetbook_workspace_genlatte_outlined_button_preview;
import 'package:widgetbook_workspace/latte_image_preview.dart'
    as _widgetbook_workspace_latte_image_preview;
import 'package:widgetbook_workspace/latte_order_card_preview.dart'
    as _widgetbook_workspace_latte_order_card_preview;
import 'package:widgetbook_workspace/loading_dash_preview.dart'
    as _widgetbook_workspace_loading_dash_preview;
import 'package:widgetbook_workspace/outlined_chevron_button_preview.dart'
    as _widgetbook_workspace_outlined_chevron_button_preview;
import 'package:widgetbook_workspace/responsive_chevron_button_preview.dart'
    as _widgetbook_workspace_responsive_chevron_button_preview;
import 'package:widgetbook_workspace/segmented_progress_preview.dart'
    as _widgetbook_workspace_segmented_progress_preview;
import 'package:widgetbook_workspace/squish_widget_preview.dart'
    as _widgetbook_workspace_squish_widget_preview;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'screens',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'barista',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'widgets',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'LatteOrderCard',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Latte Order Card',
                    builder: _widgetbook_workspace_latte_order_card_preview
                        .buildLatteOrderCardUseCase,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'kiosk',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'widgets',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'SegmentedProgress',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder: _widgetbook_workspace_segmented_progress_preview
                        .buildSegmentedProgressUseCase,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'recent_orders',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'widgets',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'SquishedWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Icon & Text',
                    builder: _widgetbook_workspace_squish_widget_preview
                        .squishWidgetPreviewUseCase,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'widgets',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'ChevronButton',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Flat',
            builder: _widgetbook_workspace_chevon_button_preview
                .buildFlatChevronButtonUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Outlined',
            builder: _widgetbook_workspace_outlined_chevron_button_preview
                .buildChevronButtonUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Responsive',
            builder: _widgetbook_workspace_responsive_chevron_button_preview
                .buildChevronButtonUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Vertical',
            builder: _widgetbook_workspace_chevon_button_preview
                .buildVerticalChevronButtonUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'ConfigurationCard',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Buttons',
            builder: _widgetbook_workspace_configuration_card_buttons_preview
                .buildButtonsConfigurationCardUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Slider',
            builder: _widgetbook_workspace_configuration_card_slider_preview
                .buildSliderConfigurationCardUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Text',
            builder: _widgetbook_workspace_configuration_card_text_preview
                .buildTextConfigurationCardUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'Footer',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Footer',
            builder: _widgetbook_workspace_footer_preview.buildFooterUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'GenLatteFilledButton',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Icon & Text',
            builder: _widgetbook_workspace_genlatte_filled_button_preview
                .buildGenLatteFilledButtonDarkUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Icon Only',
            builder: _widgetbook_workspace_genlatte_filled_button_preview
                .buildGenLatteFilledButtonIconOnlyUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'GenLatteOutlinedButton',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Dark',
            builder: _widgetbook_workspace_genlatte_outlined_button_preview
                .buildGenLatteOutlinedButtonDarkUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Light',
            builder: _widgetbook_workspace_genlatte_outlined_button_preview
                .buildGenLatteOutlinedButtonLightUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'LatteImageWidget',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Latte Image',
            builder: _widgetbook_workspace_latte_image_preview
                .buildLatteImageUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'LoadingDash',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Loading Dash',
            builder: _widgetbook_workspace_loading_dash_preview
                .buildLoadingDashUseCase,
          ),
        ],
      ),
    ],
  ),
];
