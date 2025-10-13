import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/Utility/utils.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/stats/widgets/progress_gauge.dart';

class QuestionProgress extends StatelessWidget {
  final int correct;
  final int skipped;
  final int totalTime;
  final int totalQuestions;

  const QuestionProgress({
    super.key,
    required this.correct,
    required this.skipped,
    required this.totalTime,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (totalQuestions > 0) ? correct / totalQuestions : 0.0;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Question Practice Progress",
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: progress),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) {
                    return ProgressGauge(
                      progress: value,
                      color: kBlack,
                      size: 230,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: lightSkyBlue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ShowProgress(value: "$correct", title: "Total Corrects"),
                _ShowProgress(value: "$skipped", title: "Left"),
                _ShowProgress(value: Utils.formatTime(totalTime), title: "Quiz Time"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ShowProgress extends StatelessWidget {
  final String value;
  final String title;
  const _ShowProgress({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: kWhite,
          ),
        ),
        Text(
          title,
          style: context.textTheme.bodyMedium!.copyWith(
            color: kBlack,
          ),
        ),
      ],
    );
  }
}
