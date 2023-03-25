import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/router.gr.dart';
import '../widget/button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C83A0),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    size: 62,
                    Icons.mail,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Confirm you’re email",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, fontSize: 40),
              ),
              Text(
                "Check your email on this device to verify your account",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Expanded(child: Container()),
              Text(
                "You can resend in 28 seconds",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Text(
                "Sent to xyz@gmail.com",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFFDEDEDE)),
              ),
              SizedBox(
                height: 12,
              ),
              CustomButton(
                  onClick: () =>
                      {AutoRouter.of(context).push(SeedRecoveryRoute())},
                  title: "Open My Email",
                  isLoading: false),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    dynamicLinkStreamSubscription.cancel();
    super.dispose();
  }

  void onAuthDynamicLink(String authId) {
    if (mounted)
      AutoRouter.of(context)
          .replace(DynamicLinkProcessingRoute(authToken: authId));
  }
}
