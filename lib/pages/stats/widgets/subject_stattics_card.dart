import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import 'package:pocket_prep_exam/data/models/models.dart';
import '../controller/stats_controller.dart';

class SubjectStatisticsCard extends StatelessWidget {
  final Subject subject;
  const SubjectStatisticsCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    String formatTime(int seconds) {
      final minutes = seconds ~/ 60;
      final secs = seconds % 60;
      return minutes > 0 ? "${minutes}m ${secs}s" : "${secs}s";
    }

    final statsController = Get.find<StatsController>();

    return Obx(() {
      final result = statsController.latestResultForSubject(subject.subjectId);

      if (result == null) {
        return const SizedBox();
      }

      final double percentage =
      result.totalQuestions > 0 ? (result.totalCorrect / result.totalQuestions) * 100 : 0.0;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: roundedDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subject.subjectName,
                    style: bodyLargeStyle.copyWith(
                      color: greyColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
                Text("${percentage.toStringAsFixed(1)}%", style: bodyLargeStyle.copyWith(color: lightSkyBlue,fontWeight: FontWeight.bold,fontSize: 18)),
              ],
            ),
            const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:   LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade200,
              color: lightSkyBlue,
              minHeight: 6,
            ),
          ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 2.5,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _StatItem(value: formatTime(result.selectedQuizTime), label: "Quiz times"),
                _StatItem(value: "${result.totalCorrect}/${result.totalQuestions} items", label: "Answer progress"),
                _StatItem(value: formatTime(result.totalTime), label: "Total practice time"),
                _StatItem(value: "${result.totalWrong}", label: "Remaining mistakes "),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: context.textTheme.bodySmall!.copyWith(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}