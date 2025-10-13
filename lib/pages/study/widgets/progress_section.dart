import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/stats/controller/stats_controller.dart';
import '../controller/study_controller.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_styles.dart';
import 'game_button.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final studyController = Get.find<StudyController>();

    return Obx(() {
      final bool completed = !studyController.isQuestionOfDayVisible.value;
      final bool isCorrect = studyController.isQuestionOfDayCorrect.value;
      final averageTimeAllSubjects = Get.find<StatsController>().averageTime;
      // final averageTimeMinutes = _parseAverageTimeToMinutes(averageTimeAllSubjects);
      // final normalizedValue = (averageTimeMinutes / 60).clamp(0.0, 1.0);
      final progressValueAllSubjects = Get.find<StatsController>().progressValue;

      final Color progressColor = completed ? (isCorrect ? kMintGreen: Colors.red)
          : Colors.grey.shade300;


      final double progressValue = completed ? 1.0 : 0.0;
      final String progressText = completed ? "1/1" : "0/1";

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: roundedDecoration,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "images/calendar-date.png",
                  height: 70,
                  width: 70,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProgressText(
                        title: "Today's questions progress",
                        value: progressText,
                        color: greyColor.withAlpha(220),
                      ),
                      const SizedBox(height: 4),
                      _LProgressIndicator(
                        value: progressValue,
                        color: progressColor,
                      ),
                      const SizedBox(height: 16),
                      _ProgressText(
                        title: "Today's practice Avg Time",
                        value:averageTimeAllSubjects,
                        color: greyColor.withAlpha(220),
                      ),
                      const SizedBox(height: 4),
                      _LProgressIndicator(
                        value: progressValueAllSubjects,
                        color: lightSkyBlue,
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      );
    });
  }
}

class _LProgressIndicator extends StatelessWidget {
  final double value;
  final Color color;

  const _LProgressIndicator({
    super.key,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 6,
        backgroundColor: Colors.grey.shade300,
        color: color,
      ),
    );
  }
}

class _ProgressText extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const _ProgressText({super.key, required this.title, required this.value,required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: context.textTheme.titleSmall!.copyWith(
          color: color
        ),),
        Text(value,style: context.textTheme.titleSmall!.copyWith(
         color: greyColor.withAlpha(240)
    ),)
      ],
    );
  }
}

double _parseAverageTimeToMinutes(String timeString) {
  final parts = timeString.split(':');
  if (parts.length != 2) return 0.0;
  final minutes = int.tryParse(parts[0]) ?? 0;
  final seconds = int.tryParse(parts[1]) ?? 0;
  return minutes + (seconds / 60);
}
