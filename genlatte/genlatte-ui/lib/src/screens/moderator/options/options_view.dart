// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genlatte/src/core/core.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/moderator/options/options.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template OptionsScreen}
/// Initial Options screen.
/// {@endtemplate}
class OptionsScreen extends StatefulWidget {
  /// {@macro OptionsScreen}
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  final OptionsBloc bloc = OptionsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsBloc, OptionsState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          headers: [
            AppBar(
              backgroundColor: AppColors.almostBlack,
              leading: [
                IconButton.ghost(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.white,
                  ),
                  onPressed: () => GetIt.I<AppRouter>().router.pop(),
                ),
              ],
              title: Center(
                child: const Text(
                  'Options',
                  style: TextStyle(color: AppColors.white),
                ).h3,
              ),
            ),
          ],
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (state.options.isEmpty) {
                return const Center(
                  child: Text(
                    'No options available.',
                    style: TextStyle(color: AppColors.white),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: state.options.length,
                itemBuilder: (context, index) {
                  final group = state.options[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.1,
                      vertical: 8,
                    ),
                    child: Card(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(group.id.capitalize()).h4,
                              IconButton.ghost(
                                icon: const Icon(Icons.add_rounded),
                                onPressed: () => _showCreateOptionDialog(
                                  context,
                                  group,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (group.values.isEmpty)
                            const Text('No options in this group.'),
                          for (final option in group.values)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(option.name),
                                  ),
                                  Switch(
                                    value: option.isAvailable,
                                    onChanged: (val) => bloc.add(
                                      ToggleOptionStatus(group, option),
                                    ),
                                  ),
                                  IconButton.ghost(
                                    icon: const Icon(
                                      Icons.delete_rounded,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _confirmDelete(
                                      context,
                                      group,
                                      option,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showCreateOptionDialog(BuildContext context, LatteOptions group) {
    final nameController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (context) {
        return Theme(
          data: formsTheme,
          child: StatefulBuilder(
            builder: (context, setState) {
              final size = MediaQuery.sizeOf(context);
              return SizedBox(
                width: min(640, size.width * 0.8),
                child: AlertDialog(
                  title: Text('Add Option to ${group.id}'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Option Name',
                        style: TextStyle(color: AppColors.almostBlack),
                      ).bold,
                      const SizedBox(height: 8),
                      TextField(
                        controller: nameController,
                        placeholder: const Text('Option Name'),
                      ),
                    ],
                  ),
                  actions: [
                    SecondaryButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    PrimaryButton(
                      onPressed: () {
                        final text = nameController.text.trim();
                        if (text.isNotEmpty) {
                          bloc.add(CreateOption(group, text));
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Create'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ).ignore();
  }

  void _confirmDelete(
    BuildContext context,
    LatteOptions group,
    LatteOption option,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        final size = MediaQuery.sizeOf(context);
        return SizedBox(
          width: min(640, size.width * 0.8),
          child: AlertDialog(
            title: const Text('Confirm Deletion'),
            content: Text(
              'Are you sure you want to completely remove the option '
              '"${option.name}" from ${group.id}?',
              style: const TextStyle(
                color: AppColors.almostBlack,
                fontSize: 16,
              ),
            ),
            actions: [
              SecondaryButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              DestructiveButton(
                onPressed: () {
                  bloc.add(DeleteOption(group, option));
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
    ).ignore();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await bloc.close();
  }
}

extension on String {
  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
