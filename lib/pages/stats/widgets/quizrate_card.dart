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
                      style: titleSmallStyle.copyWith(fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 12),
                  Text(
                      "Average Time          ${statsController.averageTime}",
                      style: bodyMediumStyle.copyWith(color: Colors.black54)
                  ),
                  const SizedBox(height: 8),
                  Text(
                      "Average Questions     ${statsController.averageQuestions}",
                      style: bodyMediumStyle.copyWith(color: Colors.black54)
                  ),
                  const SizedBox(height: 8),
                  Text(
                      "Quiz Attempts         ${statsController.totalQuizAttempts}",
                      style: bodyMediumStyle.copyWith(color: Colors.black54)
                  ),
                  const SizedBox(height: 4),
                  Text(
                      "Subjects Attempted    ${statsController.subjectsAttempted}",
                      style: bodyMediumStyle.copyWith(color: Colors.black54)
                  ),
                ],
              ),
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
                    valueColor: const AlwaysStoppedAnimation<Color>(lightSkyBlue),
                  ),
                ),
                Text(
                    percentage,
                    style: bodyMediumStyle.copyWith(
                        color: lightSkyBlue,
                        fontSize: 22,
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

// Alternative version with more compact layout
// class QuizRateCardCompact extends StatelessWidget {
//   const QuizRateCardCompact({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final statsController = Get.find<StatsController>();
//
//     return Obx(() {
//       final percentage = statsController.overallProgressPercentage;
//       final progressValue = statsController.progressValue;
//
//       return Container(
//         padding: const EdgeInsets.all(16),
//         decoration: roundedDecoration,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                     "Quiz Rate",
//                     style: titleSmallStyle.copyWith(fontWeight: FontWeight.bold)
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                     "Average Time          ${statsController.averageTime}",
//                     style: bodyMediumStyle.copyWith(color: Colors.black54)
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                     "Average Questions     ${statsController.averageQuestions}",
//                     style: bodyMediumStyle.copyWith(color: Colors.black54)
//                 ),
//               ],
//             ),
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   height: 80,
//                   width: 80,
//                   child: CircularProgressIndicator(
//                     value: progressValue,
//                     strokeWidth: 6,
//                     backgroundColor: Colors.grey.shade200,
//                     valueColor: const AlwaysStoppedAnimation<Color>(lightSkyBlue),
//                   ),
//                 ),
//                 Text(
//                     percentage,
//                     style: bodyMediumStyle.copyWith(
//                         color: lightSkyBlue,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold
//                     )
//                 ),
//               ],
//             )
//           ],
//         ),
//       );
//     });
//   }
// }