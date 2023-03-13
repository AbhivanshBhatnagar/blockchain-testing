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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../presentation/main/main_router.dart' as _i2;
import '../presentation/presentation.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SignupScreen(),
      );
    },
    MainRouter.name: (routeData) {
      final args = routeData.argsAs<MainRouterArgs>(
          orElse: () => const MainRouterArgs());
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.MainPageHostScreen(key: args.key),
      );
    },
    HomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SearchScreen(),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.NotificationScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SettingsScreen(),
      );
    },
    MessageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MessageScreen(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          SignupRoute.name,
          path: '/signup',
        ),
        _i3.RouteConfig(
          MainRouter.name,
          path: '/main',
          children: [
            _i3.RouteConfig(
              HomeRoute.name,
              path: '',
              parent: MainRouter.name,
            ),
            _i3.RouteConfig(
              SearchRoute.name,
              path: 'search',
              parent: MainRouter.name,
            ),
            _i3.RouteConfig(
              NotificationRoute.name,
              path: 'notification',
              parent: MainRouter.name,
            ),
            _i3.RouteConfig(
              SettingsRoute.name,
              path: 'settings',
              parent: MainRouter.name,
            ),
            _i3.RouteConfig(
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
class SplashRoute extends _i3.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i1.SignupScreen]
class SignupRoute extends _i3.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: '/signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i2.MainPageHostScreen]
class MainRouter extends _i3.PageRouteInfo<MainRouterArgs> {
  MainRouter({
    _i4.Key? key,
    List<_i3.PageRouteInfo>? children,
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

  final _i4.Key? key;

  @override
  String toString() {
    return 'MainRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.SearchScreen]
class SearchRoute extends _i3.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: 'search',
        );

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i1.NotificationScreen]
class NotificationRoute extends _i3.PageRouteInfo<void> {
  const NotificationRoute()
      : super(
          NotificationRoute.name,
          path: 'notification',
        );

  static const String name = 'NotificationRoute';
}

/// generated route for
/// [_i1.SettingsScreen]
class SettingsRoute extends _i3.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'settings',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i1.MessageScreen]
class MessageRoute extends _i3.PageRouteInfo<void> {
  const MessageRoute()
      : super(
          MessageRoute.name,
          path: 'message',
        );

  static const String name = 'MessageRoute';
}
