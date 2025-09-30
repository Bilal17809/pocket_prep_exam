import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';

class EmptyStatisticsCard extends StatelessWidget {
  final String title;
  const EmptyStatisticsCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: roundedDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: bodyLargeStyle.copyWith(
                    color: greyColor,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
              ),
              Text("0.0%", style: bodyLargeStyle.copyWith(color: lightSkyBlue,fontSize: 18,fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          // Empty progress bar
          LinearProgressIndicator(
            value: 0,
            backgroundColor: Colors.grey.shade200,
            color: lightSkyBlue,
            minHeight: 6,
          ),
          const SizedBox(height: 16),
          // Placeholder stats
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 2.5,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _StatItem(value: "-", label: "Quiz times"),
              _StatItem(value: "-/- items", label: "Answer progress"),
              _StatItem(value: "-s", label: "Total practice time"),
              _StatItem(value: "-", label: "Remaining mistakes"),
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
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: context.textTheme.bodySmall!.copyWith(
            fontSize: 13,
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}
