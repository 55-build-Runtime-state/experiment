// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/barista/home/barista_home.dart';
import 'package:genlatte/src/screens/barista/widgets/widgets.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template BaristaHomeScreen}
/// Initial BaristaHome screen.
/// {@endtemplate}
class BaristaHomeScreen extends StatefulWidget {
  /// {@macro BaristaHomeScreen}
  const BaristaHomeScreen({super.key});

  @override
  State<BaristaHomeScreen> createState() => _BaristaHomeScreenState();
}

class _BaristaHomeScreenState extends State<BaristaHomeScreen> {
  final BaristaHomeBloc bloc = BaristaHomeBloc();

  final shownErrorUuids = <String>{};

  bool _hasPerformedInitialMachineCheck = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaristaHomeBloc, BaristaHomeState>(
      bloc: bloc,
      builder: (context, state) {
        final size = MediaQuery.sizeOf(context);
        return BlocListener<BaristaHomeBloc, BaristaHomeState>(
          bloc: bloc,
          listener: (context, state) {
            if (state.error != null &&
                !shownErrorUuids.contains(state.error!.uuid)) {
              shownErrorUuids.add(state.error!.uuid);
              _showErrorToast(state.error!, state.machines).ignore();
            }

            if (!_hasPerformedInitialMachineCheck &&
                state.machines.isNotEmpty &&
                state.selectedMachine == null) {
              _hasPerformedInitialMachineCheck = true;
              _showMachineSelectionToast(state.machines).ignore();
            }
          },
          child: Scaffold(
            headers: [
              if (state.currentBarista != null)
                AppBar(
                  backgroundColor: AppColors.almostBlack,
                  leading: <Widget>[
                    Avatar(
                      initials: state.currentBarista!.username.substring(0, 1),
                      provider: AssetImage(
                        state.currentBarista!.persona.assetName,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (state.selectedMachine != null)
                      GenLatteOutlinedButton.light(
                        label:
                            '${state.selectedMachine!.name} '
                            // ignore: lines_longer_than_80_chars
                            '${state.selectedMachine!.isBlackAndWhite ? '🔲' : '🎨'}',
                        onPressed: () => _showMachineSelectionToast(
                          state.machines,
                          selectedMachine: state.selectedMachine,
                        ),
                      ),
                    if (state.selectedMachine == null)
                      GenLatteOutlinedButton.red(
                        label: 'Select a Machine',
                        onPressed: () => _showMachineSelectionToast(
                          state.machines,
                        ),
                      ),
                  ],
                  title: Center(
                    child: const Text(
                      'Barista Queue',
                      style: TextStyle(color: AppColors.white),
                    ).h3,
                  ),
                  trailing: <Widget>[
                    GenLatteOutlinedButton.light(
                      label: 'End your watch',
                      onPressed: () => bloc.add(const BaristaSignOut()),
                    ),
                  ],
                ),
            ],
            child: state.currentBarista == null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.15,
                      vertical: size.height * 0.1,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 10,
                            child: BaristaPersonaCard(
                              onSubmit: (username, persona) => bloc.add(
                                BaristaSignIn(
                                  Barista(username: username, persona: persona),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GhostButton(
                              onPressed: () =>
                                  GetIt.I<FirebaseAuth>().signOut(),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.7,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : InternalOrderQueues.barista(
                    activeBarista: state.currentBarista!,
                    canClaimOrders: state.selectedMachine != null,
                    baristas: state.baristas,
                    orders: state.brewQueue,
                    onClaimPressed: (orderId) async {
                      bloc.add(ClaimOrder(orderId));
                      await GetIt.I.get<FirebaseAnalytics>().logEvent(
                        name: 'barista_claim_order',
                      );
                    },
                    onCompletePressed: (orderId) async {
                      bloc.add(CompleteOrder(orderId));
                      await GetIt.I.get<FirebaseAnalytics>().logEvent(
                        name: 'barista_complete_order',
                      );
                    },
                    onReprintPressed: (orderId) async {
                      bloc.add(ReprintOrder(orderId));
                      await GetIt.I.get<FirebaseAnalytics>().logEvent(
                        name: 'barista_reprint_order',
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Future<void> _showMachineSelectionToast(
    List<Machine> machines, {
    Machine? selectedMachine,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        final size = MediaQuery.sizeOf(context);
        return SizedBox(
          width: min(640, size.width * 0.8),
          child: AlertDialog(
            title: const Text('Select a Machine').bold,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                MachineSelection(
                  machines: machines,
                  initialSelection: selectedMachine,
                  onSubmitted: (machine) {
                    bloc.add(SelectedMachine(machine));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showErrorToast(
    MachinesError error,
    List<Machine> machines,
  ) async {
    switch (error.code) {
      case ErrorCode.machineDisconnected:
        await showDialog<void>(
          context: context,
          builder: (context) {
            final size = MediaQuery.sizeOf(context);
            return SizedBox(
              width: min(640, size.width * 0.8),
              child: AlertDialog(
                title: const Text('Machine Disconnected').bold,
                content: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Text(error.message),
                    const SizedBox(height: 16),
                    MachineSelection(
                      machines: machines,
                      onSubmitted: (machine) {
                        bloc.add(SelectedMachine(machine));
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
    }
  }

  @override
  Future<void> dispose() async {
    await bloc.close();
    super.dispose();
  }
}
