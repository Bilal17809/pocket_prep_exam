import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/pages/edite_subjects/controller/edite_subject_controller.dart';
import '/pages/questions/control/questions_controller.dart';
import '/pages/questions/view/questions_view.dart';
import '/core/common/common_button.dart';
import '/core/theme/app_colors.dart';

class TimedQuizBottomSheet extends StatelessWidget {
  const TimedQuizBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionController>();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(

              children: [
                // Close button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: lightSkyBlue, size: 30),
                    onPressed: () => Get.back(),
                  ),
                ),
                Image.asset("images/stopwatch.png", height: 36),
                const Text(
                  'Timed Quiz',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 36),
                const Text(
                  'How many minutes?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Obx(() => Text(
                  controller.selectedMinutes.value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Text(
                      '5', style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Expanded(
                      child: Obx(() => SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: lightSkyBlue,
                          inactiveTrackColor: Colors.grey.withAlpha(60),
                          thumbColor: lightSkyBlue,
                          overlayColor: lightSkyBlue.withAlpha(100),
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 12,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 20,
                          ),
                        ),
                        child: Slider(
                          value: controller.selectedMinutes.value,
                          min: 5,
                          max: 15,
                          label: '${controller.selectedMinutes.value.toInt()} min',
                          onChanged: (value) => controller.updateMinutes(value),
                        ),
                      )),
                    ),
                    const Text(
                      '15',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
          CommonButton(
            title: "Start Quiz",
            onTap: () async {
                final selectedMinutes = controller.selectedMinutes.value.toInt();
                final totalSeconds = selectedMinutes * 60;
                controller.moveQuizView();
                  Get.to(() => QuizzesView(
                    allQuestion: controller.quizQForTime,
                    isTimedQuiz: true,
                    timedQuizMinutes: totalSeconds,
                  ))?.then((_) {
                    Get.back();
                  });
            },
          ),
        ],
      ),
    );
  }
  static void show() {
    Get.bottomSheet(
      const TimedQuizBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
    );
  }
}