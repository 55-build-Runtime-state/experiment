// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genlatte/src/core/core.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/moderator/machines/machines.dart';
import 'package:genlatte/src/screens/moderator/machines/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template MachinesScreen}
/// Initial Machines screen.
/// {@endtemplate}
class MachinesScreen extends StatefulWidget {
  /// {@macro MachinesScreen}
  const MachinesScreen({super.key});

  @override
  State<MachinesScreen> createState() => _MachinesScreenState();
}

class _MachinesScreenState extends State<MachinesScreen> {
  final MachinesBloc bloc = MachinesBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MachinesBloc, MachinesState>(
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
                  'Machines',
                  style: TextStyle(color: AppColors.white),
                ).h3,
              ),
              trailing: [
                IconButton.ghost(
                  icon: const Icon(Icons.add_rounded, color: AppColors.white),
                  onPressed: () => _showCreateMachineDialog(context),
                ),
              ],
            ),
          ],
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (state.machines.isEmpty) {
                return const Center(
                  child: Text(
                    'No machines available.',
                    style: TextStyle(color: AppColors.white),
                  ),
                );
              }

              if (constraints.maxWidth > 800) {
                return GridView.builder(
                  padding: const EdgeInsets.all(24),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    mainAxisExtent: 170,
                  ),
                  itemCount: state.machines.length,
                  itemBuilder: (context, index) {
                    final machine = state.machines[index];
                    return MachineCard(
                      machine: machine,
                      toggleStatus: () =>
                          bloc.add(ToggleMachineStatus(machine)),
                      onDelete: () => _confirmDelete(context, machine),
                    );
                  },
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.machines.length,
                itemBuilder: (context, index) {
                  final machine = state.machines[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MachineCard(
                      machine: machine,
                      toggleStatus: () =>
                          bloc.add(ToggleMachineStatus(machine)),
                      onDelete: () => _confirmDelete(context, machine),
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

  void _showCreateMachineDialog(BuildContext context) {
    final nameController = TextEditingController();
    final idController = TextEditingController();
    bool isBlackAndWhite = true;

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
                  title: const Text('Add New Machine'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Machine Id',
                        style: TextStyle(color: AppColors.almostBlack),
                      ).bold,
                      const SizedBox(height: 8),
                      TextField(
                        controller: idController,
                        placeholder: const Text('Machine Id'),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Machine Name',
                        style: TextStyle(color: AppColors.almostBlack),
                      ).bold,
                      const SizedBox(height: 8),
                      TextField(
                        controller: nameController,
                        placeholder: const Text('Machine Name'),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Black and White Only',
                            style: TextStyle(color: AppColors.almostBlack),
                          ).bold,
                          Switch(
                            value: isBlackAndWhite,
                            onChanged: (val) =>
                                setState(() => isBlackAndWhite = val),
                          ),
                        ],
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
                        final id = idController.text.trim();
                        if (text.isNotEmpty) {
                          bloc.add(
                            CreateMachine(
                              Machine(
                                id: id,
                                name: text,
                                isBlackAndWhite: isBlackAndWhite,
                              ),
                            ),
                          );
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

  void _confirmDelete(BuildContext context, Machine machine) {
    showDialog<void>(
      context: context,
      builder: (context) {
        final size = MediaQuery.sizeOf(context);
        return SizedBox(
          width: min(640, size.width * 0.8),
          child: AlertDialog(
            title: const Text('Confirm Deletion'),
            content: Text(
              'Are you sure you want to completely remove the machine '
              '"${machine.name}"?\n\nIf you live to regret this decision, '
              'you will have to recreate the machine from scratch.',
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
                  bloc.add(DeleteMachine(machine.id));
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
