import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/api_services/api_response.dart';

class AndroidGoogleDrivePlatformChannel {
  static const String channelName = "avexmobile.page.link/drive_android";
  static const platform = MethodChannel(channelName);

  static Future<void> signInWithGoogle() async {
    try {
      await platform.invokeMethod('signInWithGoogle');
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
    return;
  }

  static Future<void> uploadNewKeysInGDrive(
      String fileName, String fileContent) async {
    try {
      await platform
          .invokeMethod('uploadNewKeysInGDrive', [fileName, fileContent]);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> readFromGDrive(String fileName) async {
    try {
      await platform.invokeMethod('readFromGDrive', [fileName]);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
