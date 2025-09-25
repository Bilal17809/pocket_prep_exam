
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';

class SubjectStatisticsCard extends StatelessWidget {
  final String title;
  final String percentage;
  final int quizTimes;
  final String practiceTime;
  final int mistakes;
  final String progress;

  const SubjectStatisticsCard({
    super.key,
    this.title = "Airway, Respiration & Ventilation",
    this.percentage = "0%",
    this.quizTimes = 0,
    this.practiceTime = "00:00",
    this.mistakes = 0,
    this.progress = "0/160 items",
  });

  @override
  Widget build(BuildContext context) {
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
                  title,
                  style: bodyLargeStyle.copyWith(color: greyColor,fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
              ),
              Text(
                percentage,
                style: bodyLargeStyle
              )
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: 0,
            backgroundColor: Colors.grey.shade200,
            color: lightSkyBlue,
            minHeight: 6,
          ),

          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 2.2,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _StatItem(value: "$quizTimes",label: "Quiz times"),
              _StatItem(value:  progress, label: "Answer progress"),
              _StatItem(value:  practiceTime,label:  "Total practice time"),
              _StatItem(value:  "$mistakes",label:  "Remaining mistakes"),
            ],
          ),
        ],
      ),
    );
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
