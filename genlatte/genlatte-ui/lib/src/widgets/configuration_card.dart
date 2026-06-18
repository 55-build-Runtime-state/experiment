// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:genlatte/src/screens/app/theme.dart' show AppColors;
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Button;
import 'package:text_responsive/text_responsive.dart';

/// Cosmetic theme for the card; determines the background color.
enum Flavor {
  /// Beige, woody color.
  wood,

  /// Light blue-green color.
  seaFoam,

  /// I don't even know. I just work here.
  weirdGreen;

  /// Background color of the card of this flavor.
  Color get backgroundColor => switch (this) {
    .wood => const Color(0xFFC9B787),
    .seaFoam => const Color(0xFFB7EBE1),
    .weirdGreen => const Color(0xFFD1DF90),
  };

  /// Loops through the flavors forever and ever and ever.
  static Flavor forIndex(int index) {
    return values[index % values.length];
  }
}

/// Overall shape of the card.
enum CardShape {
  /// 160 / 255
  flat,

  /// 335 / 255
  tall,

  /// Uses all available space
  expanded;

  /// Height of this type of card under normal conditions. Smaller constraints
  /// may end up changing this in practice if the widget is wrapped in a
  /// [ResponsiveSizedBox] that provides smaller constraints.
  double? get height => switch (this) {
    .flat => 160,
    .tall => 335,
    .expanded => 400,
  };

  /// Width of this type of card under normal conditions. Smaller constraints
  /// may end up changing this in practice if the widget is wrapped in a
  /// [ResponsiveSizedBox] that provides smaller constraints.
  double? get width => switch (this) {
    .flat => 255,
    .tall => 255,
    .expanded => 745,
  };

  /// Aspect ratio of this card under normal conditions.
  double get aspectRatio => width! / height!;

  /// Width and height packaged into a [Size] object.
  Size get size => Size(width!, height!);
}

/// A card that presents a latte art configuration question to the user, like,
/// "How crowded is this party?" or "What time of day is it?"
///
/// If a [CardShape] is provided, then the resulting [ConfigurationCard] will
/// have an exact and predictable size. If no [CardShape] is provided, then the
/// [ConfigurationCard] will expand to fill all available space.
///
/// The [ConfigurationCard] widget does not play well with unlimited constraints
/// and must be nestled within something that provides limited height and width.
///
/// [T] is the type of the value returned by [onSelected].
class ConfigurationCard<T> extends StatelessWidget {
  /// Creates a new [ConfigurationCard].
  const ConfigurationCard._({
    required this.flavor,
    required this.onSelected,
    required this.question,
    this.textEditingController,
    this.focusNode,
    super.key,
  });

  /// Only provided when the question is a [TextQuestion] to maintain focus if
  /// the appearance of an on-screen keyboard causes the screen to dramatically
  /// alter its layout.
  final TextEditingController? textEditingController;

  /// Only provided when the question is a [TextQuestion] to maintain focus if
  /// the appearance of an on-screen keyboard causes the screen to dramatically
  /// alter its layout.
  final FocusNode? focusNode;

  ///
  // ignore: strict_raw_type
  static ConfigurationCard forQuestion(
    Question question, {
    required void Function(Object?) onAnswer,
    Flavor flavor = Flavor.wood,
    TextEditingController? textEditingController,
    FocusNode? focusNode,
  }) {
    switch (question) {
      case MultipleChoiceQuestion():
        return ConfigurationCard.buttons(
          flavor: flavor,
          onSelected: onAnswer,
          question: question,
        );
      case ZeroToOneQuestion():
        return ConfigurationCard.slider(
          flavor: flavor,
          onSelected: onAnswer,
          question: question,
        );
      case NegativeOneToOneQuestion():
        return ConfigurationCard.valueShiftSlider(
          flavor: flavor,
          onSelected: onAnswer,
          question: question,
        );
      case TextQuestion():
        return ConfigurationCard.text(
          flavor: flavor,
          onSelected: onAnswer,
          question: question,
          textEditingController: textEditingController,
          focusNode: focusNode,
        );
    }
  }

  /// Radio buttons-style controls.
  static ConfigurationCard<String> buttons({
    required Flavor flavor,
    required void Function(String) onSelected,
    required MultipleChoiceQuestion question,
  }) {
    return ConfigurationCard._(
      flavor: flavor,
      onSelected: onSelected,
      question: question,
    );
  }

  /// Slider-style controls.
  static ConfigurationCard<double> slider({
    required Flavor flavor,
    required void Function(double) onSelected,
    required ZeroToOneQuestion question,
  }) {
    return ConfigurationCard._(
      flavor: flavor,
      onSelected: onSelected,
      question: question,
    );
  }

