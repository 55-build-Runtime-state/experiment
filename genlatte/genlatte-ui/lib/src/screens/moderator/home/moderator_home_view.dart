// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genlatte/src/core/core.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/barista/widgets/widgets.dart';
import 'package:genlatte/src/screens/moderator/home/moderator_home.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template ModeratorHomeScreen}
/// Initial ModeratorHome screen.
/// {@endtemplate}
class ModeratorHomeScreen extends StatefulWidget {
  /// {@macro ModeratorHomeScreen}
  const ModeratorHomeScreen({super.key});

  @override
  State<ModeratorHomeScreen> createState() => _ModeratorHomeScreenState();
}

class _ModeratorHomeScreenState extends State<ModeratorHomeScreen> {
  final ModeratorHomeBloc bloc = ModeratorHomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeratorHomeBloc, ModeratorHomeState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          headers: [
            AppBar(
              backgroundColor: AppColors.almostBlack,
              leading: [
                IconButton.ghost(
                  icon: const Icon(Icons.print_rounded, color: AppColors.white),
                  onPressed: () => GetIt.I<AppRouter>().toMachines(),
                ),
                IconButton.ghost(
                  icon: const Icon(Icons.edit_rounded, color: AppColors.white),
                  onPressed: () => GetIt.I<AppRouter>().toOptions(),
                ),
              ],
              title: TripleTapDetector(
                semanticLabel: 'Header',
                semanticHint: 'Triple tap to log out',
                onPressed: () => GetIt.I<FirebaseAuth>().signOut(),
                child: Center(
                  child: const Text(
                    'Moderator Queue',
                    style: TextStyle(color: AppColors.white),
                  ).h3,
                ),
              ),
            ),
          ],
          child: InternalOrderQueues.moderator(
            baristas: state.baristas,
            orders: state.moderationQueue,
            onApproveAll: (orderId) async {
              bloc.add(ApproveNameAndImage(orderId));
              await GetIt.I.get<FirebaseAnalytics>().logEvent(
                name: 'moderator_approve_all',
              );
            },
            onRejectName: (orderId) async {
              bloc.add(RejectNameApproveImage(orderId));
              await GetIt.I.get<FirebaseAnalytics>().logEvent(
                name: 'moderator_reject_name',
              );
            },
            onRejectImage: (orderId) async {
              bloc.add(ApproveNameRejectImage(orderId));
              await GetIt.I.get<FirebaseAnalytics>().logEvent(
                name: 'moderator_reject_image',
              );
            },
            onRejectBoth: (orderId) async {
              bloc.add(RejectNameAndImage(orderId));
              await GetIt.I.get<FirebaseAnalytics>().logEvent(
                name: 'moderator_reject_both',
              );
            },
            onCompletePressed: (orderId) async {
              bloc.add(CompleteOrder(orderId));
              await GetIt.I.get<FirebaseAnalytics>().logEvent(
                name: 'moderator_complete_order',
              );
            },
          ),
        );
      },
    );
  }

  @override
  Future<void> dispose() async {
    await bloc.close();
    super.dispose();
  }
}
