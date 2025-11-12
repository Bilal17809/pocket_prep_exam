import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import '/core/routes/routes_name.dart';
import '../control/splash_controller.dart';
import '/ad_manager/splash_interstitial.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final splashAds=Get.find<SplashInterstitialManager>();
  @override
  void initState() {
    splashAds.loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final splashAds = Get.find<SplashInterstitialManager>();
    final controller = Get.find<SplashController>();
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("images/appsplash.png", fit: BoxFit.fill),
            Positioned(
              bottom: 100,
              left: 40,
              right: 40,
              child: Obx(() {
                final isDone = controller.showButton.value;
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                  child: isDone
                      ? GestureDetector(
                    key: const ValueKey("button"),
                    onTap: () {
                      if (controller.isExam.value) {
                        // if (splashAds.isAdReady) {
                        //   splashAds.showSplashAd(() {});
                        // }
                        Get.offNamed(RoutesName.dashBoard);
                      } else {
                        Get.offNamed(RoutesName.login);
                      }
                    },
                    child: Container(
                      height: height * 0.07,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFE14A), Color(0xFFFF8605)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: theme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  )
                      : Column(
                    key: const ValueKey("progress"),
                    children: [
                      LinearProgressIndicator(
                        value: controller.progress.value,
                        backgroundColor: Colors.white30,
                        color: Colors.orangeAccent,
                        minHeight:25,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