  /// Slider-style controls with "no change" in the middle.
  static ConfigurationCard<double> valueShiftSlider({
    required Flavor flavor,
    required void Function(double) onSelected,
    required NegativeOneToOneQuestion question,
  }) {
    return ConfigurationCard._(
      flavor: flavor,
      onSelected: onSelected,
      question: question,
    );
  }

  /// Text-style controls.
  static ConfigurationCard<String> text({
    required Flavor flavor,
    required void Function(String) onSelected,
    required TextQuestion question,
    TextEditingController? textEditingController,
    FocusNode? focusNode,
  }) {
    return ConfigurationCard._(
      flavor: flavor,
      onSelected: onSelected,
      question: question,
      textEditingController: textEditingController,
      focusNode: focusNode,
    );
  }

  /// Determines the background color.
  final Flavor flavor;

  /// Complete definition of the question which will help configure this coffee.
  final Question question;

  /// Method by which surrounding code learns of user activity.
  final void Function(T) onSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, info) {
        final edgeInsets = max(
          info.constrainingDimension * 0.1,
          // Must be an explicit double
          // ignore: prefer_int_literals
          16.0,
        ).clamp(8.0, 100.0);

        final availableWidth = info.width - (edgeInsets * 2);
        final availableHeight = info.height - (edgeInsets * 2);

        // Save 10% padding between
        final availableHeightForQuestionOrAnswer = availableHeight * 0.45;

        final double maxFontSize = info.constrainingDimension * 0.15;
        final double minFontSize = max(10, info.constrainingDimension * 0.03);

        final h1Style = Theme.of(context).typography.h1;
        final textScaler =
            MediaQuery.maybeTextScalerOf(context) ?? TextScaler.noScaling;

        (bool, int) questionFits(double fontSize) {
          final tp = TextPainter(
            text: TextSpan(
              text: question.body,
              style: h1Style.copyWith(fontSize: fontSize),
            ),
            textDirection: Directionality.of(context),
            textScaler: textScaler,
          )..layout(maxWidth: availableWidth);
          final lineMetrics = tp.computeLineMetrics();
          final fits = tp.height <= availableHeightForQuestionOrAnswer;
          tp.dispose();
          return (fits, lineMetrics.length);
        }

        int? maxLinesForQuestion;

        double bestFontSize = minFontSize;
        final (fits, maxLines) = questionFits(maxFontSize);
        if (fits) {
          bestFontSize = maxFontSize;
          maxLinesForQuestion = maxLines;
        } else {
          double low = minFontSize;
          double high = maxFontSize;
          while (high - low > 0.5) {
            final mid = (low + high) / 2;
            final (innerFits, innerMaxLines) = questionFits(mid);
            if (innerFits) {
              bestFontSize = mid;
              maxLinesForQuestion = innerMaxLines;
              low = mid;
            } else {
              high = mid;
            }
          }
        }

        final content = Container(
          decoration: BoxDecoration(
            color: flavor.backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(edgeInsets),
            child: Stack(
              children: [
                Positioned(
                  height: availableHeightForQuestionOrAnswer,
                  width: availableWidth,
                  top: 0,
                  left: 0,
                  child: ParagraphTextWidget(
                    question.body,
                    style: h1Style.copyWith(fontSize: bestFontSize),
                    maxLines: maxLinesForQuestion,
                  ),
                ),
                Positioned(
                  height: availableHeightForQuestionOrAnswer,
                  width: availableWidth,
                  bottom: 0,
                  left: 0,
                  child: Align(
                    alignment: .bottomLeft,
                    child: switch (question) {
                      MultipleChoiceQuestion(
                        :final acceptableAnswers,
                        :final selectedValue,
                      ) =>
                        _ConfigurationRadioButtons(
                          availableSize: Size(
                            availableWidth,
                            availableHeightForQuestionOrAnswer,
                          ),
                          flavor: flavor,
                          options: acceptableAnswers,
                          onSelected: onSelected as void Function(String),
                          selectedOption: selectedValue,
                        ),
                      ZeroToOneQuestion(
                        :final minValueLabel,
                        :final maxValueLabel,
                        :final selectedValue,
                      ) =>
                        _ConfigurationSlider(
                          minValueLabel: minValueLabel,
                          maxValueLabel: maxValueLabel,
                          selectedValue: selectedValue,
                          onSelected: onSelected as void Function(double),
                          sliderType: .absoluteValue,
                        ),
                      NegativeOneToOneQuestion(
                        :final minValueLabel,
                        :final maxValueLabel,
                        :final selectedValue,
                      ) =>
                        _ConfigurationSlider(
                          minValueLabel: minValueLabel,
                          maxValueLabel: maxValueLabel,
                          selectedValue: selectedValue,
                          onSelected: onSelected as void Function(double),
                          sliderType: .valueShift,
                        ),
                      TextQuestion(
                        :final answer,
                        :final helpText,
                      ) =>
                        _ConfigurationTextInput(
                          helpText: helpText,
                          onSelected: onSelected as void Function(String),
                          selectedValue: answer,
                          controller: textEditingController,
                          focusNode: focusNode,
                        ),
                    },
                  ),
                ),
              ],
            ),
          ),
        );
        return SizedBox.fromSize(size: info.size, child: content);
      },
    );
  }
}

