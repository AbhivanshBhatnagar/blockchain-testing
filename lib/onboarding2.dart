import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_project/home.dart';
import 'package:test_project/wallet_creation.dart';

class OnBoarding2Screen extends StatefulWidget {
  const OnBoarding2Screen({super.key});

  @override
  State<OnBoarding2Screen> createState() => _OnBoarding2ScreenState();
}

class _OnBoarding2ScreenState extends State<OnBoarding2Screen> {
  WalletAddress walletAddress = WalletAddress();
  String? pubaddr;
  String? privaddr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(90.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Your good name?",
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(),
              ElevatedButton(
                  onPressed: () async {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: ((context) => Home())));
                    // final mnemonic = walletAddress.generateMnemonic();
                    final privatekey = await walletAddress.getPrivateKey(
                        "omit office bundle actual puppy nothing busy obtain alien suffer pave they");
                    final publickey =
                        await walletAddress.getPublicKey(privatekey);
                    privaddr = privatekey;
                    pubaddr = publickey.toString();
                    log('$privaddr $pubaddr ');
                  },
                  child: Text("Continue"))
            ],
          ),
        ),
      ),
    );
  }
}
