import 'dart:io';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OnesignalService {
  static Future<void> init() async {
    if (Platform.isAndroid) {
      OneSignal.initialize("79e2bbfa-6fec-4023-b5fd-8260ee098792");
      await OneSignal.Notifications.requestPermission(true);
    } else if (Platform.isIOS) {
      OneSignal.initialize("");
      await OneSignal.Notifications.requestPermission(true);
    } else {
      debugPrint("Platform not supported");
    }
  }
}
