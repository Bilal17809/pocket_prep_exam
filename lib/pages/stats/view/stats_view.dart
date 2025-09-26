import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/stats/controller/stats_controller.dart';
import '../../practice/controller/practice_controller.dart';
import '../widgets/quizrate_card.dart';
import '../widgets/subject_stattics_card.dart';
import 'package:pocket_prep_exam/data/models/models.dart'; // Subject model ke liye

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final statsController = Get.find<StatsController>();
    final practiceController = Get.find<PracticeController>();

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
      body: Obx(() {
        final exam = practiceController.selectExam.value;

        if (practiceController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (exam == null || exam.subjects.isEmpty) {
          return const Center(child: Text("No subjects available"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
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
              Expanded(
                child: ListView.builder(
                  itemCount: exam.subjects.length,
                  itemBuilder: (context, index) {
                    final subject = exam.subjects[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SubjectStatisticsCard(subject: subject),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

