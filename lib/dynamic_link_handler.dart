import 'dart:async';
import 'dart:developer';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_project/home.dart';
import 'package:test_project/lend_borrow_screen.dart';
import 'package:test_project/onboarding.dart';
import 'package:test_project/swap.dart';
import 'package:test_project/test.dart';
import 'package:test_project/wallet_connect/qr_scan.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkHandler {
  late StreamSubscription _sub;
  // Future<Null> initUniLinks() async {
  //   try {
  //     final initialUri = await getInitialUri();
  //     String? initialLink = await getInitialLink();
  //     Fluttertoast.showToast(msg: initialLink.toString());
  //     log(initialLink.toString());
  //     _sub = linkStream.listen((event) {
  //       Fluttertoast.showToast(msg: initialLink.toString());
  //       log(event.toString());
  //     }, onError: (err) {
  //       Fluttertoast.showToast(msg: initialLink.toString());
  //       log(err);
  //     });
  //   } on PlatformException {}
  // }

  static Future<void> initDynamicLinks(
      BuildContext context, FirebaseDynamicLinks _dynamicLinks) async {
    String code = '';
    EncryptedSharedPreferences encryptedSharedPreferences =
        EncryptedSharedPreferences();
    _dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParameter = uri.queryParameters;

      if (queryParameter.isNotEmpty &&
          dynamicLinkData.link.path == "/mailsuccess/") {
        String authCode = queryParameter["authCode"].toString();
        if (authCode.isNotEmpty) {
          log(authCode);
          // () async {
          encryptedSharedPreferences.setString("code", authCode);
          //   code = authCode;
          // };
        }
        // String? password = queryParameter["password"];
        log(dynamicLinkData.link.path);
        log(authCode.toString());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()
                // OnBoardingScreen(
                // authcode: authCode.toString(),
                // ),
                ));
      } else if (queryParameter.isNotEmpty &&
          dynamicLinkData.link.path == '/recieve/') {
        // Navigator.pushNamed(context, dynamicLinkData.link.path);
        log("empty params");
      }
    }).onError((error) {
      print(error);
    });
  }
}
