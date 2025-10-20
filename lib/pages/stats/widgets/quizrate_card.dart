import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import '../controller/stats_controller.dart';

class QuizRateCard extends StatelessWidget {
  const QuizRateCard({super.key});

  @override
  Widget build(BuildContext context) {
    final statsController = Get.find<StatsController>();

    return Obx(() {
      // Option 1: Progress based on subjects attempted vs total subjects
      final percentage = statsController.overallProgressPercentage;
      final progressValue = statsController.progressValue;

      // Option 2: Progress based on average score (uncomment to use this instead)
      // final percentage = statsController.averageScorePercentage;
      // final progressValue = statsController.averageScoreProgressValue;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: roundedDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quiz Rate",
                    style: titleSmallStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _StatRow(label: "Total Questions", value:  statsController.totalAttemptedQuestions.toString()),
                  // _StatRow(label: "Average Questions", value: statsController.averageQuestions),
                  _StatRow(label: "Quiz Attempts", value: statsController.totalQuizAttempts.toString()),
                  _StatRow(label: "Subjects Attempted", value: statsController.subjectsAttempted.toString()),
                ],
              )
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    value: progressValue,
                    strokeWidth: 7,
                    backgroundColor: Colors.grey.shade200,
                    valueColor:  AlwaysStoppedAnimation<Color>(lightSkyBlue),
                  ),
                ),
                Text(
                    percentage,
                    style: bodyMediumStyle.copyWith(
                        color: lightSkyBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: bodyMediumStyle.copyWith(color: Colors.black54),
          ),
          Text(
            value,
            style: bodyMediumStyle.copyWith(
              color: kBlack,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
