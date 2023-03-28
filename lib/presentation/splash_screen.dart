import 'dart:async';
import 'dart:math';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/router.gr.dart';
import '../dynamic_link_handler.dart';
import '../services/local_services/encrypted_shared_pref.dart';
import 'main/home/home_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late StreamSubscription dynamicLinkStreamSubscription;
  @override
  void initState() {
    super.initState();
    String code = '';
    EncryptedSharedPreferences encryptedSharedPreferences =
        EncryptedSharedPreferences();
    dynamicLinkStreamSubscription =
        FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParameter = uri.queryParameters;
      debugPrint(uri.toString());
      debugPrint(queryParameter.toString());
      if (queryParameter.isNotEmpty &&
          dynamicLinkData.link.path == "/signup/") {
        String authCode = queryParameter["userAuthenticationCode"].toString();
        onAuthDynamicLink(authCode);
      }
    });
    checkForAuth();
  }

  @override
  void dispose() {
    dynamicLinkStreamSubscription.cancel();
    super.dispose();
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

  void checkForAuth() async {
    if (await checkForAuthStatus()) {
      onAuthSuccess();
    } else {
      onAuthFailure();
    }
  }

  void onAuthFailure() {
    // debugPrint('my.app.category');
    if (mounted) {
      AutoRouter.of(context).replace(SignupRoute());
    }
  }

  void onAuthSuccess() {
    if (mounted) AutoRouter.of(context).replace(MainRouter());
    // print("THIS");
  }

  void onAuthDynamicLink(String authId) {
    if (mounted)
      AutoRouter.of(context)
          .replace(DynamicLinkProcessingRoute(authToken: authId));
  }

  Future<bool> checkForAuthStatus() async {
    final authCheck = await ref
        .read(encryptedSharedPrefProvider)
        .instance
        .getString("isAuthCheck");

    return authCheck == "true";
  }
}
