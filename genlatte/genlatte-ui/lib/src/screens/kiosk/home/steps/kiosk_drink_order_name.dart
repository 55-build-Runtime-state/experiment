// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:genlatte/src/screens/kiosk/widgets/zip_item.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:genlatte_data/models.dart' show TextQuestion;

/// First screen of the kiosk flow which asks for the user's name.
class KioskDrinkOrderName extends StatefulWidget {
  /// Creates a new [KioskDrinkOrderName].
  const KioskDrinkOrderName({
    required this.advance,
    required this.name,
    super.key,
  });

  /// The user's name.
  final String? name;

  /// Callback to advance to the next step of the wizard.
  final void Function(String)? advance;

  @override
  State<KioskDrinkOrderName> createState() => _KioskDrinkOrderNameState();
}

class _KioskDrinkOrderNameState extends State<KioskDrinkOrderName> {
  late String _name;

  @override
  void initState() {
    super.initState();
    _name = widget.name ?? '';
  }

  void setName(String name) {
    setState(() {
      _name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, layoutInfo) {
        final Axis axis = layoutInfo.aspectRatio < 1.6
            ? .vertical
            : .horizontal;
        return Padding(
          padding: axis == .vertical
              ? const EdgeInsets.symmetric(horizontal: 32)
              : EdgeInsets.zero,
          child: Flex(
            direction: axis,
            mainAxisAlignment: .spaceEvenly,
            children: [
              Spacer(flex: axis == .horizontal ? 3 : 1),
              Expanded(
                flex: 9,
                child: ZipItem(
                  index: 1,
                  child: ResponsiveSizedBox(
                    aspectRatioClamp: (null, 745 / 400, null),
                    maxSize: const Size(745, 400),
                    child: ConfigurationCard.text(
                      flavor: Flavor.wood,
                      onSelected: setName,
                      question: TextQuestion(
                        id: 'name',
                        body: 'Can I get a first name for your drink order?',
                        answer: _name,
                        helpText: 'Your name',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: ZipItem(
                  index: 0,
                  child: Padding(
                    padding: axis == .vertical
                        ? const EdgeInsets.only(top: 16)
                        : EdgeInsets.zero,
                    child: ResponsiveChevronButton(
                      onPressed: widget.advance != null && _name.isNotEmpty
                          ? () {
                              widget.advance!.call(_name);
                            }
                          : null,
                      scale: axis == .horizontal ? 0.6 : null,
                      text: 'Next',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
