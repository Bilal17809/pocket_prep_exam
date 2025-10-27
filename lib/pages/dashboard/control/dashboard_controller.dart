import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var setIndex = 0.obs;

  @override
  void onInit() {
    requestTrackingPermission();
    super.onInit();
  }

  void trackIndex(int index) {
    setIndex.value = index;
  }

  void setInitialIndex(int index) {
    setIndex.value = index;
  }

  Future<void> requestTrackingPermission() async {
    if (!Platform.isIOS) {
      return;
    }
    final trackingStatus =
    await AppTrackingTransparency.requestTrackingAuthorization();

    switch (trackingStatus) {
      case TrackingStatus.notDetermined:
        print('User has not yet decided');
        break;
      case TrackingStatus.denied:
        print('User denied tracking');
        break;
      case TrackingStatus.authorized:
        print('User granted tracking permission');
        break;
      case TrackingStatus.restricted:
        print('Tracking restricted');
        break;
      default:
        print('Unknown tracking status');
    }
  }

}
