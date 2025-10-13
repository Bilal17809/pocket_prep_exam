import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '/pages/quiz_view_second/controller/quiz_controller.dart';
import '/pages/quiz_setup/controller/quiz_setup_controller.dart';

class TimerDisplayWidget extends StatelessWidget {
  const TimerDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final quizController = Get.find<QuizController>();
    final setupController = Get.find<QuizSetupController>();

    const double outerRingWidth = 5.0;
    const double innerProgressWidth = 5.0;
    const Color lightSegmentGray = Color(0xFFE0E0E0);
    const Color lightAquaBlue = Color(0xFF00ACD2);
    const Color lowTimeRed = Colors.red;

    return Obx(() {
      final currentIndex = quizController.currentPage.value;
      final int remainingTime = quizController.remainingTime[currentIndex] ?? 0;

      if (remainingTime == 0) return const SizedBox.shrink();

      final int maxTime = setupController.selectedTimeLimit.value;
      final double progress = (remainingTime / maxTime).clamp(0.0, 1.0);
      final bool isLowTime = remainingTime <= 5;
      final Color timerColor = isLowTime ? lowTimeRed : lightAquaBlue;

      return Stack(
        alignment: Alignment.center,
        children: [
          // Watch background
          Image.asset(
            'images/alarm.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),

          Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: lightSkyBlue,
                  width: outerRingWidth,
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircularProgressIndicator(
                  value: progress, // 0.0 to 1.0
                  strokeWidth: innerProgressWidth,
                  backgroundColor: lightSegmentGray,
                  valueColor: AlwaysStoppedAnimation<Color>(timerColor),
                ),
              )
          ),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: CurvedAnimation(parent: animation, curve: Curves.easeIn),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Column(
              key: ValueKey<int>(remainingTime),
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$remainingTime",
                  style: TextStyle(
                    fontSize: 20,
                    color: timerColor,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'sec',
                  style: TextStyle(
                    fontSize: 20,
                    color: timerColor,
                    height: 1.1,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
