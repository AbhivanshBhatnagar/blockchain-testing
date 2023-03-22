import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidGoogleDrivePlatformChannel {
  static const String channelName = "avexmobile.page.link/drive_android";
  static const platform = MethodChannel(channelName);

  static Future<void> invoke() async {
    String batteryLevel;
    try {
      final String result = await platform.invokeMethod('change_activity');
      batteryLevel = 'Battery level at $result % .';
      debugPrint(batteryLevel);


    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
      debugPrint(batteryLevel);
    }
    return;
  }
}
