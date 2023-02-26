import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:test_project/confirmEmail.dart';
import 'package:test_project/screenArgs.dart';

import 'dynamic_link_handler.dart';

class OnBoardingScreen extends StatefulWidget {
  String args = '';
  OnBoardingScreen({super.key, String authcode = ''}) {
    args = authcode;
  }

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // DynamicLinkHandler.initDynamicLinks(context, FirebaseDynamicLinks.instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    // ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmEmail(),
                        ));
                  },
                  child: Text("Enter Your Email")),
              Text(widget.args.toString())
            ],
          ),
        ),
      ),
    );
  }
}
