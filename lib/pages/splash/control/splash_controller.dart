
import 'package:get/get.dart';
import '../../../ad_manager/splash_interstitial.dart';
import '/core/local_storage/storage_helper.dart';
import 'dart:async';

class SplashController extends GetxController {
  final StorageService _storageService;

  final RxBool isExam = false.obs;
  final RxDouble progress = 0.0.obs;
  final RxBool showButton = false.obs;

  Timer? _timer;

  SplashController({required StorageService storageService})
      : _storageService = storageService;

  @override
  void onInit() {
    super.onInit();
    Get.find<SplashInterstitialManager>().loadAd();
    _loadProgressBar();
    _loadExam();
  }

  Future<void> _loadExam() async {
    final examId = await _storageService.getExam();
    if (examId != null) {
      isExam.value = true;
    }
  }

  void _loadProgressBar() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      progress.value += 0.01;
      if (progress.value >= 1.0) {
        progress.value = 1.0;
        showButton.value = true;
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
