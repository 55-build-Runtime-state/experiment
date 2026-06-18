// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genlatte/src/core/core.dart';
import 'package:genlatte/src/screens/app/theme.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template AppView}
/// Root widget for the application.
/// {@endtemplate}
class AppView extends StatelessWidget {
  /// {@macro AppView}
  const AppView({
    required this.authBloc,
    required this.appRouter,
    super.key,
  });

  /// {@macro AuthBloc}
  final AuthBloc authBloc;

  /// {@macro AppRouter}
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppRouter>.value(value: appRouter),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authBloc),
        ],
        child: _AppView(appRouter: appRouter),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView({required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ShadcnApp.router(
      debugShowCheckedModeBanner: false,
      title: 'GenLatte',
      theme: getThemeForOrientation(context),
      routerConfig: appRouter.router,
    );
  }
}
