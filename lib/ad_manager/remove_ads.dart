import 'package:get/get.dart';
import '../core/local_storage/storage_helper.dart';

class RemoveAds extends GetxController {
  var isSubscribedGet = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkSubscriptionStatus();
  }

  Future<void> checkSubscriptionStatus() async {
    final isSubscribed = await StorageService.getSubscriptionStatus();
    isSubscribedGet.value = isSubscribed;
  }

  Future<void> setSubscriptionStatus(bool value) async {
    await StorageService.saveSubscriptionStatus(value);
    isSubscribedGet.value = value;
  }
}
