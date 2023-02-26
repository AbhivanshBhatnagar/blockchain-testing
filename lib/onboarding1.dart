// import 'dart:math';

import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/confirmEmail.dart';
import 'package:test_project/constants.dart';
import 'package:test_project/import.dart';
import 'package:test_project/onboarding2.dart';
import 'package:test_project/screenArgs.dart';
import 'package:test_project/swap.dart';

import 'dynamic_link_handler.dart';
import 'package:local_auth/local_auth.dart';

class OnBoarding1Screen extends StatefulWidget {
  String args = '';
  OnBoarding1Screen({super.key, String authcode = ''}) {
    args = authcode;
  }

  @override
  State<OnBoarding1Screen> createState() => _OnBoarding1ScreenState();
}

class _OnBoarding1ScreenState extends State<OnBoarding1Screen> {
  @override
  void initState() {
    // TODO: implement initState
    // DynamicLinkHandler.initDynamicLinks(context, FirebaseDynamicLinks.instance);
    super.initState();
  }

  LocalAuthentication auth = LocalAuthentication();
  @override
  Widget build(BuildContext context) {
    // final args =
    // ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Welcome to Avex",
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              Text(
                textAlign: TextAlign.left,
                "Best Ecosystem around",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      final bool didAuthenticate = await auth.authenticate(
                          options:
                              const AuthenticationOptions(stickyAuth: true),
                          localizedReason:
                              'Please authenticate to create new Wallet');
                      // ···
                      if (didAuthenticate) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnBoarding2Screen(),
                            ));
                      } else {
                        log("Couldn't Authenticate. Please Try again.");
                      }
                    } catch (E) {
                      log(E.toString());
                    }
                  },
                  child: Text("Create a new Wallet")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImportWalletScreen(),
                        ));
                  },
                  child: Text("Import Existing wallet")),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