class _ConfigurationRadioButtons extends StatelessWidget {
  const _ConfigurationRadioButtons({
    required this.availableSize,
    required this.options,
    required this.onSelected,
    required this.selectedOption,
    required this.flavor,
  });

  final Size availableSize;
  final List<String>? options;

  final void Function(String) onSelected;

  final String? selectedOption;

  final Flavor flavor;

  static const double rowSpacing = 8;
  static const double columnSpacing = 8;

  @override
  Widget build(BuildContext context) {
    if (options == null || options!.isEmpty) {
      return const SizedBox.shrink();
    }

    final isTight = availableSize.height < 112;

    return DynamicButtonLayout(
      availableSize: availableSize,
      options: options!,
      isTight: isTight,
      rowSpacing: rowSpacing,
      columnSpacing: columnSpacing,
      builder: (context, uiScale) {
        return Wrap(
          runSpacing: rowSpacing * uiScale,
          spacing: columnSpacing * uiScale,
          children:
              options! //
                  .map<Widget>(
                    (option) => GenLatteConfigurationButton(
                      onPressed: () {
                        onSelected(option);
                      },
                      label: option,
                      isSelected: option == selectedOption,
                      isTight: isTight,
                      uiScale: uiScale,
                    ),
                  )
                  .toList(),
        );
      },
    );
  }
}

/// Determines the type of slider to show.
enum _SliderType {
  /// Represents a 0-to-1 value scale.
  absoluteValue,

  /// Represents a -1-to-1 value scale, with 0 representing "no change".
  valueShift,
}

class _ConfigurationSlider extends StatelessWidget {
  const _ConfigurationSlider({
    required this.sliderType,
    required this.minValueLabel,
    required this.maxValueLabel,
    required this.selectedValue,
    required this.onSelected,
  });

  final _SliderType sliderType;

  final String minValueLabel;

  final String maxValueLabel;

  final double? selectedValue;

  final void Function(double) onSelected;

  static const double _sliderHeight = 48;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTight = constraints.maxWidth < 250;
        final minLabel = isTight
            ? minValueLabel.split(' ').first
            : minValueLabel;
        final maxLabel = isTight
            ? maxValueLabel.split(' ').first
            : maxValueLabel;

