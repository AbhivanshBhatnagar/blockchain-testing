import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../presentation/main/main_router.dart';
import '../presentation/presentation.dart';

@MaterialAutoRouter(replaceInRouteName: 'Screen,Route', routes: [
  AutoRoute(path: '/', page: SplashScreen),
  AutoRoute(
      path: '/main',
      name: 'MainRouter',
      page: MainPageHostScreen,
      children: [
        AutoRoute(path: 'home', page: HomeScreen),
        AutoRoute(path: 'search', page: SearchScreen),
        AutoRoute(path: 'notification', page: NotificationScreen),
        AutoRoute(path: 'settings', page: SettingsScreen),
        AutoRoute(path: 'message', page: MessageScreen),
      ]),
])
class $AppRouter {}
