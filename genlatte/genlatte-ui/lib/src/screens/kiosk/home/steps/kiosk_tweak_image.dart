// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte/src/screens/kiosk/widgets/zip_item.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
// import 'package:web_browser_detect/web_browser_detect.dart';

/// Answer questions to tweak a selected image.
class KioskTweakImage extends StatefulWidget {
  /// Creates a new [KioskTweakImage].
  KioskTweakImage({
    required this.advance,
    required this.questions,
    required this.onAnswer,
    super.key,
  }) : assert(
         questions.isEmpty || (questions.length >= 2 && questions.length <= 4),
         'Must provide 0 or 2-4 questions',
       );

  /// Callback to advance to the next step of the wizard.
  final VoidCallback? advance;

  /// Callback when a question is answered.
  final void Function(Question, Object?) onAnswer;

  /// The questions to answer.
  final List<Question> questions;

  @override
  State<KioskTweakImage> createState() => _KioskTweakImageState();
}

class _KioskTweakImageState extends State<KioskTweakImage> {
  // static const double _minHeightForFieldView = 400;

  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late final Map<String, GlobalKey> _cardKeys;

  @override
  void initState() {
    super.initState();
    final textQuestion = widget.questions.whereType<TextQuestion>().firstOrNull;
    _textController = TextEditingController(text: textQuestion?.answer);
    _focusNode = FocusNode();
    _cardKeys = {
      for (final q in widget.questions) q.id: GlobalKey(debugLabel: q.id),
    };
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildQuestionCard(int index, Question question) {
    return KeyedSubtree(
      key: _cardKeys[question.id],
      child: ResponsiveSizedBox(
        aspectRatioClamp: (0.5, null, 3),
        child: ConfigurationCard.forQuestion(
          question,
          flavor: Flavor.forIndex(index),
          onAnswer: (answer) => widget.onAnswer(question, answer),
          textEditingController: question is TextQuestion
              ? _textController
              : null,
          focusNode: question is TextQuestion ? _focusNode : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return const Center(child: CircularProgressIndicator(size: 48));
    }

    // bool forceCarousel = false;
    // if (kIsWeb) {
    //   final browser = Browser();
    //   if (browser.browserAgent == .chrome) {
    //     forceCarousel = true;
    //   }
    // }

    return LayoutProvider.builder(
      builder: _buildCarousel,
      // info.aspectRatio < 1.6 ||
      //     info.height < _minHeightForFieldView ||
      //     forceCarousel
      // ? _buildCarousel(context, info)
      // : _buildField(context, info),
    );
  }

  Widget _buildField(BuildContext context, LayoutInformation info) {
    return Row(
      children: <Widget>[
        const Spacer(flex: 3),
        Expanded(
          flex: 9,
          child: LayoutProvider.builder(
            builder: (context, layoutInfo) {
              return Stack(
                children: switch (widget.questions.length) {
                  2 => _buildTwoQuestions(context, layoutInfo),
                  3 => _buildThreeQuestions(context, layoutInfo),
                  4 => _buildFourQuestions(context, layoutInfo),
                  _ => throw UnimplementedError(),
                },
              );
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: ZipItem(
            index: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ResponsiveChevronButton(
                onPressed: widget.advance,
                scale: 0.6,
                text: 'Next',
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTwoQuestions(
    BuildContext context,
    LayoutInformation info,
  ) {
    return <Widget>[
      Positioned(
        top: 0,
        left: 0,
        width: info.size.width * 0.46,
        height: info.size.height,
        key: ValueKey(widget.questions[0].id),
        child: ZipItem(
          index: 2,
          child: _buildQuestionCard(0, widget.questions[0]),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        width: info.size.width * 0.46,
        height: info.size.height,
        key: ValueKey(widget.questions[1].id),
        child: ZipItem(
          index: 1,
          child: _buildQuestionCard(1, widget.questions[1]),
        ),
      ),
    ];
  }

  List<Widget> _buildThreeQuestions(
    BuildContext context,
    LayoutInformation layoutInfo,
  ) {
    return <Widget>[
      Positioned(
        top: 0,
        left: 0,
        width: layoutInfo.size.width * 0.46,
        height: layoutInfo.size.height,
        key: ValueKey(widget.questions[0].id),
        child: ZipItem(
          index: 2,
          child: _buildQuestionCard(0, widget.questions[0]),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        width: layoutInfo.size.width * 0.46,
        height: layoutInfo.size.height * 0.46,
        key: ValueKey(widget.questions[1].id),
        child: ZipItem(
          index: 1,
          child: _buildQuestionCard(1, widget.questions[1]),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        width: layoutInfo.size.width * 0.46,
        height: layoutInfo.size.height * 0.46,
        key: ValueKey(widget.questions[2].id),
        child: ZipItem(
          index: 1,
          child: _buildQuestionCard(2, widget.questions[2]),
        ),
      ),
    ];
  }

  List<Widget> _buildFourQuestions(
    BuildContext context,
    LayoutInformation layoutInfo,
  ) {
    return <Widget>[
      Positioned(
        top: 0,
        left: 0,
        width: layoutInfo.size.width * 0.46,
        height: layoutInfo.size.height * 0.46,
        key: ValueKey(widget.questions[0].id),
        child: ZipItem(
          index: 2,
          child: _buildQuestionCard(0, widget.questions[0]),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        width: layoutInfo.size.width * 0.46,
        height: layoutInfo.size.height * 0.46,
        key: ValueKey(widget.questions[1].id),
        child: ZipItem(
          index: 2,
          child: _buildQuestionCard(1, widget.questions[1]),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        width: layoutInfo.size.width * 0.46,
        height: layoutInfo.size.height * 0.46,
        key: ValueKey(widget.questions[2].id),
        child: ZipItem(
          index: 1,
          child: _buildQuestionCard(2, widget.questions[2]),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        width: layoutInfo.size.width * 0.46,
        height: layoutInfo.size.height * 0.46,
        key: ValueKey(widget.questions[3].id),
        child: ZipItem(
          index: 1,
          child: _buildQuestionCard(3, widget.questions[3]),
        ),
      ),
    ];
  }

  Widget _buildCarousel(BuildContext context, LayoutInformation info) {
    int? activeIndex;
    if (_focusNode.hasFocus) {
      final textQuestionIndex = widget.questions.indexWhere(
        (q) => q is TextQuestion,
      );
      if (textQuestionIndex != -1) {
        activeIndex = textQuestionIndex;
      }
    }

    return Column(
      children: [
        const Spacer(),
        Expanded(
          flex: 9,
          child: SneakPeakCarousel(
            activeIndex: activeIndex,
            children: widget.questions.indexed
                .map(
                  (q) => ZipItem(
                    index: q.$1,
                    child: _buildQuestionCard(q.$1, q.$2),
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          flex: 3,
          child: ZipItem(
            index: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ResponsiveChevronButton(
                onPressed: widget.advance,
                text: 'Next',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
