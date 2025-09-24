import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/constant/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';

import '../widgets/dificuty_selector.dart';

class QuizSetupView extends StatelessWidget {
  const QuizSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteF7,
      appBar: AppBar(
        backgroundColor: kWhiteF7,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quiz", style: titleMediumStyle),
            Text(
              "Set up your quiz preferences",
              style: titleSmallStyle.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                height: 60,
                decoration: roundedDecoration,
                child: Center(
                  child: Text(
                    "ANIMALS",
                    style: titleMediumStyle.copyWith(color: lightSkyBlue),
                    maxLines: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const _SectionTitle(title: "Select Difficulty"),
            const SizedBox(height: 10),
            DifficultySelector()
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: titleMediumStyle.copyWith(fontSize: 28));
  }
}
