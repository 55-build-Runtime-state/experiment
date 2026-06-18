// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/queue/home/fake_repositories.dart';
import 'package:genlatte/src/screens/queue/home/queue_home.dart';
import 'package:genlatte/src/screens/queue/util/metadata_describe.dart';
import 'package:genlatte_data/models.dart';
import 'package:logging/logging.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OrderBoardDebugOverlay extends StatefulWidget {
  const OrderBoardDebugOverlay({
    required this.bloc,
    required this.ordersRepository,
    required this.metadataRepository,
    super.key,
  });

  final QueueHomeBloc bloc;

  /// The provided fake orders repository.
  final FakeLatteOrdersRepository? ordersRepository;

  /// The provided fake metadata repository.
  final FakeLatteOrdersMetadataRepository? metadataRepository;

  @override
  State<OrderBoardDebugOverlay> createState() => _OrderBoardDebugOverlayState();
}

class _CheckboxField extends StatefulWidget {
  const _CheckboxField({
    required this.formKey,
    required this.label,
    required this.initialValue,
  });

  final FormKey<bool> formKey;
  final String label;
  final bool initialValue;

  @override
  State<_CheckboxField> createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<_CheckboxField> {
  late bool _state = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        FormField<bool>(
          key: widget.formKey,
          label: Text(widget.label),
          child: Switch(
            value: _state,
            onChanged: (value) {
              setState(() {
                _state = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

class _NumberFieldWithButtons extends StatelessWidget {
  const _NumberFieldWithButtons({
    required this.formKey,
    required this.label,
    required this.controller,
    required this.step,
    required this.fallbackValue,
    this.trailingLabel,
  });

  final FormKey<String> formKey;
  final String label;
  final String? trailingLabel;
  final TextEditingController controller;
  final double step;
  final double fallbackValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        FormField<String>(
          key: formKey,
          label: Text(label),
          trailingLabel: trailingLabel != null ? Text(trailingLabel!) : null,
          child: TextField(
            controller: controller,
          ),
        ),
        Row(
          spacing: 8,
          children: [
            Button(
              onPressed: () {
                final currentString = Form.of(context).getValue(formKey);
                final current = double.tryParse(currentString ?? '');
                if (current != null) {
                  final val = current - step;
                  controller.text = val == val.toInt()
                      ? val.toInt().toString()
                      : val.toString();
                } else {
                  controller.text = fallbackValue == fallbackValue.toInt()
                      ? fallbackValue.toInt().toString()
                      : fallbackValue.toString();
                }
              },
              style: const ButtonStyle.outlineIcon(),
              child: const Text('-'),
            ),
            Button(
              onPressed: () {
                final currentString = Form.of(context).getValue(formKey);
                final current = double.tryParse(currentString ?? '');
                if (current != null) {
                  final val = current + step;
                  controller.text = val == val.toInt()
                      ? val.toInt().toString()
                      : val.toString();
                } else {
                  controller.text = fallbackValue == fallbackValue.toInt()
                      ? fallbackValue.toInt().toString()
                      : fallbackValue.toString();
                }
              },
              style: const ButtonStyle.outlineIcon(),
              child: const Text('+'),
            ),
          ],
        ),
      ],
    );
  }
}

class _OrderBoardDebugOverlayState extends State<OrderBoardDebugOverlay> {
  static final Logger _logger = Logger('$_OrderBoardDebugOverlayState');

  static int _orderIdCounter = 1;

  final _isTopScreenKey = const FormKey<bool>('is_top_screen');

  final _topOrdersCountKey = const FormKey<String>('top_orders_count');

  final _maxRecentAgeKey = const FormKey<String>('max_recent_age');

  final _maxShowAgeKey = const FormKey<String>('max_show_age');

  final _shardNumberKey = const FormKey<String>('shard_number');

  final _shardTotalKey = const FormKey<String>('shard_total');

  final _pageUpdatePeriodKey = const FormKey<String>('page_update_period');

  final _targetRowHeightKey = const FormKey<String>('target_row_height');

  late final _topOrdersCountController = TextEditingController(
    text: widget.bloc.state.settings.topOrdersCount.toString(),
  );

  late final _maxRecentAgeController = TextEditingController(
    text: widget.bloc.state.settings.maxRecentAge.asMinutesString,
  );

  late final _maxShowAgeController = TextEditingController(
    text: widget.bloc.state.settings.maxShowAge.asMinutesString,
  );

  late final _shardNumberController = TextEditingController(
    text: widget.bloc.state.settings.shardNumber.toString(),
  );

  late final _shardTotalController = TextEditingController(
    text: widget.bloc.state.settings.shardTotal.toString(),
  );

  late final _pageUpdatePeriodController = TextEditingController(
    text: widget.bloc.state.settings.pageUpdatePeriod.asSecondsString,
  );

  late final _targetRowHeightController = TextEditingController(
    text: widget.bloc.state.settings.targetRowHeight.toString(),
  );

  bool get _hasFakes =>
      widget.ordersRepository != null && widget.metadataRepository != null;

  @override
  Widget build(BuildContext context) {
    final settings = widget.bloc.state.settings;

    return ColoredBox(
      color: AppColors.chevronYellow,
      child: DefaultTextStyle(
        style: const TextStyle(color: AppColors.black),
        child: Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              const Text('SETUP'),
              Form(
                onSubmit: (context, values) {
                  final isTopScreen = _isTopScreenKey[values];
                  final topOrdersCount = int.tryParse(
                    _topOrdersCountKey[values] ?? '',
                  );

                  if (isTopScreen != null && topOrdersCount != null) {
                    widget.bloc.add(
                      SetTopSettings(
                        isTopScreen: isTopScreen,
                        topOrdersCount: topOrdersCount,
                      ),
                    );
                  } else {
                    showToast(
                      context: context,
                      builder: (context, overlay) {
                        return SurfaceCard(
                          child: Basic(
                            title: const Text('Invalid top settings'),
                            subtitle: Text(
                              'Top screen: ${_isTopScreenKey[values]}\n'
                              'Top orders count: ${_topOrdersCountKey[values]}',
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: .end,
                  spacing: 8,
                  children: [
                    Row(
                      crossAxisAlignment: .start,
                      spacing: 8,
                      children: [
                        _CheckboxField(
                          formKey: _isTopScreenKey,
                          label: 'is top',
                          initialValue: widget.bloc.state.settings.isTopScreen,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        _NumberFieldWithButtons(
                          formKey: _topOrdersCountKey,
                          label: 'top orders count',
                          controller: _topOrdersCountController,
                          step: 1,
                          fallbackValue: settings.topOrdersCount.toDouble(),
                        ),
                      ],
                    ),
                    FormErrorBuilder(
                      builder: (context, errors, child) => Button(
                        enableFeedback: true,
                        style: const ButtonStyle.outline(),
                        onPressed: errors.isEmpty
                            ? () => context.submitForm()
                            : null,
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                onSubmit: (context, values) {
                  final shardNumber = int.tryParse(
                    _shardNumberKey[values] ?? '',
                  );
                  final shardTotal = int.tryParse(_shardTotalKey[values] ?? '');

                  if (shardNumber != null && shardTotal != null) {
                    widget.bloc.add(SetShard(shardNumber, shardTotal));
                  } else {
                    showToast(
                      context: context,
                      builder: (context, overlay) {
                        return SurfaceCard(
                          child: Basic(
                            title: const Text('Invalid shard setup'),
                            subtitle: Text(
                              'Shard #: ${_shardNumberKey[values]}\n'
                              'Shard total: ${_shardTotalKey[values]}',
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: .end,
                  spacing: 8,
                  children: [
                    Row(
                      crossAxisAlignment: .start,
                      spacing: 8,
                      children: [
                        _NumberFieldWithButtons(
                          formKey: _shardNumberKey,
                          label: 'shard #',
                          controller: _shardNumberController,
                          step: 1,
                          fallbackValue: settings.shardNumber.toDouble(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: Text(' of '),
                        ),
                        _NumberFieldWithButtons(
                          formKey: _shardTotalKey,
                          label: 'shards total',
                          controller: _shardTotalController,
                          step: 1,
                          fallbackValue: settings.shardTotal.toDouble(),
                        ),
                      ],
                    ),
                    FormErrorBuilder(
                      builder: (context, errors, child) => Button(
                        enableFeedback: true,
                        style: const ButtonStyle.outline(),
                        onPressed: errors.isEmpty
                            ? () => context.submitForm()
                            : null,
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                onSubmit: (context, values) {
                  final pageUpdatePeriod = double.tryParse(
                    _pageUpdatePeriodKey[values] ?? '',
                  );

                  if (pageUpdatePeriod != null) {
                    widget.bloc.add(
                      SetPageUpdatePeriod(
                        Duration(
                          milliseconds:
                              (pageUpdatePeriod *
                                      Duration.millisecondsPerSecond)
                                  .round(),
                        ),
                      ),
                    );
                  } else {
                    showToast(
                      context: context,
                      builder: (context, overlay) {
                        return SurfaceCard(
                          child: Basic(
                            title: const Text(
                              'Invalid page update period setup',
                            ),
                            subtitle: Text(
                              'Page update period: '
                              '${_pageUpdatePeriodKey[values]}',
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: .end,
                  spacing: 8,
                  children: [
                    Row(
                      crossAxisAlignment: .start,
                      spacing: 8,
                      children: [
                        _NumberFieldWithButtons(
                          formKey: _pageUpdatePeriodKey,
                          label: 'Page update period',
                          trailingLabel: 'in seconds',
                          controller: _pageUpdatePeriodController,
                          step: 1,
                          fallbackValue: double.parse(
                            settings.pageUpdatePeriod.asSecondsString,
                          ),
                        ),
                      ],
                    ),
                    FormErrorBuilder(
                      builder: (context, errors, child) => Button(
                        enableFeedback: true,
                        style: const ButtonStyle.outline(),
                        onPressed: errors.isEmpty
                            ? () => context.submitForm()
                            : null,
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                onSubmit: (context, values) {
                  final targetRowHeight = double.tryParse(
                    _targetRowHeightKey[values] ?? '',
                  );

                  if (targetRowHeight != null) {
                    widget.bloc.add(SetTargetRowHeight(targetRowHeight));
                  } else {
                    showToast(
                      context: context,
                      builder: (context, overlay) {
                        return SurfaceCard(
                          child: Basic(
                            title: const Text('Invalid target row height'),
                            subtitle: Text(
                              'Height: ${_targetRowHeightKey[values]}',
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: .end,
                  spacing: 8,
                  children: [
                    Row(
                      crossAxisAlignment: .start,
                      children: [
                        _NumberFieldWithButtons(
                          formKey: _targetRowHeightKey,
                          label: 'Target row height',
                          trailingLabel: 'in pixels',
                          controller: _targetRowHeightController,
                          step: 10,
                          fallbackValue: settings.targetRowHeight,
                        ),
                      ],
                    ),
                    FormErrorBuilder(
                      builder: (context, errors, child) => Button(
                        enableFeedback: true,
                        style: const ButtonStyle.outline(),
                        onPressed: errors.isEmpty
                            ? () => context.submitForm()
                            : null,
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),

              Form(
                onSubmit: (context, values) {
                  final maxRecentAge = double.tryParse(
                    _maxRecentAgeKey[values] ?? '',
                  );
                  final maxShowAge = double.tryParse(
                    _maxShowAgeKey[values] ?? '',
                  );

                  if (maxRecentAge != null && maxShowAge != null) {
                    widget.bloc.add(
                      SetRecency(
                        Duration(
                          seconds: (maxRecentAge * Duration.secondsPerMinute)
                              .round(),
                        ),
                        Duration(
                          seconds: (maxShowAge * Duration.secondsPerMinute)
                              .round(),
                        ),
                      ),
                    );
                  } else {
                    showToast(
                      context: context,
                      builder: (context, overlay) {
                        return SurfaceCard(
                          child: Basic(
                            title: const Text('Invalid recency setup'),
                            subtitle: Text(
                              'Max recent age: ${_maxRecentAgeKey[values]}\n'
                              'Max show age: ${_maxShowAgeKey[values]}',
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: .end,
                  spacing: 8,
                  children: [
                    Row(
                      crossAxisAlignment: .start,
                      spacing: 8,
                      children: [
                        _NumberFieldWithButtons(
                          formKey: _maxRecentAgeKey,
                          label: 'Max recent age',
                          trailingLabel: 'in minutes',
                          controller: _maxRecentAgeController,
                          step: 1,
                          fallbackValue: double.parse(
                            settings.maxRecentAge.asMinutesString,
                          ),
                        ),
                        _NumberFieldWithButtons(
                          formKey: _maxShowAgeKey,
                          label: 'Max show age',
                          trailingLabel: 'in minutes',
                          controller: _maxShowAgeController,
                          step: 1,
                          fallbackValue: double.parse(
                            settings.maxShowAge.asMinutesString,
                          ),
                        ),
                      ],
                    ),
                    FormErrorBuilder(
                      builder: (context, errors, child) => Button(
                        enableFeedback: true,
                        style: const ButtonStyle.outline(),
                        onPressed: errors.isEmpty
                            ? () => context.submitForm()
                            : null,
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),

              const Text('DEBUG'),

              Button(
                enableFeedback: true,
                style: const ButtonStyle.outline(),
                onPressed: _hasFakes
                    ? () async {
                        _logger.fine(
                          'Add order pressed',
                        );
                        final id = _orderIdCounter++;

                        await widget.ordersRepository!.setItem(
                          LatteOrder(
                            id: '$id',
                            name: const [
                              'Alice',
                              'Bob',
                              'Clarence',
                              'Daphne',
                              'Eve',
                              'Frank',
                              'Grace',
                              'Heidi',
                              'Ivan',
                              'Judy',
                              'Karl',
                              'Leo',
                              'Mallory',
                              'Nina',
                            ][id % 14],
                            milk: 'nope',
                            sweetener: 'yes',
                            happyPlace: 'home',
                          ),
                        );
                        await widget.metadataRepository!.setItem(
                          LatteOrderMetadata(
                            id: '$id',
                            orderNumber: id,
                            isNameApproved: true,
                            isHappyPlaceApproved: true,
                            isImageApproved: true,
                            imageBatchId: 'image-batch-$id',
                            imageUrl: null,
                            status: .submitted,
                            orderSubmittedTime: DateTime.now(),
                          ),
                        );
                      }
                    : null,

                child: const Text('Add order'),
              ),
              Button(
                enableFeedback: true,
                style: const ButtonStyle.outline(),
                onPressed: _hasFakes
                    ? () async {
                        _logger.fine('Claim random order pressed');

                        final allItems =
                            (await widget.metadataRepository!.getItems())
                                .where(
                                  (o) =>
                                      o.status != .completed &&
                                      o.status != .inProgress &&
                                      o.status != .archived,
                                )
                                .toList();
                        if (allItems.isEmpty) return;

                        final random = Random();
                        final randomItem =
                            allItems[random.nextInt(allItems.length)];
                        _logger.fine(
                          'Picked: ${randomItem.describe()}',
                        );

                        final modified = randomItem.copyWith(
                          status: .inProgress,
                        );
                        _logger.fine('Modified: ${modified.describe()}');

                        await widget.metadataRepository!.setItem(modified);
                      }
                    : null,
                child: const Text('Claim random order'),
              ),
              Button(
                enableFeedback: true,
                style: const ButtonStyle.outline(),
                onPressed: _hasFakes
                    ? () async {
                        _logger.fine('Complete random order pressed');

                        final allItems =
                            (await widget.metadataRepository!.getItems())
                                .where((o) => o.status == .inProgress)
                                .toList();
                        if (allItems.isEmpty) return;

                        final random = Random();
                        final randomItem =
                            allItems[random.nextInt(allItems.length)];
                        _logger.fine(
                          'Picked: ${randomItem.describe()}',
                        );

                        final modified = randomItem.copyWith(
                          completionTime: DateTime.now(),
                          status: .completed,
                        );
                        _logger.fine('Modified: ${modified.describe()}');

                        await widget.metadataRepository!.setItem(modified);
                      }
                    : null,
                child: const Text('Complete random order'),
              ),
              Button(
                enableFeedback: true,
                style: const ButtonStyle.outline(),
                onPressed: _hasFakes
                    ? () async {
                        _logger.fine('Archive random order pressed');

                        var allItems =
                            (await widget.metadataRepository!.getItems())
                                .where((o) => o.status == .completed)
                                .toList();
                        if (allItems.isEmpty) {
                          allItems =
                              (await widget.metadataRepository!.getItems())
                                  .where((o) => o.status != .archived)
                                  .toList();
                        }
                        if (allItems.isEmpty) return;

                        final random = Random();
                        final randomItem =
                            allItems[random.nextInt(allItems.length)];
                        _logger.fine('Picked: ${randomItem.describe()}');

                        final modified = randomItem.copyWith(
                          completionTime: DateTime.now().subtract(
                            const Duration(days: 14),
                          ),
                          status: .archived,
                        );
                        _logger.fine('Modified: ${modified.describe()}');

                        await widget.metadataRepository!.setItem(modified);
                      }
                    : null,
                child: const Text('Archive random order'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _maxRecentAgeController.dispose();
    _maxShowAgeController.dispose();
    _shardNumberController.dispose();
    _shardTotalController.dispose();
    _pageUpdatePeriodController.dispose();
    _targetRowHeightController.dispose();
    super.dispose();
  }
}

extension on Duration {
  String get asMinutesString => (inSeconds / 60).toString();
  String get asSecondsString => (inMilliseconds / 1000).toString();
}
