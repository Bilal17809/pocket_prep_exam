import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/controller/edite_subject_controller.dart';
import 'package:pocket_prep_exam/pages/premium/view/premium_screen.dart';
import 'package:pocket_prep_exam/pages/quiz_setup/controller/quiz_setup_controller.dart';

import '../../../ad_manager/remove_ads.dart';

class QuestionCountSelector extends StatelessWidget {
  const QuestionCountSelector({super.key});
  @override
  Widget build(BuildContext context) {
    final setupController = Get.find<QuizSetupController>();
    final subController = Get.find<RemoveAds>();

    return Obx(() {
      final options = setupController.questionOptions;
      final isSubscribed = subController.isSubscribedGet.value;

      return Padding(
        padding: const EdgeInsets.only(right: 80),
        child: Row(
          children: options.map((count) {
            final isSelected = setupController.selectedQuestions.value == count;
            final isLocked = !isSubscribed && count != 5;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: OptionChip(
                  label: "$count",
                  isSelected: isSelected,
                  isLocked: isLocked,
                  onTap: isLocked
                      ? () => Get.find<EditeSubjectController>().showDialog(onUpgrade: (){
                    Get.back();
                        Get.to(() => PremiumScreen());
                  })
                      : () => setupController.setQuestions(count),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}

class OptionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isLocked;

  const OptionChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isLocked ? 0.5 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: quizSetupContainer.copyWith(
            color: isSelected ? lightSkyBlue : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? lightSkyBlue : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: isLocked
              ? Icon(Icons.lock) :Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          )
        ),
      ),
    );
  }
}

