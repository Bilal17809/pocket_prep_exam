
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/app_divider.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_styles.dart';
import 'game_button.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                height: 68,
                width: 68,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProgressText(title: "Today's questions progress", value: "0/70"),
                    SizedBox(height: 04),
                    _LProgressIndicator(value: 0.6),
                    const SizedBox(height: 16),
                    _ProgressText(title: "Today's practice minutes", value: "0/30"),
                    SizedBox(height: 04),
                    _LProgressIndicator(value: 0.2)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text("🙂 Today's streak is waiting",style: context.textTheme.titleMedium!.copyWith(color: greyColor.withAlpha(200)),),
          const SizedBox(height: 10),
          GameButton()
          // UpgradeButton()
        ],
      ),
    );
  }
}

class _LProgressIndicator extends StatelessWidget {
  final double value;
  const _LProgressIndicator({super.key,required this.value});

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 6,
        backgroundColor: Colors.grey.shade300,
        color:lightSkyBlue,
      ),
    );
  }
}

class _ProgressText extends StatelessWidget {
  final String title;
  final String value;
  const _ProgressText({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value)
      ],
    );
  }
}

