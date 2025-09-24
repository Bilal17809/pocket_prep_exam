import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/stats/widgets/progress_gauge.dart';

class QuestionProgress extends StatelessWidget {
  final double? percentage;
  const QuestionProgress({super.key, this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
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
              SizedBox(height: 20),
              Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 0 / 100),
                  duration: Duration(seconds: 2),
                  builder: (context, value, child) {
                    return ProgressGauge(
                      progress: 0.10,
                      color: kBlack,
                      size: 230,
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 68,
          decoration: BoxDecoration(
            color: lightSkyBlue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ShowProgress(value: "0", title: "Answered"),
                    _ShowProgress(value: "60", title: "Left"),
                    _ShowProgress(value: "00:00", title: "Quiz Time"),
                  ],
                ),
              ),
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
  const _ShowProgress({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: kWhite
          ),
        ),
        Text(title, style: context.textTheme.bodyMedium!.copyWith(
          color: kBlack
        )),
      ],
    );
  }
}