        return WrappedText(
          style: (context, theme) => switch (constraints.maxWidth) {
            < 100 => theme.typography.large,
            < 400 => theme.typography.small,
            _ => theme.typography.base,
          },
          child: Column(
            mainAxisAlignment: .end,
            children: <Widget>[
              Row(
                mainAxisAlignment: .spaceBetween,
                children: <Widget>[
                  if (sliderType == .valueShift) ...[
                    Text(minLabel),
                    if (!isTight) ...[
                      const Text('No change'),
                    ],
                    Text(maxLabel, textAlign: .end),
                  ],
                  if (sliderType == .absoluteValue) ...[
                    Text(minLabel),
                    Text(maxLabel, textAlign: .end),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: _sliderHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return _SliderTrack(
                      constraints: constraints,
                      onSelected: onSelected,
                      sliderType: sliderType,
                      startingValue: selectedValue,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SliderTrack extends StatefulWidget {
  const _SliderTrack({
    required this.constraints,
    required this.sliderType,
    required this.onSelected,
    required this.startingValue,
  });

  final BoxConstraints constraints;
  final _SliderType sliderType;
  final void Function(double) onSelected;
  final double? startingValue;

  @override
  State<_SliderTrack> createState() => _SliderTrackState();
}

class _SliderTrackState extends State<_SliderTrack> {
  /// Coordinates of the start of the user's drag. A null value here means no
  /// drag is underway.
  double? _dragStart;

  /// Coordinates of the current position of the user's drag. A null value here
  /// means no drag is underway.
  double? _dragCurrent;

  /// Computed delta to the starting knob position, stored between -1 and 1.
  double _knobPositionDelta = 0;

  /// Absolute value of knob position.
  double get _knobPositionAbsolute =>
      ((widget.constraints.maxWidth / 2) - _halfKnobWidth) * _knobPositionDelta;

  /// Absolute buffer space on either side of the track to prevent the knob from
  /// going out of bounds.
  double get _halfKnobWidth => widget.constraints.maxHeight / 2;

  /// The maximum number of pixels the center of the knob can travel in either
  /// direction.
  double get _distanceFromCenterToEdge =>
      widget.constraints.maxWidth / 2 - _halfKnobWidth;

  @override
  void initState() {
    super.initState();
    final startingValue = widget.startingValue;
    if (startingValue != null) {
      _knobPositionDelta = widget.sliderType == .absoluteValue
          ? (startingValue * 2) - 1
          : startingValue;
    }
  }

  @override
  void didUpdateWidget(covariant _SliderTrack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startingValue != oldWidget.startingValue &&
        widget.startingValue != null) {
      _knobPositionDelta = widget.sliderType == .absoluteValue
          ? (widget.startingValue! * 2) - 1
          : widget.startingValue!;
    }
  }

  void _onDragStart(DragStartDetails details) {
    _dragCurrent = details.localPosition.dx;

    if (_knobPositionDelta != 0) {
      _dragStart =
          details.localPosition.dx -
          (_knobPositionDelta * _distanceFromCenterToEdge);
    } else {
      _dragStart = details.localPosition.dx;
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragCurrent = details.localPosition.dx;

      _knobPositionDelta =
          ((_dragCurrent! - _dragStart!) / _distanceFromCenterToEdge) //
              .clamp(-1, 1);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    // _knobPositionDelta is a float between -1 and 1, which means it is already
    // in the correct range for a [.valueShift] slider; but must be normalized
    // to 0-1 for [.absoluteValue] sliders. To do this, we add 1, shifting the
    // range from 0 to 2, then divide by 2 to make it 0 to 1.
    final normalized = widget.sliderType == .absoluteValue
        ? (_knobPositionDelta + 1) / 2
        : _knobPositionDelta;
    widget.onSelected(normalized);
    setState(() {
      _dragStart = null;
      _dragCurrent = null;
    });
  }

  /// Where to place the left side of the slider such that its center aligns
  /// with the center of the track.
  double get _startingKnobPosition =>
      (widget.constraints.maxWidth / 2) - (widget.constraints.maxHeight / 2);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Grey line acting as the track for the slider
        Positioned(
          left: _halfKnobWidth,
          width: widget.constraints.maxWidth - (_halfKnobWidth * 2),
          top: widget.constraints.maxHeight * 0.5,
          height: 1,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFA2A2A2),
            ),
          ),
        ),
        // Blue knob
        Positioned(
          left: _startingKnobPosition + _knobPositionAbsolute,
          width: widget.constraints.maxHeight,
          top: 0,
          // This measurement creates a rounded corner square
          height: widget.constraints.maxHeight,
          child: GestureDetector(
            onHorizontalDragStart: _onDragStart,
            onHorizontalDragUpdate: _onDragUpdate,
            onHorizontalDragEnd: _onDragEnd,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.googleBlue,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConfigurationTextInput extends StatefulWidget {
  const _ConfigurationTextInput({
    required this.helpText,
    required this.onSelected,
    required this.selectedValue,
    this.controller,
    this.focusNode,
  });

  final String helpText;
  final void Function(String) onSelected;
  final String? selectedValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  State<_ConfigurationTextInput> createState() =>
      _ConfigurationTextInputState();
}

class _ConfigurationTextInputState extends State<_ConfigurationTextInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.selectedValue);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If the card is too short, then larger text sizes cause the input
        // to overflow.
        final double floor = constraints.maxHeight > 40 ? 0.9 : 0.5;
        final double inputScalar = max(floor, constraints.maxWidth / 500);

        final textStyle = Theme.of(context).typography.large.copyWith(
          fontSize: Theme.of(context).typography.large.fontSize! * inputScalar,
        );
        return TextField(
          decoration: BoxDecoration(
            border: const Border(), // defaults to BorderStyle.none
            borderRadius: BorderRadius.all(
              Radius.circular(8 * inputScalar),
            ),
            color: Theme.of(context).colorScheme.input,
          ),
          controller: _controller,
          focusNode: widget.focusNode,
          onChanged: widget.onSelected,
          enableInteractiveSelection: false,
          placeholder: Text(widget.helpText, style: textStyle),
          padding: EdgeInsets.symmetric(
            horizontal: 16 * inputScalar,
            vertical: 12 * inputScalar,
          ),
          style: textStyle,
        );
      },
    );
  }
}
