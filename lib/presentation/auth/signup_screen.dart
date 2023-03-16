import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/auth_state.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends AuthState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "Let's get Started!",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w600, fontSize: 26),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("An amazing web3 journey awaits"),
                    ],
                  ),
                  SvgPicture.asset("assets/logo.svg",
                      semanticsLabel: 'Acme Logo'),
                  Row(
                    children: [
                      const Text("Email"),
                    ],
                  ),
                  TextField(),
                  Text("Or continue with"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF25252D)),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset("assets/google_logo.svg"),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF25252D)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset("assets/twitter_logo.svg"),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF25252D)),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SvgPicture.asset("assets/fb_logo.svg"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
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
    // TODO: implement onAuthSuccess
  }
}
