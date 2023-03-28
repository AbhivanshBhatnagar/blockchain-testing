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
import 'package:portfolio/portfolio.dart' as _i5;

import '../presentation/auth/restore_existing_account_screen.dart' as _i3;
import '../presentation/auth/seed_recovery_screen.dart' as _i2;
import '../presentation/main/main_router.dart' as _i4;
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
    OnboardingRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.OnboardingScreen(),
      );
    },
    SeedRecoveryRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SeedRecoveryScreen(),
      );
    },
    RestoreExistingAccountRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RestoreExistingAccountScreen(),
      );
    },
    MainRouter.name: (routeData) {
      final args = routeData.argsAs<MainRouterArgs>(
          orElse: () => const MainRouterArgs());
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.MainPageHostScreen(key: args.key),
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
    PortfolioRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.PortfolioScreen(),
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
              PortfolioRoute.name,
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
/// [_i1.OnboardingScreen]
class OnboardingRoute extends _i6.PageRouteInfo<void> {
  const OnboardingRoute()
      : super(
          OnboardingRoute.name,
          path: '/confirmEmail',
        );

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [_i2.SeedRecoveryScreen]
class SeedRecoveryRoute extends _i6.PageRouteInfo<void> {
  const SeedRecoveryRoute()
      : super(
          SeedRecoveryRoute.name,
          path: '/seedRecovery',
        );

  static const String name = 'SeedRecoveryRoute';
}

/// generated route for
/// [_i3.RestoreExistingAccountScreen]
class RestoreExistingAccountRoute extends _i6.PageRouteInfo<void> {
  const RestoreExistingAccountRoute()
      : super(
          RestoreExistingAccountRoute.name,
          path: '/restoreExistingAccount',
        );

  static const String name = 'RestoreExistingAccountRoute';
}

/// generated route for
/// [_i4.MainPageHostScreen]
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
/// [_i5.PortfolioScreen]
class PortfolioRoute extends _i6.PageRouteInfo<void> {
  const PortfolioRoute()
      : super(
          PortfolioRoute.name,
          path: 'notification',
        );

  static const String name = 'PortfolioRoute';
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
