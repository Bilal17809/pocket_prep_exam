import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/ad_manager/remove_ads.dart';
import '../core/common/ads_shimmer.dart';
import '../core/constant/constant.dart';
import '../core/global_keys/global_keys.dart';
import '../services/remote_config_service.dart';
import 'app_open_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}
class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _isAdEnabled = true;

  final removeAds = Get.find<RemoveAds>();

  @override
  void initState() {
    super.initState();
    _fetchRemoteConfigAndLoadAd();
    loadBannerAd();
  }

  Future<void> _fetchRemoteConfigAndLoadAd() async {
    try {
      await RemoteConfigService().init();
      final showBanner = RemoteConfigService().
      getBool(androidBannerVal,iosBannerVal);
      if (!mounted) return;
      setState(() => _isAdEnabled = showBanner);
      if (showBanner) {
        loadBannerAd();
      }
    }
    catch (e) {
      print('RemoteConfig error: $e');
    }
  }

  void loadBannerAd() async{
    AdSize? adSize = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.of(context).size.width.truncate(),
    );
    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ?androidBannerId
          :iosBannerId,
      size:adSize!,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() => _isAdLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          print('Banner Ad failed: ${error.message}');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appOpenAdController = Get.find<AppOpenAdManager>();
    return Obx(() {
      if (!_isAdEnabled ||
          removeAds.isSubscribedGet.value ||
          appOpenAdController.isAdVisible.value) {
        return const SizedBox();
      }
      return _isAdLoaded && _bannerAd != null
          ? SafeArea(
        child: Container(
          margin: const EdgeInsets.all(2.0),
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width:1.2),
            borderRadius: BorderRadius.circular(2.0),
          ),
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        ),
      )
          :  AdsShimmer();
    });
  }
}