import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pocket_prep_exam/ad_manager/remove_ads.dart';
import 'package:pocket_prep_exam/core/constant/constant.dart';

import '../core/global_keys/global_keys.dart';
import '../services/remote_config_service.dart';
import 'app_open_ads.dart';

class InterstitialAdManager extends GetxController {
  InterstitialAd? _currentAd;
  bool _isAdReady = false;
  var isShow = false.obs;
  int visitCounter = 0;
  late int displayThreshold;
  final removeAds = Get.find<RemoveAds>();


  @override
  void onInit() {
    super.onInit();
    displayThreshold = 3;
    initRemoteConfig();
    _loadAd();
  }

  @override
  void onClose() {
    _currentAd?.dispose();
    super.onClose();
  }

  Future<void> initRemoteConfig() async {
    try {
      await RemoteConfigService().init(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 1),
      );
      final newThreshold = RemoteConfigService().getInt(
        androidIntersVal,
        '',
      );
      if (newThreshold > 0) {
        displayThreshold = newThreshold;
      }
    } catch (e) {
      debugPrint("Failed to load Interstitial RemoteConfig: $e");
    }
  }

  void _loadAd() {
    InterstitialAd.load(
      adUnitId:Platform.isAndroid? androidInterstitialId
      :'',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _currentAd = ad;
          _isAdReady = true;
          update();
        },
        onAdFailedToLoad: (error) {
          _isAdReady = false;
          debugPrint("Interstitial load error: $error");
        },
      ),
    );
  }

  void _showAd() {
    if(removeAds.isSubscribedGet.value){
      SizedBox();
    }
    if (_currentAd == null) return;
    isShow.value = true;
    _currentAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        Get.find<AppOpenAdManager>().setInterstitialAdDismissed();
        ad.dispose();
        isShow.value = false;
        _resetAfterAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint("Interstitial failed: $error");
        Get.find<AppOpenAdManager>().setInterstitialAdDismissed();
        ad.dispose();
        isShow.value = false;
        _resetAfterAd();
      },
    );

    _currentAd!.show();
    _currentAd = null;
    _isAdReady = false;
  }

  void checkAndDisplayAd() {
    visitCounter++;
    debugPrint("Visit count: $visitCounter");
    if (visitCounter >= displayThreshold) {
      if (_isAdReady) {
        _showAd();
      } else {
        debugPrint("Interstitial not ready yet.");
        visitCounter = 0;
      }
    }
  }

  void showAd() {
    _showAd();
  }

  void _resetAfterAd() {
    visitCounter = 0;
    _isAdReady = false;
    _loadAd();
    update();
  }
}
