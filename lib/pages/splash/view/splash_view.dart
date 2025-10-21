import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/routes/routes_name.dart';
import '/core/theme/app_colors.dart';
import '../control/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/spla.png",
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.08),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "PocketPrep",
                    style: theme.headlineMedium?.copyWith(
                      color: kWhite,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(2, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Professional",
                    style: theme.titleMedium?.copyWith(
                      color: Colors.white70,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Get Started Button (Bottom)
          Positioned(
            bottom: 60,
            left: 40,
            right: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 6,
              ),
              onPressed: () {
                if (controller.isExam.value == true) {
                  Get.offNamed(RoutesName.dashBoard);
                } else {
                  Get.offNamed(RoutesName.login);
                }
              },
              child: Text(
                "Get Started",
                style: theme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
