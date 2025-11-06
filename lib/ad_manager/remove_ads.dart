// import 'package:get/get.dart';
// import '../core/local_storage/storage_helper.dart';
//
// class RemoveAds extends GetxController {
//   var isSubscribedGet = false.obs;
//   @override
//   void onInit() {
//     super.onInit();
//     checkSubscriptionStatus();
//   }
//   Future<void> checkSubscriptionStatus() async {
//     final isSubscribed = await StorageService.getSubscriptionStatus();
//     isSubscribedGet.value = isSubscribed;
//   }
//
//   Future<void> setSubscriptionStatus(bool value) async {
//     await StorageService.saveSubscriptionStatus(value);
//     isSubscribedGet.value = value;
//   }
// }

import 'package:get/get.dart';
import '../core/local_storage/storage_helper.dart';

class RemoveAds extends GetxController {
  var isSubscribedGet = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkSubscriptionStatus();
  }

  /// Load subscription status from local storage
  Future<void> checkSubscriptionStatus() async {
    final isSubscribed = StorageService.getGeneralSubscriptionStatus();
    isSubscribedGet.value = isSubscribed;
  }

  /// Update subscription both locally and in memory
  Future<void> setSubscriptionStatus(bool value) async {
    await StorageService.saveGeneralSubscriptionStatus(value);
    isSubscribedGet.value = value;
  }

  /// Clear subscription info (for logout or expiry)
  Future<void> clearSubscription() async {
    await StorageService.clearSubscriptionState();
    isSubscribedGet.value = false;
  }
}
