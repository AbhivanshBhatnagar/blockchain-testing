import 'package:flutter/material.dart';
import 'package:ntcdcrypto/ntcdcrypto.dart';
import 'dart:developer';
import 'package:bip39/bip39.dart' as bip39;
import 'package:test_project/constants.dart';

class RecoveryScreen extends StatefulWidget {
  const RecoveryScreen({super.key});

  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

SSS sss = new SSS();
String data1 = '', data2 = '', data3 = '';
Map<String, int> data = {"data1": 0, "data2": 1, "data3": 2};
void generateShares() {
  String s = Constants.seedPhrase;
  log("secret: ${s}");
  log("secret.length: ${s.length}");
  // creates a set of shares
  List<String> arr = sss.create(2, 3, s, false);
  log(arr.toString());
  switch (numberOfTasks) {
    case 2:
      {
        var s1;
        List<String> l1 = [arr[0], arr[arr.length - 1]];
        data.removeWhere((key, value) => value == "");
        if (data["data1"] != "" && data["data2"] != "") {
          s1 = sss.combine(arr.sublist(0, 2), false);
          bip39.validateMnemonic(s1) ? log("valid") : log("invalid");
        } else if (data["data1"] != "" && data["data3"] != "") {
          arr.removeRange(1, 2);
          s1 = sss.combine(arr, false);
          bip39.validateMnemonic(s1) ? log("valid") : log("invalid");
        } else if (data["data2"] != "" && data["data3"] != "") {
          s1 = sss.combine(arr.sublist(1, 3), false);
          bip39.validateMnemonic(s1) ? log("valid") : log("invalid");
        }
        log("secret: ${s1}");
        log(s.toString());
        Constants().createAccount(s1, true);
        // log("secret.length:}");

        break;
      }
    case 3:
      {
        var s1;
        s1 = sss.combine(arr.sublist(0, arr.length - 1), false);
        bip39.validateMnemonic(s1) ? log("valid") : log("invalid");
        Constants().createAccount(s1, true);
        log("3 tasks done");
        break;
      }
    default:
      {
        log("Already Recovered");
      }
  }

  // var s1 = sss.combine(arr.sublist(0, 2), false);
  // print("combines shares 1 length = ${arr.sublist(0, 3).length}");
  // print("secret: ${s1}");
  // print("secret.length: ${s1.length}");

  // combines shares into secret
  // var s1 = sss.combine(data.sublist(0, 3), false);
  // log("combines shares 1 length = ${arr.sublist(0, 3).length}");

  // var s2 = sss.combine(arr.sublist(3, arr.length), false);
  // log("combines shares 2 length = ${arr.sublist(3, arr.length).length}");
  // log("secret: ${s2}");
  // log("secret.length: ${s2.length}");

  // var s3 = sss.combine(arr.sublist(1, 5), false);
  // log("combines shares 3 length = ${arr.sublist(1, 5).length}");
  // log("secret: ${s3}");
  // log("secret.length: ${s3.length}");
  // log(arr.toString());
}

int numberOfTasks = 0;
taskDone() {
  numberOfTasks++;
  log(numberOfTasks.toString());
  if (numberOfTasks >= 2) {
    log("can recover");
    generateShares();
  }
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  data["data1"] = 0;
                  taskDone();
                  log(data.toString());
                },
                child: Text("Task 1")),
            ElevatedButton(
                onPressed: () {
                  data["data2"] = 1;
                  taskDone();
                  log(data.toString());
                },
                child: Text("Task 2")),
            ElevatedButton(
                onPressed: () {
                  data["data3"] = 2;
                  taskDone();
                  log(data.toString());
                },
                child: Text("Task 3")),
            ElevatedButton(
                onPressed: () {
                  numberOfTasks = 0;
                  data.clear();
                  log(numberOfTasks.toString());
                  log(data.toString());
                  Constants().getPrice(token: "polygon");
                },
                child: Text("Reset")),
            ElevatedButton(onPressed: () {}, child: Text("Recover")),
          ],
        ),
      ),
    );
  }
}
