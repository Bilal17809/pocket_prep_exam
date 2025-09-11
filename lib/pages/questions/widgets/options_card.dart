import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../control/questions_controller.dart';

class OptionsCard extends StatelessWidget {
  final int questionIndex;
  final int optionIndex;
  final String option;
  final String correctAnswer;

  const OptionsCard({
    super.key,
    required this.questionIndex,
    required this.optionIndex,
    required this.option,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionController>();

    return Obx(() {
      int? selectedOptionIndex = controller.selectedOptions[questionIndex];
      bool isCorrectOption = option.trim().toLowerCase() == correctAnswer.trim().toLowerCase();
      bool isThisOptionSelectedByUser = selectedOptionIndex == optionIndex;

      Color borderColor = Colors.grey.shade300;
      Color bgColor = Colors.white;
      Color textColor = Colors.black;

      if (selectedOptionIndex != null) {
        if (isCorrectOption) {
          borderColor = Colors.green;
          bgColor = Colors.green.shade100;
          textColor = Colors.green.shade800;
        } else if (isThisOptionSelectedByUser) {
          borderColor = Colors.red;
          bgColor = Colors.red.shade100;
          textColor = Colors.red.shade800;
        }
      }

      return GestureDetector(
        onTap: selectedOptionIndex == null
            ? () {
          controller.selectOption(
            questionIndex,
            optionIndex,
            option,
            correctAnswer,
          );
        }
            : null,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Text(
            option,
            style: TextStyle(fontSize: 16, color: textColor),
          ),
        ),
      );
    });
  }
}