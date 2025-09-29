import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/practice/widgets/subject_list.dart';
import 'package:pocket_prep_exam/pages/stats/controller/stats_controller.dart';
import '../../practice/controller/practice_controller.dart';
import '../widgets/quizrate_card.dart';
import '../widgets/sub_statistic_list.dart';
import '../widgets/subject_stattics_card.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final statsController = Get.find<StatsController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteF7,
        automaticallyImplyLeading: false,
        title: Text(
          "Stats",
          style: context.textTheme.bodyLarge!.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: kWhiteF7,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuizRateCard(),
              const SizedBox(height: 20),
              Text(
                "Subject Statistics",
                style: context.textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SubStatisticList(),
            ],
          ),
        ),
      ),
    );
  }
}
