import 'dart:io';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../core/constant/constant.dart';

class OnesignalService {
  static Future<void> init() async {
    if (Platform.isAndroid) {
      OneSignal.initialize(oneSignalAndroidKey);
      await OneSignal.Notifications.requestPermission(true);
    } else if (Platform.isIOS) {
      OneSignal.initialize(iosOneSignalKey);
      await OneSignal.Notifications.requestPermission(true);
    } else {
      debugPrint("Platform not supported");
    }
  }
}
