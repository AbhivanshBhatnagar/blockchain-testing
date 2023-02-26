import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:test_project/authWrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.black,
      splash: Icon(
        Icons.money,
        color: Colors.white,
        size: 150,
      ),
      nextScreen: AuthWrapper(),
      splashTransition: SplashTransition.fadeTransition,
      curve: Curves.easeInExpo,
      animationDuration: Duration(seconds: 1, milliseconds: 500),
    );
  }
}
