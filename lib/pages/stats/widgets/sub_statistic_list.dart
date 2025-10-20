
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/stats/controller/stats_controller.dart';
import 'package:pocket_prep_exam/pages/stats/widgets/empty_stat_card.dart';
import 'package:pocket_prep_exam/pages/stats/widgets/subject_stattics_card.dart';

class SubStatisticList extends StatelessWidget {
  const SubStatisticList({super.key});

  @override
  Widget build(BuildContext context) {
    final statsController = Get.find<StatsController>();

    return Obx(() {
      if (statsController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final exam = statsController.selectExam.value;
      if (exam == null || exam.subjects.isEmpty) {
        return const Center(child: Text("No Subject Available"));
      }
      final subjectsWithResult = exam.subjects.where((subject) {
        final result = statsController.latestResultForSubject(subject.subjectId);
        return result != null;
      }).toList().reversed.toList();

      if (subjectsWithResult.isEmpty) {
        return  Center(child: EmptyStatisticsCard(title: "No subjects found"));
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: subjectsWithResult.length,
        itemBuilder: (context, index) {
          final subject = subjectsWithResult[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SubjectStatisticsCard(subject: subject),
          );
        },
      );
    });
  }
}
