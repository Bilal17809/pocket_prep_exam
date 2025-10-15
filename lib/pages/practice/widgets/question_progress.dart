
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/Utility/utils.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import '/core/common/progress_gauge.dart';


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

        _CustomContainer(
          isTopRounded: true,
          backgroundColor: kWhite,
          padding: const EdgeInsets.all(15),
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
        _CustomContainer(
          isBottomRounded: true,
          backgroundColor: lightSkyBlue,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ShowProgress(value: "$correct", title: "Total Corrects"),
              _ShowProgress(value: "$skipped", title: "Left"),
              _ShowProgress(value: Utils.formatTime(totalTime), title: "Quiz Time"),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShowProgress extends StatelessWidget {
  final String value;
  final String title;
  const _ShowProgress({required this.value, required this.title});

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
            color: kWhite,
          ),
        ),
      ],
    );
  }
}



class _CustomContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final bool isTopRounded;
  final bool isBottomRounded;
  final EdgeInsetsGeometry padding;

  const _CustomContainer({
    required this.child,
    this.backgroundColor = Colors.white,
    this.isTopRounded = false,
    this.isBottomRounded = false,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: isTopRounded ? const Radius.circular(10) : Radius.zero,
          topRight: isTopRounded ? const Radius.circular(10) : Radius.zero,
          bottomLeft: isBottomRounded ? const Radius.circular(10) : Radius.zero,
          bottomRight: isBottomRounded ? const Radius.circular(10) : Radius.zero,
        ),
      ),
      child: child,
    );
  }
}
