// lib/pages/questions/widgets/options_card.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import '/core/common/text_span.dart';
import '../control/questions_controller.dart';


class OptionsCard extends StatelessWidget {
  final int questionIndex;
  final int optionIndex;
  final String option;
  final String correctAnswer;
  final String explanation;
  final String reference;
  final bool showExplanationToggle;
  final bool reviewMode;
  final String reviewType;
  const OptionsCard({
    super.key,
    required this.questionIndex,
    required this.optionIndex,
    required this.option,
    required this.correctAnswer,
    required this.explanation,
    required this.reference,
    required this.showExplanationToggle,
    this.reviewMode = false,
    this.reviewType = 'All',

  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionController>();

    return Obx(() {
      int? selectedOptionIndex = controller.selectedOptions[questionIndex];
      String optionPrefix = '';
      if (option.trim().isNotEmpty) {
        optionPrefix = option.trim().substring(0, 1).toUpperCase();}
      String trimmedCorrectAnswerPrefix = '';
      if (correctAnswer.trim().isNotEmpty) {
        trimmedCorrectAnswerPrefix = correctAnswer.trim().substring(0, 1).toUpperCase();}
      bool isCorrectOption = optionPrefix == trimmedCorrectAnswerPrefix;
      bool isThisOptionSelectedByUser = selectedOptionIndex == optionIndex;


      Color borderColor = Colors.grey.shade300;
      // Color bgColor = Colors.white;
      Color textColor = Colors.black;


      if (selectedOptionIndex != null) {
        if (isCorrectOption) {
          borderColor = Colors.green;
          // bgColor = Colors.green.shade100;
          textColor = Colors.green.shade800;
        } else if (isThisOptionSelectedByUser) {
          borderColor = Colors.red;
          // bgColor = Colors.red.shade100;
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
            borderRadius: BorderRadius.circular(06),
            border: Border.all(color: borderColor, width: isCorrectOption && isThisOptionSelectedByUser ? 2 : 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                option,
                style: TextStyle(fontSize: 14, color: kBlack),
              ),
              if (selectedOptionIndex != null && isCorrectOption) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => controller.toggleExplanation(questionIndex),
                  child: Text(
                    showExplanationToggle ? "Hide Explanation" : "Show Explanation",
                    style: const TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
                if (showExplanationToggle) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextSpan(labelOne: "Correct Answer: $correctAnswer - ${option}",labelTwo: "",
                            textColorTwo:  kWhite,backgroundColorOne: Colors.green),

                        const SizedBox(height: 8),
                        CommonTextSpan(labelOne: "Explanation: ",
                          labelTwo: "$explanation",
                          textColorOne: Colors.green.shade800,
                          textColorTwo: Colors.blue,
                        ),

                        const SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: roundedDecoration.copyWith(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child:  CommonTextSpan(
                            labelOne: "Reference: ",
                            labelTwo: "$reference",
                            fontStyle: FontStyle.italic,
                            textColorOne: greyColor,
                          ),
                        )
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