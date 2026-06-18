// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/login/login.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template LoginScreen}
/// Initial Login screen.
/// {@endtemplate}
class LoginScreen extends StatelessWidget {
  /// {@macro LoginScreen}
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      headers: [
        AppBar(
          title: const Text('Login').h3,
          height: 50,
        ),
      ],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: const Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .stretch,
              children: <Widget>[
                _LoginForm(key: ValueKey('login_form')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final TextFieldKey _emailKey = const TextFieldKey('email');
  final TextFieldKey _passwordKey = const TextFieldKey('password');

  late final LoginBloc bloc;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    bloc = LoginBloc(GetIt.I<FirebaseAuth>());
  }

  @override
  void dispose() {
    bloc.close().ignore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final rows = [
      FormField(
        key: _emailKey,
        label: const Text('Email').h3,
        validator: const EmailValidator(),
        child: const TextField(
          autocorrect: false,
          style: TextStyle(fontSize: 24),
        ),
      ),
      FormField(
        key: _passwordKey,
        label: const Text('Password').h3,
        validator: const LengthValidator(min: 8),
        child: TextField(
          autocorrect: false,
          obscureText: _obscurePassword,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    ];

    return Theme(
      data: themeData.copyWith(
        colorScheme: () => themeData.colorScheme.copyWith(
          border: () => AppColors.almostBlack,
        ),
      ),
      child: ResponsiveSizedBox.builder(
        aspectRatioClamp: (0.5, null, 2),
        builder: (context, size) {
          // True for narrower windows where we need to make better use
          // of vertical space.
          final labelsStacked = size.width < 800;
          return Padding(
            padding: labelsStacked
                ? EdgeInsets.zero
                : EdgeInsets.all(size.width * 0.05),
            child: SizedBox(
              width: labelsStacked ? max(480, size.width * 0.6) : size.width,
              child: BlocBuilder<LoginBloc, LoginState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    onSubmit: (context, values) async {
                      final email = _emailKey[values];
                      final password = _passwordKey[values];
                      bloc.add(
                        LoginEvent.login(
                          email: email!,
                          password: password!,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: labelsStacked ? .max : .min,
                      crossAxisAlignment: labelsStacked
                          ? CrossAxisAlignment.stretch
                          : CrossAxisAlignment.end,
                      children: [
                        if (labelsStacked)
                          Column(
                            crossAxisAlignment: .stretch,
                            children: rows,
                          )
                        else
                          FormTableLayout(rows: rows),
                        const Gap(12),
                        Row(
                          children: <Widget>[
                            const Spacer(),
                            IconButton.ghost(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ],
                        ),
                        const Gap(24),
                        if (state.errorMessage != null) ...[
                          Text(
                            state.errorMessage!,
                            style: const TextStyle(
                              color: AppColors.googleIntroRed,
                            ),
                          ).h4,
                          const Gap(24),
                        ],
                        FormErrorBuilder(
                          builder: (context, errors, child) {
                            if (state.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            // Disable the submit button while there are
                            // validation errors.
                            return PrimaryButton(
                              onPressed: errors.isEmpty
                                  ? () => context.submitForm()
                                  : null,
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 24),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
