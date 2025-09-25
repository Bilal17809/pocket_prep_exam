

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import 'package:pocket_prep_exam/pages/quiz_view_second/controller/quiz_controller.dart';
import '/core/common/text_span.dart';

class OptionsCard extends StatelessWidget {
  final int questionIndex;
  final int optionIndex;
  final String option;
  final String correctAnswer;
  final String explanation;
  final String reference;
  final bool showExp;
  const OptionsCard({
    super.key,
    required this.showExp,
    required this.questionIndex,
    required this.optionIndex,
    required this.option,
    required this.correctAnswer,
    required this.explanation,
    required this.reference,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizController>();

    return Obx(() {
      int? selectedOptionIndex = controller.selectedOptions[questionIndex];
      String optionPrefix = option.trim().isNotEmpty
          ? option.trim().substring(0, 1).toUpperCase()
          : '';
      String correctPrefix = correctAnswer.trim().isNotEmpty
          ? correctAnswer.trim().substring(0, 1).toUpperCase()
          : '';
      bool isCorrectOption = optionPrefix == correctPrefix;
      bool isThisOptionSelected = selectedOptionIndex == optionIndex;

      Color borderColor = Colors.grey.shade300;
      Color textColor = kBlack;

      if (selectedOptionIndex != null) {
        if (isCorrectOption) {
          borderColor = Colors.green;
          textColor = Colors.green.shade800;
        } else if (isThisOptionSelected) {
          borderColor = Colors.red;
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
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: roundedDecoration.copyWith(
            color: bgColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(option, style: TextStyle(fontSize: 14, color: textColor)),

              if (selectedOptionIndex != null && isCorrectOption) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () =>
                      controller.toggleExplanation(questionIndex),
                  child: Text(
                    showExp ? "Hide Explanation" : "Show Explanation",
                    style: const TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),

                if (showExp) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextSpan(
                          labelOne: "Correct Answer: $correctAnswer",
                          labelTwo: "",
                          textColorTwo: kWhite,
                          backgroundColorOne: Colors.green,
                        ),
                        const SizedBox(height: 8),
                        CommonTextSpan(
                          labelOne: "Explanation: ",
                          labelTwo: explanation,
                          textColorOne: Colors.green.shade800,
                          textColorTwo: Colors.blue,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: roundedDecoration.copyWith(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CommonTextSpan(
                            labelOne: "Reference: ",
                            labelTwo: reference,
                            fontStyle: FontStyle.italic,
                            textColorOne: greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      );
    });
  }
}
