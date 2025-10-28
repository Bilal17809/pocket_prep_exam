import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ad_manager/interstitial_ads.dart';
import '/pages/edite_subjects/controller/edite_subject_controller.dart';
import '/pages/edite_subjects/view/subjects_edite_view.dart';
import '/pages/exam_settings/controller/exam_setting_controller.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_theme.dart';
import '../../setting/widgets/text_button.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExamSettingController>();
    final subjectController = Get.find<EditeSubjectController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: AppTheme.card.copyWith(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Obx(() {
          final selectedSubjects = subjectController.selectedSubjectIds.length;
          final exam = controller.selectedExam.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subjects",
                      style: context.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kBlack,
                      ),
                    ),
                    InkWell(
                        onTap: (){
                          Get.find<InterstitialAdManager>().checkAndDisplayAd();
                          Get.to(() => const SubjectsEditeView());},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 06),
                        decoration: BoxDecoration(
                          color: lightSkyBlue.withAlpha(40),
                          borderRadius: BorderRadius.circular(20)
                        ),
                          child: ButtonText(title: "Edit",color: lightSkyBlue)),
                    ),
                    // ButtonText(title: "Edit",color: lightSkyBlue, onTap: () => Get.to(() => const SubjectsEditeView()))
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.library_books_rounded,
                      color: Colors.blueAccent,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        exam == null
                            ? "No exam selected"
                            : "$selectedSubjects of ${exam.subjects.length} subjects selected",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent.withOpacity(0.15),
                        Colors.lightBlue.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        selectedSubjects == 0
                            ? Icons.info_outline
                            : Icons.check_circle_outline,
                        color:
                        selectedSubjects == 0 ? Colors.orangeAccent : Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          selectedSubjects == 0
                              ? "You haven’t selected any subjects yet. Choose at least one subject to start your exam."
                              : "You’ve selected $selectedSubjects subject${selectedSubjects > 1 ? 's' : ''}. You can update them anytime before starting the quiz.",
                          style: context.textTheme.bodySmall!.copyWith(
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
