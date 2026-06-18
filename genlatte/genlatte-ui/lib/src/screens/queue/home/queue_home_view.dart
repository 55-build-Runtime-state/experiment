// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:data_layer/data_layer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genlatte/src/data/data.dart';
import 'package:genlatte/src/data/shared_preferences_repository.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/queue/home/fake_repositories.dart';
import 'package:genlatte/src/screens/queue/home/queue_home.dart';
import 'package:genlatte/src/screens/queue/widgets/debug_overlay.dart';
import 'package:genlatte/src/screens/queue/widgets/order_list.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template QueueHomeScreen}
/// Initial QueueHome screen.
/// {@endtemplate}
class QueueHomeScreen extends StatefulWidget {
  /// {@macro QueueHomeScreen}
  const QueueHomeScreen({super.key});

  @override
  State<QueueHomeScreen> createState() => _QueueHomeScreenState();
}

class _QueueHomeScreenState extends State<QueueHomeScreen> {
  late QueueHomeBloc bloc;

  FakeLatteOrdersRepository? _fakeOrdersRepository;

  FakeLatteOrdersMetadataRepository? _fakeMetadataRepository;

  bool _showDebugOverlay = false;

  bool _hoverDebugOverlay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      child: Stack(
        children: [
          BlocBuilder<QueueHomeBloc, QueueHomeState>(
            bloc: bloc,
            buildWhen: (previous, current) =>
                previous.shownPages != current.shownPages ||
                previous.settings != current.settings,
            builder: (context, state) => OrderList(
              pages: state.shownPages,
              onSlotsCounted: (slots) => bloc.add(SlotsCounted(slots)),
              maxRecentAge: state.settings.maxRecentAge,
              targetRowHeight: state.settings.targetRowHeight,
              noOrdersInAnyShard: state.noOrdersInAnyShard,
              pageUpdatePeriod: state.settings.pageUpdatePeriod,
            ),
          ),
          Positioned(
            width: 100,
            height: 100,
            top: 10,
            right: 10,
            child: StatefulBuilder(
              builder: (context, innerSetState) {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) =>
                      innerSetState(() => _hoverDebugOverlay = true),
                  onExit: (_) =>
                      innerSetState(() => _hoverDebugOverlay = false),
                  child: ColoredBox(
                    color: _hoverDebugOverlay
                        ? AppColors.chevronYellow.withValues(alpha: 0.75)
                        : AppColors.transparent,
                    child: GestureDetector(
                      key: const Key('hidden_overlay_show_toggle'),
                      onTap: () => setState(
                        () => _showDebugOverlay = !_showDebugOverlay,
                      ),

                      behavior: .opaque,
                    ),
                  ),
                );
              },
            ),
          ),
          if (_showDebugOverlay)
            Positioned(
              top: 120,
              bottom: 20,
              right: 20,
              child: Align(
                alignment: .bottomEnd,
                child: Opacity(
                  opacity: 0.9,
                  child: SingleChildScrollView(
                    child: OrderBoardDebugOverlay(
                      bloc: bloc,
                      ordersRepository: _fakeOrdersRepository,
                      metadataRepository: _fakeMetadataRepository,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant QueueHomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    final previousBloc = bloc;
    bloc = _setupBloc();
    previousBloc.close().ignore();
  }

  @override
  Future<void> dispose() async {
    unawaited(bloc.close());
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc = _setupBloc();
  }

  QueueHomeBloc _setupBloc() {
    final LatteOrdersRepository ordersRepo;
    final Repository<LatteOrderMetadata> metadataRepo;
    // if (widget.useFakes) {
    //   ordersRepo = _fakeOrdersRepository = FakeLatteOrdersRepository();
    //   metadataRepo = _fakeMetadataRepository =
    //       FakeLatteOrdersMetadataRepository();
    // } else {
    ordersRepo = GetIt.I<LatteOrdersRepository>();
    metadataRepo = GetIt.I<Repository<LatteOrderMetadata>>();
    // }
    final sharedPrefsRepo = GetIt.I<SharedPreferencesRepository>();

    return QueueHomeBloc(
      ordersRepository: ordersRepo,
      metadataRepository: metadataRepo,
      sharedPrefsRepository: sharedPrefsRepo,
    );
  }
}
