import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:test_project/home.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_project/lend_borrow_screen.dart';
import 'package:test_project/onboarding1.dart';
import 'package:test_project/send.dart';
import 'package:test_project/splashScreen.dart';
import 'package:test_project/swap.dart';
import 'package:test_project/test.dart';
import 'package:test_project/wallet_connect/wallet_connect_screen.dart';
import 'authWrapper.dart';
import 'dynamic_link_handler.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        // '/': (context) => const OnBoardingScreen(),
        '/recieve/': (context) => SendScreen(),
        '/mailSuccess/': (context) => OnBoarding1Screen()
      },
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.amber,
      ),
      home: Builder(builder: (context) {
        return SplashScreen();
      }),
    );
  }
}
