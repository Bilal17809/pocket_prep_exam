import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/ad_manager/remove_ads.dart';
import '/core/local_storage/storage_helper.dart';
import '/core/routes/routes_name.dart';
import '/core/theme/theme.dart';
import '/pages/quiz_setup/controller/quiz_setup_controller.dart';
import '/pages/practice/controller/practice_controller.dart';


class SubjectList extends StatelessWidget {
  const SubjectList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PracticeController>();
    final removeAds = Get.find<RemoveAds>();
    return Obx(() {
      final exam = controller.selectExam.value;
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (exam == null || exam.subjects.isEmpty) {
        return const Center(child: Text("No Subject Available"));
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: exam.subjects.length,
        itemBuilder: (context, index) {
          final subject = exam.subjects[index];
          final questions =
          controller.getQuestionCountBySubject(subject.subjectId);
          bool isLocked = false;
          if (!removeAds.isSubscribedGet.value) {
            final attempted =
            StorageService.loadSubjectAttemptCount(subject.subjectId);
            isLocked = attempted >= 5;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              decoration: roundedDecoration,
              child: GestureDetector(
                onTap: isLocked
                    ? null
                    : () {
                  Get.find<QuizSetupController>().setSubject(subject);
                  Get.toNamed(RoutesName.quizSetup);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: lightSkyBlue.withAlpha(40),
                    child: isLocked
                        ? const Icon(Icons.lock, color: Colors.red)
                        : Text(
                      "${index + 1}",
                      style: context.textTheme.titleMedium!.copyWith(
                        color: kBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    subject.subjectName,
                    style: bodyLargeStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Questions: $questions${isLocked ? " (Locked)" : ""}",
                    style: bodyMediumStyle.copyWith(
                      color: isLocked ? Colors.red : Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

}

