import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import 'package:pocket_prep_exam/pages/quiz_setup/controller/quiz_setup_controller.dart';

class QuestionCountSelector extends StatelessWidget {
  const QuestionCountSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizSetupController>();
    return Obx(() {
      final options = controller.questionOptions;
      return Padding(
        padding: const EdgeInsets.only(right: 80),
        child: Row(
          children: options.map((count) {
            final isSelected = controller.selectedQuestions.value == count;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: OptionChip(
                  label: "$count",
                  isSelected: isSelected,
                  onTap: () => controller.setQuestions(count),
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

  const OptionChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
