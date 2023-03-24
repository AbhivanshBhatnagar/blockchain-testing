import 'dart:async';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dynamic_link_handler.dart';

abstract class AuthState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  bool _redirectCalled = false;
  bool _isDynamicLinkCalled=false;
  @override
  void initState() {
    super.initState();
    initDynamicLinks(context, FirebaseDynamicLinks.instance);
    if(!_isDynamicLinkCalled){
      redirect();
    }
  }

  Future<void> initDynamicLinks(
      BuildContext context, FirebaseDynamicLinks _dynamicLinks) async {
    String code = '';
    EncryptedSharedPreferences encryptedSharedPreferences =
        EncryptedSharedPreferences();
    _dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParameter = uri.queryParameters;
      debugPrint(uri.toString());
      debugPrint(queryParameter.toString());
      if (queryParameter.isNotEmpty &&
          dynamicLinkData.link.path == "/signup/") {
        String authCode = queryParameter["userAuthenticationCode"].toString();
        onAuthDynamicLink(authCode);
      }
   _isDynamicLinkCalled=true;

    }).onError((error) {
      print(error);
    });
  }

  //For One-time get authSessions
  Future<void> redirect() async {
    await Future.delayed(Duration.zero);
    if (_redirectCalled || !mounted) {
      return;
    }
    _redirectCalled = true;
    if (true) {
      onAuthFailure();
    } else
      onAuthSuccess();
  }

  //For Stream Subscription of Auth Sessions
  initAuthSubscription() {
    // _authStateSubscription = SupabaseClient.getAuthSession().listen((event) {
    //   if (_redirectCalled) return;
    //   final session = event!.session;
    //   if (session != null && !_redirectCalled) {
    //     _redirectCalled = true;
    //     onAuthSuccess();
    //   } else {
    //     onAuthFailure();
    //   }
    // });
  }

  disposeAuthSubscription() {
    // _authStateSubscription.cancel();
  }

  void onAuthSuccess();
  void onAuthFailure();
  void onAuthDynamicLink(String authId);
}
