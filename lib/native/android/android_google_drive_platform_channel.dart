import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidGoogleDrivePlatformChannel {
  static const String channelName = "avexmobile.page.link/drive_android";
  static const platform = MethodChannel(channelName);

  static Future<void> invoke() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('change_activity');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    return;
  }
}
