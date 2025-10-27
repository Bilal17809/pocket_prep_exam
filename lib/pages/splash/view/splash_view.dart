import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import '/core/routes/routes_name.dart';
import '/core/theme/app_colors.dart';
import '../control/splash_controller.dart';

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
    final controller = Get.find<SplashController>();
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "images/splash.png",
              fit: BoxFit.fill,
            ),
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: Padding(
            //     padding: EdgeInsets.only(top: height * 0.08),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Text(
            //           "PocketPrep",
            //           style: theme.headlineMedium?.copyWith(
            //             color: kWhite,
            //             fontSize: 28,
            //             fontWeight: FontWeight.bold,
            //             letterSpacing: 1.5,
            //             shadows: [
            //               Shadow(
            //                 color: Colors.black.withOpacity(0.4),
            //                 offset: const Offset(2, 2),
            //                 blurRadius: 6,
            //               ),
            //             ],
            //           ),
            //         ),
            //
      
            // Get Started Button (Bottom)
            Positioned(
              bottom: 90,
              left: 40,
              right: 40,
              child: GestureDetector(
                onTap: (){
                  if (controller.isExam.value == true) {
                    if (splashAds.isAdReady) {
                      splashAds.showSplashAd(() {});
                    }
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
                    boxShadow: [
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
                        color: kWhite,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,

                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
