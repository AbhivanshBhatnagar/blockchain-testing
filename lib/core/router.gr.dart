// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../presentation/auth/recover_account/recover_account.dart' as _i3;
import '../presentation/auth/restore_existing_account/restore_existing_account_screen.dart'
    as _i2;
import '../presentation/auth/seed_saving/seed_saving_screen.dart' as _i4;
import '../presentation/main/main_router.dart' as _i5;
import '../presentation/presentation.dart' as _i1;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SignupScreen(),
      );
    },
    DynamicLinkProcessingRoute.name: (routeData) {
      final args = routeData.argsAs<DynamicLinkProcessingRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.DynamicLinkProcessingScreen(
          authToken: args.authToken,
          key: args.key,
        ),
      );
    },
    OnboardingRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.OnboardingScreen(
          email: args.email,
          key: args.key,
        ),
      );
    },
    SeedRecoveryRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SeedRecoveryScreen(),
      );
    },
    RestoreExistingAccountRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RestoreExistingAccountScreen(),
      );
    },
    SetupOrImportNewAccountRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SetupOrImportNewAccountScreen(),
      );
    },
    RecoverAccountRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RecoverAccountScreen(),
      );
    },
    SeedSavingRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.SeedSavingScreen(),
      );
    },
    MainRouter.name: (routeData) {
      final args = routeData.argsAs<MainRouterArgs>(
          orElse: () => const MainRouterArgs());
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.MainPageHostScreen(key: args.key),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SearchScreen(),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.NotificationScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SettingsScreen(),
      );
    },
    MessageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MessageScreen(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          SignupRoute.name,
          path: '/signup',
        ),
        _i6.RouteConfig(
          DynamicLinkProcessingRoute.name,
          path: '/dynamic_link_processing_screen',
        ),
        _i6.RouteConfig(
          OnboardingRoute.name,
          path: '/confirmEmail',
        ),
        _i6.RouteConfig(
          SeedRecoveryRoute.name,
          path: '/seedRecovery',
        ),
        _i6.RouteConfig(
          RestoreExistingAccountRoute.name,
          path: '/restoreExistingAccount',
        ),
        _i6.RouteConfig(
          SetupOrImportNewAccountRoute.name,
          path: '/setupOrImportNewAccountScreen',
        ),
        _i6.RouteConfig(
          RecoverAccountRoute.name,
          path: '/recoverAccount',
        ),
        _i6.RouteConfig(
          SeedSavingRoute.name,
          path: '/seedSaving',
        ),
        _i6.RouteConfig(
          MainRouter.name,
          path: '/main',
          children: [
            _i6.RouteConfig(
              HomeRoute.name,
              path: '',
              parent: MainRouter.name,
            ),
            _i6.RouteConfig(
              SearchRoute.name,
              path: 'search',
              parent: MainRouter.name,
            ),
            _i6.RouteConfig(
              NotificationRoute.name,
              path: 'notification',
              parent: MainRouter.name,
            ),
            _i6.RouteConfig(
              SettingsRoute.name,
              path: 'settings',
              parent: MainRouter.name,
            ),
            _i6.RouteConfig(
              MessageRoute.name,
              path: 'message',
              parent: MainRouter.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i1.SignupScreen]
class SignupRoute extends _i6.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: '/signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i1.DynamicLinkProcessingScreen]
class DynamicLinkProcessingRoute
    extends _i6.PageRouteInfo<DynamicLinkProcessingRouteArgs> {
  DynamicLinkProcessingRoute({
    required String authToken,
    _i7.Key? key,
  }) : super(
          DynamicLinkProcessingRoute.name,
          path: '/dynamic_link_processing_screen',
          args: DynamicLinkProcessingRouteArgs(
            authToken: authToken,
            key: key,
          ),
        );

  static const String name = 'DynamicLinkProcessingRoute';
}

class DynamicLinkProcessingRouteArgs {
  const DynamicLinkProcessingRouteArgs({
    required this.authToken,
    this.key,
  });

  final String authToken;

  final _i7.Key? key;

  @override
  String toString() {
    return 'DynamicLinkProcessingRouteArgs{authToken: $authToken, key: $key}';
  }
}

/// generated route for
/// [_i1.OnboardingScreen]
class OnboardingRoute extends _i6.PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({
    required String email,
    _i7.Key? key,
  }) : super(
          OnboardingRoute.name,
          path: '/confirmEmail',
          args: OnboardingRouteArgs(
            email: email,
            key: key,
          ),
        );

  static const String name = 'OnboardingRoute';
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({
    required this.email,
    this.key,
  });

  final String email;

  final _i7.Key? key;

  @override
  String toString() {
    return 'OnboardingRouteArgs{email: $email, key: $key}';
  }
}

/// generated route for
/// [_i1.SeedRecoveryScreen]
class SeedRecoveryRoute extends _i6.PageRouteInfo<void> {
  const SeedRecoveryRoute()
      : super(
          SeedRecoveryRoute.name,
          path: '/seedRecovery',
        );

  static const String name = 'SeedRecoveryRoute';
}

/// generated route for
/// [_i2.RestoreExistingAccountScreen]
class RestoreExistingAccountRoute extends _i6.PageRouteInfo<void> {
  const RestoreExistingAccountRoute()
      : super(
          RestoreExistingAccountRoute.name,
          path: '/restoreExistingAccount',
        );

  static const String name = 'RestoreExistingAccountRoute';
}

/// generated route for
/// [_i1.SetupOrImportNewAccountScreen]
class SetupOrImportNewAccountRoute extends _i6.PageRouteInfo<void> {
  const SetupOrImportNewAccountRoute()
      : super(
          SetupOrImportNewAccountRoute.name,
          path: '/setupOrImportNewAccountScreen',
        );

  static const String name = 'SetupOrImportNewAccountRoute';
}

/// generated route for
/// [_i3.RecoverAccountScreen]
class RecoverAccountRoute extends _i6.PageRouteInfo<void> {
  const RecoverAccountRoute()
      : super(
          RecoverAccountRoute.name,
          path: '/recoverAccount',
        );

  static const String name = 'RecoverAccountRoute';
}

/// generated route for
/// [_i4.SeedSavingScreen]
class SeedSavingRoute extends _i6.PageRouteInfo<void> {
  const SeedSavingRoute()
      : super(
          SeedSavingRoute.name,
          path: '/seedSaving',
        );

  static const String name = 'SeedSavingRoute';
}

/// generated route for
/// [_i5.MainPageHostScreen]
class MainRouter extends _i6.PageRouteInfo<MainRouterArgs> {
  MainRouter({
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          MainRouter.name,
          path: '/main',
          args: MainRouterArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MainRouter';
}

class MainRouterArgs {
  const MainRouterArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'MainRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.SearchScreen]
class SearchRoute extends _i6.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: 'search',
        );

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i1.NotificationScreen]
class NotificationRoute extends _i6.PageRouteInfo<void> {
  const NotificationRoute()
      : super(
          NotificationRoute.name,
          path: 'notification',
        );

  static const String name = 'NotificationRoute';
}

/// generated route for
/// [_i1.SettingsScreen]
class SettingsRoute extends _i6.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'settings',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i1.MessageScreen]
class MessageRoute extends _i6.PageRouteInfo<void> {
  const MessageRoute()
      : super(
          MessageRoute.name,
          path: 'message',
        );

  static const String name = 'MessageRoute';
}
