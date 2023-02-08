import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:test_project/dynamic_link_handler.dart';
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
    // TODO: implement initState
    DynamicLinkHandler.initDynamicLinks(context, FirebaseDynamicLinks.instance);
    super.initState();
  }

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
          ],
        ),
      ),
    );
  }
}
