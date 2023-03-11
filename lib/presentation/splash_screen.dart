import 'dart:math';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../core/auth_state.dart';
import '../core/router.gr.dart';
import 'main/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends AuthState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          height: 100,
          width: 100,
        ),
      ),
    );
  }

  @override
  void onAuthFailure() {
    // TODO: implement onAuthFailure
  }

  @override
  void onAuthSuccess() {
    AutoRouter.of(context).replace(MainRouter());
    // print("THIS");
  }
}
