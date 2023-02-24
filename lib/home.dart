import 'dart:async';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:test_project/authWrapper.dart';
import 'package:test_project/dynamic_link_handler.dart';
import 'package:test_project/lend_borrow_screen.dart';
import 'package:test_project/recieve.dart';
import 'package:test_project/send.dart';
import 'package:test_project/swap.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  @override
  void initState() {
    // DynamicLinkHandler.initDynamicLinks(context, FirebaseDynamicLinks.instance);
    // DynamicLinkHandler().initUniLinks();
    // TODO: implement initState
    super.initState();
  }

  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SendScreen()));
                },
                child: Text("Send")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReceiveScreen()));
                },
                child: Text("Recieve")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SwapScreen()));
                },
                child: Text("Swap")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LendBorrowScreen()));
                },
                child: Text("Lend/Borrow")),
            // ElevatedButton(
            //     onPressed: () {
            //       setState(() {
            //         encryptedSharedPreferences.clear();
            //         encryptedSharedPreferences.reload();
            //       });
            //     },
            //     child: Text("LogOut")),
          ],
        ),
      ),
    );
  }
}
