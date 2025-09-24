import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';


class QuizRateCard extends StatelessWidget {
  final String averageTime;
  final String averageQuestions;
  final String percentage;

  const QuizRateCard({
    super.key,
    this.averageTime = "00:00",
    this.averageQuestions = "0.0",
    this.percentage = "20%",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: roundedDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quiz Rate",
                style:titleSmallStyle.copyWith(fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 12),
              Text(
                "Average Time          $averageTime",
                style:bodyMediumStyle.copyWith(color: Colors.black54)
              ),
              const SizedBox(height: 8),
              Text(
                "Average Questions     $averageQuestions",
                style: bodyMediumStyle.copyWith(color: Colors.black54)
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  value: 0.2,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(lightSkyBlue),
                ),
              ),
              Text(
                percentage,
                style: bodyMediumStyle.copyWith(color: lightSkyBlue,fontSize: 22,fontWeight: FontWeight.bold)
              ),
            ],
          )
        ],
      ),
    );
  }
}
