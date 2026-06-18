// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genlatte/src/core/auth/auth_bloc.dart';
import 'package:genlatte/src/core/routing/redirection.dart';
import 'package:genlatte/src/core/routing/router.dart';
import 'package:genlatte/src/core/routing/routes.dart';
import 'package:genlatte/src/role.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthBloc mockAuthBloc;
  late MockUser mockUser;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    mockUser = MockUser();
    when(() => mockUser.uid).thenReturn('test_uid');
  });

  group('Redirection Tests', () {
    // Helper to create AppRouter for a specific role
    AppRouter createAppRouter() {
      return AppRouter(authBloc: mockAuthBloc);
    }

    // Helper to test redirection logic using GoRouterRedirector directly
    // This part tests the core logic in isolation
    void testRedirector({
      required Role? role,
      required bool authenticated,
      required String currentPath,
      required String? expectedRedirect,
      bool ignoreQueryParameters = true,
    }) {
      final redirector = GoRouterRedirector();
      final authState = authenticated
          ? AuthState(user: mockUser, role: role)
          : const AuthState();
      final routeState = RouteState(uri: Uri.parse(currentPath));

      final result = redirector.redirect(
        routeState: routeState,
        authState: authState,
      );

      String? resultWithoutQueryParams;
      if (ignoreQueryParameters && result != null) {
        final uri = Uri.tryParse(result);
        if (uri != null) {
          resultWithoutQueryParams = Uri(
            path: uri.path,
            // Omit query parameters.
          ).toString();
        }
      }

      expect(
        resultWithoutQueryParams ?? result,
        expectedRedirect,
        reason:
            'Role $role: Authenticated=$authenticated, Current=$currentPath '
            'should redirect to $expectedRedirect',
      );
    }

    group('Barista', () {
      const role = Role.barista;

      test('Unauthenticated user at /home should redirect to /login', () {
        testRedirector(
          role: role,
          authenticated: false,
          currentPath: '/home',
          expectedRedirect: '/login',
        );
      });

      test('Unauthenticated user at /login should NOT redirect', () {
        testRedirector(
          role: role,
          authenticated: false,
          currentPath: '/login',
          expectedRedirect: null,
        );
      });

      test('Authenticated user at /login should redirect to /home', () {
        testRedirector(
          role: role,
          authenticated: true,
          currentPath: '/login',
          expectedRedirect: '/barista',
        );
      });

      test('Authenticated user at /home should NOT redirect', () {
        testRedirector(
          role: role,
          authenticated: true,
          currentPath: '/home',
          expectedRedirect: null,
        );
      });

      test('Authenticated but no role at /home should redirect to /login', () {
        testRedirector(
          role: null,
          authenticated: true,
          currentPath: '/home',
          expectedRedirect: '/login',
        );
      });
    });

    group('Kiosk', () {
      const role = Role.kiosk;

      test('Unauthenticated user at /home should redirect to /login', () {
        testRedirector(
          role: role,
          authenticated: false,
          currentPath: '/home',
          expectedRedirect: '/login',
        );
      });

      test('Unauthenticated user at /login should NOT redirect', () {
        testRedirector(
          role: role,
          authenticated: false,
          currentPath: '/login',
          expectedRedirect: null,
        );
      });

      test('Authenticated user at /login should redirect to /home', () {
        testRedirector(
          role: role,
          authenticated: true,
          currentPath: '/login',
          expectedRedirect: '/kiosk',
        );
      });

      test('Authenticated user at /home should NOT redirect', () {
        testRedirector(
          role: role,
          authenticated: true,
          currentPath: '/home',
          expectedRedirect: null,
        );
      });
    });

    group('QueueObserver', () {
      const role = Role.queueObserver;

      test('Unauthenticated user at /home should redirect to /login', () {
        testRedirector(
          role: role,
          authenticated: false,
          currentPath: '/home',
          expectedRedirect: '/login',
        );
      });

      test('Unauthenticated user at /login should NOT redirect', () {
        testRedirector(
          role: role,
          authenticated: false,
          currentPath: '/login',
          expectedRedirect: null,
        );
      });

      test('Authenticated user at /login should redirect to /home', () {
        testRedirector(
          role: role,
          authenticated: true,
          currentPath: '/login',
          expectedRedirect: '/queue',
        );
      });

      test('Authenticated user at /home should NOT redirect', () {
        testRedirector(
          role: role,
          authenticated: true,
          currentPath: '/home',
          expectedRedirect: null,
        );
      });
    });

    group('RecentOrdersObserver', () {
      const role = Role.recentOrdersObserver;

      test('Unauthenticated user at /home should redirect to /login', () {
        testRedirector(
          role: role,
          authenticated: false,
          currentPath: '/home',
          expectedRedirect: '/login',
        );
      });

      test('Unauthenticated user at /login should NOT redirect', () {
        testRedirector(
          role: role,
          authenticated: false,
          currentPath: '/login',
          expectedRedirect: null,
        );
      });

      test('Authenticated user at /login should redirect to /home', () {
        testRedirector(
          role: role,
          authenticated: true,
          currentPath: '/login',
          expectedRedirect: '/recentOrders',
        );
      });

      test('Authenticated user at /home should NOT redirect', () {
        testRedirector(
          role: role,
          authenticated: true,
          currentPath: '/home',
          expectedRedirect: null,
        );
      });
    });

    group('Moderator', () {
      const role = Role.moderator;

      test('Unauthenticated user at /home should redirect to /login', () {
        testRedirector(
          role: role,
          authenticated: false,
          currentPath: '/home',
          expectedRedirect: '/login',
        );
      });

      test('Unauthenticated user at /login should NOT redirect', () {
        testRedirector(
          role: role,
          authenticated: false,
          currentPath: '/login',
          expectedRedirect: null,
        );
      });

      test('Authenticated user at /login should redirect to /home', () {
        testRedirector(
          role: role,
          authenticated: true,
          currentPath: '/login',
          expectedRedirect: '/moderator',
        );
      });

      test('Authenticated user at /home should NOT redirect', () {
        testRedirector(
          role: role,
          authenticated: true,
          currentPath: '/home',
          expectedRedirect: null,
        );
      });
    });

    test('AppRouter listens to AuthBloc stream and redirects', () async {
      final endState = AuthState(user: mockUser, role: .barista);
      final authController = StreamController<AuthState>();

      // Start unauthenticated.
      when(() => mockAuthBloc.state).thenReturn(AuthState.initial());
      // Then authenticate.
      when(() => mockAuthBloc.stream).thenAnswer((_) => authController.stream);

      final router = createAppRouter()
        // Simulate GoRouter having completed its initial routing.
        ..lastRouteState = RouteState.fromRoute(AppRoutes.initialRoute);

      authController.add(endState);

      // Expect a redirect to /barista.
      await expectLater(router.allRedirects, emits('/barista'));
      expect(router.lastRouteState!.path, '/barista');

      await authController.close();
    });

    test(
      'AppRouter creates continue parameter when protecting route',
      () async {
        final targetUri = Uri(
          path: AppRoutes.queueRoute.path,
          queryParameters: {'total': '3'},
        );
        final authController = StreamController<AuthState>();

        // Start unauthenticated.
        when(() => mockAuthBloc.state).thenReturn(AuthState.initial());
        when(
          () => mockAuthBloc.stream,
        ).thenAnswer((_) => authController.stream);

        final router = createAppRouter()
          // Simulate the user attempting to navigate directly
          // to a protected route with query parameters.
          ..lastRouteState = RouteState(uri: targetUri);

        // Trigger the stream listener with the unauthenticated state.
        authController.add(AuthState.initial());

        final expectedUri = Uri(
          path: AppRoutes.loginRoute.path,
          queryParameters: {'continue': targetUri.toString()},
        ).toString();
        await expectLater(router.allRedirects, emits(expectedUri));

        await authController.close();
      },
    );

    test(
      'AppRouter uses continue parameter after successful login',
      () async {
        final endState = AuthState(user: mockUser, role: .queueObserver);
        final targetUri = Uri(
          path: AppRoutes.queueRoute.path,
          queryParameters: {'total': '3'},
        );
        final authController = StreamController<AuthState>();

        // Start unauthenticated.
        when(() => mockAuthBloc.state).thenReturn(AuthState.initial());
        when(
          () => mockAuthBloc.stream,
        ).thenAnswer((_) => authController.stream);

        final router = createAppRouter()
          // Simulate the user having been redirected to login.
          ..lastRouteState = RouteState(
            uri: Uri(
              path: AppRoutes.loginRoute.path,
              queryParameters: {'continue': targetUri.toString()},
            ),
          );

        // Trigger authenticated state.
        authController.add(endState);

        await expectLater(router.allRedirects, emits(targetUri.toString()));

        await authController.close();
      },
    );

    group('NonBaristaAwayFromBaristaHome', () {
      const targetPath = '/barista';

      test('Barista user at /barista should NOT redirect', () {
        testRedirector(
          role: Role.barista,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: null,
        );
      });

      test('Kiosk user at /barista should redirect to /kiosk', () {
        testRedirector(
          role: Role.kiosk,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/kiosk',
        );
      });

      test('QueueObserver user at /barista should redirect to /queue', () {
        testRedirector(
          role: Role.queueObserver,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/queue',
        );
      });

      test(
        'RecentOrdersObserver user at /barista should redirect to /recentOrders',
        () {
          testRedirector(
            role: Role.recentOrdersObserver,
            authenticated: true,
            currentPath: targetPath,
            expectedRedirect: '/recentOrders',
          );
        },
      );

      test('Anonymous user at /barista should redirect to /login', () {
        testRedirector(
          role: null,
          authenticated: false,
          currentPath: targetPath,
          expectedRedirect: '/login',
        );
      });
    });

    group('NonKioskAwayFromKioskHome', () {
      const targetPath = '/kiosk';

      test('Kiosk user at /kiosk should NOT redirect', () {
        testRedirector(
          role: Role.kiosk,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: null,
        );
      });

      test('Barista user at /kiosk should redirect to /barista', () {
        testRedirector(
          role: Role.barista,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/barista',
        );
      });

      test('QueueObserver user at /kiosk should redirect to /queue', () {
        testRedirector(
          role: Role.queueObserver,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/queue',
        );
      });

      test(
        'RecentOrdersObserver user at /kiosk should redirect to /recentOrders',
        () {
          testRedirector(
            role: Role.recentOrdersObserver,
            authenticated: true,
            currentPath: targetPath,
            expectedRedirect: '/recentOrders',
          );
        },
      );

      test('Anonymous user at /kiosk should redirect to /login', () {
        testRedirector(
          role: null,
          authenticated: false,
          currentPath: targetPath,
          expectedRedirect: '/login',
        );
      });
    });

    group('NonQueueObserverAwayFromQueue', () {
      const targetPath = '/queue';

      test('QueueObserver user at /queue should NOT redirect', () {
        testRedirector(
          role: Role.queueObserver,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: null,
        );
      });

      test('Barista user at /queue should redirect to /barista', () {
        testRedirector(
          role: Role.barista,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/barista',
        );
      });

      test('Kiosk user at /queue should redirect to /kiosk', () {
        testRedirector(
          role: Role.kiosk,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/kiosk',
        );
      });

      test(
        'RecentOrdersObserver user at /queue should redirect to /recentOrders',
        () {
          testRedirector(
            role: Role.recentOrdersObserver,
            authenticated: true,
            currentPath: targetPath,
            expectedRedirect: '/recentOrders',
          );
        },
      );

      test('Anonymous user at /queue should redirect to /login', () {
        testRedirector(
          role: null,
          authenticated: false,
          currentPath: targetPath,
          expectedRedirect: '/login',
        );
      });
    });

    group('NonRecentOrdersObserverAwayFromRecentOrders', () {
      const targetPath = '/recentOrders';

      test(
        'RecentOrdersObserver user at /recentOrders should NOT redirect',
        () {
          testRedirector(
            role: Role.recentOrdersObserver,
            authenticated: true,
            currentPath: targetPath,
            expectedRedirect: null,
          );
        },
      );

      test('Barista user at /recentOrders should redirect to /barista', () {
        testRedirector(
          role: Role.barista,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/barista',
        );
      });

      test('Kiosk user at /recentOrders should redirect to /kiosk', () {
        testRedirector(
          role: Role.kiosk,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/kiosk',
        );
      });

      test('QueueObserver user at /recentOrders should redirect to /queue', () {
        testRedirector(
          role: Role.queueObserver,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/queue',
        );
      });

      test('Anonymous user at /recentOrders should redirect to /login', () {
        testRedirector(
          role: null,
          authenticated: false,
          currentPath: targetPath,
          expectedRedirect: '/login',
        );
      });
    });

    group('NonModeratorObserverAwayFromModeration', () {
      const targetPath = '/moderator';

      test('Moderator user at /moderator should NOT redirect', () {
        testRedirector(
          role: Role.moderator,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: null,
        );
      });

      test('Barista user at /moderator should redirect to /barista', () {
        testRedirector(
          role: Role.barista,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/barista',
        );
      });

      test('Kiosk user at /moderator should redirect to /kiosk', () {
        testRedirector(
          role: Role.kiosk,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/kiosk',
        );
      });

      test('QueueObserver user at /moderator should redirect to /queue', () {
        testRedirector(
          role: Role.queueObserver,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/queue',
        );
      });

      test(
        'RecentOrdersObserver user at /moderator should redirect to /recentOrders',
        () {
          testRedirector(
            role: Role.recentOrdersObserver,
            authenticated: true,
            currentPath: targetPath,
            expectedRedirect: '/recentOrders',
          );
        },
      );

      test('Anonymous user at /moderator should redirect to /login', () {
        testRedirector(
          role: null,
          authenticated: false,
          currentPath: targetPath,
          expectedRedirect: '/login',
        );
      });
    });

    group('NonModeratorsAwayFromPrinters', () {
      const targetPath = '/machines';

      test('Moderator user at /machines should NOT redirect', () {
        testRedirector(
          role: Role.moderator,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: null,
        );
      });

      test('Barista user at /machines should redirect to /barista', () {
        testRedirector(
          role: Role.barista,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/barista',
        );
      });

      test('Kiosk user at /machines should redirect to /kiosk', () {
        testRedirector(
          role: Role.kiosk,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/kiosk',
        );
      });

      test('QueueObserver user at /machines should redirect to /queue', () {
        testRedirector(
          role: Role.queueObserver,
          authenticated: true,
          currentPath: targetPath,
          expectedRedirect: '/queue',
        );
      });

      test(
        'RecentOrdersObserver user at /machines should redirect to /recentOrders',
        () {
          testRedirector(
            role: Role.recentOrdersObserver,
            authenticated: true,
            currentPath: targetPath,
            expectedRedirect: '/recentOrders',
          );
        },
      );

      test('Anonymous user at /machines should redirect to /login', () {
        testRedirector(
          role: null,
          authenticated: false,
          currentPath: targetPath,
          expectedRedirect: '/login',
        );
      });
    });
  });
}
