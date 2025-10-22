import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ad_manager/banner_ads.dart';
import '/core/common/common_button.dart';
import '/core/theme/app_colors.dart';
import '/pages/edite_subjects/controller/edite_subject_controller.dart';
import '/pages/edite_subjects/widgets/subjects_list.dart';

class SubjectsEditeView extends StatelessWidget {
  const SubjectsEditeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditeSubjectController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kWhiteF7,
        title: Column(
          children: [
            Icon(Icons.edgesensor_low_sharp, size: 24),
            Text(
              "Edite Subjects",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: kWhiteF7,
      body: Obx(() {
        return Column(
          children: [
            SubjectsList(),
            SizedBox(height: 10),
            Text(
              "${controller.questionPool.length} questions",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            !controller.hasSelectionChanged.value
                ? HideCommonButton(title: "Save Subject")
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CommonButton(
                    title: "Save Subjects",
                    onTap: () {
                      controller.saveSelectedSubjectsForExam();
                      controller.hasSelectionChanged.value = false;
                      Get.back();
                      // Utils.showSuccess("Subjects saved successfully", "Saved!");
                    },
                  ),
                ),
          ],
        );
      }),
      bottomNavigationBar: BannerAdWidget(),
    );
  }
}
