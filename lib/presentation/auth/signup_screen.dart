import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/core/router.gr.dart';
import 'package:test_project/models/models.dart';
import 'package:test_project/presentation/widget/button.dart';

import '../../core/auth_state.dart';
import '../../services/api_services/api_client/avex_api_client.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends AuthState<SignupScreen> {
  double signupButtonOpacity = 0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
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
                          style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 24)
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "An amazing web3 journey awaits",
                          style:
                              GoogleFonts.inter(color: const Color(0xFF626164)),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.15),
                    SvgPicture.asset("assets/logo.svg",
                        semanticsLabel: 'Acme Logo'),
                    SizedBox(height: screenHeight * 0.125),
                    Row(
                      children: [
                        Text(
                          "Email",
                          style: GoogleFonts.inter(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      autofocus: false,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            this.signupButtonOpacity = 0;
                          });
                        } else {
                          setState(() {
                            this.signupButtonOpacity = 1;
                          });
                        }
                      },
                      style:
                          TextStyle(fontSize: 17.0, color: Color(0xFFbdc6cf)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF25252D),
                        hintText: 'Email',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        AnimatedOpacity(
                          opacity: 1 - signupButtonOpacity,
                          duration: const Duration(milliseconds: 500),
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.15 * 0.25),
                              const Text("Or continue with"),
                              SizedBox(height: screenHeight * 0.15 * 0.25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      SignupRequest signupRequest =
                                          const SignupRequest(
                                              email:
                                                  "daimashashank10@gmail.com");
                                      final response = await ref
                                          .read(avexApiClientProvider)
                                          .generateEmailDynamicLink(
                                              signupRequest);
                                      print(response.response.statusCode
                                          .toString());
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF25252D)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: SvgPicture.asset(
                                            "assets/google_logo.svg"),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => {
                                      AutoRouter.of(context)
                                          .push(const OnboardingRoute())
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF25252D)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SvgPicture.asset(
                                            "assets/twitter_logo.svg"),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF25252D)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: SvgPicture.asset(
                                          "assets/fb_logo.svg"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned.fill(
                            child: Align(
                                alignment: Alignment.center,
                                child: AnimatedOpacity(
                                  opacity: signupButtonOpacity,
                                  duration: const Duration(milliseconds: 500),
                                  child: CustomButton(
                                      title: "Signup", onClick: () {}),
                                )))
                      ],
                    )
                  ],
                ),
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
