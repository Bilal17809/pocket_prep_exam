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
      int correctIndex = "ABCD".indexOf(correctAnswer.toUpperCase());
      bool isCorrectOption = optionIndex == correctIndex;
      bool isThisOptionSelectedByUser = selectedOptionIndex == optionIndex;
      Color borderColor = Colors.grey.shade300;
      Color textColor = Colors.black;
      if (selectedOptionIndex != null) {
        if (isCorrectOption) {
          borderColor = Colors.green;
          textColor = Colors.green.shade800;
        } else if (isThisOptionSelectedByUser) {
          borderColor = Colors.red;
          textColor = Colors.red.shade800;
        }
      }
      return GestureDetector(
        onTap: selectedOptionIndex == null
            ? () {
          print(
              "Selected OptionIndex: $optionIndex  CorrectIndex: $correctIndex  CorrectAnswer: $correctAnswer");
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
            border: Border.all(
              color: borderColor,
              width: isCorrectOption && isThisOptionSelectedByUser ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                option,
                style: TextStyle(fontSize: 14, color: textColor),
              ),
              if (selectedOptionIndex != null && isCorrectOption) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => controller.toggleExplanation(questionIndex),
                  child: Text(
                    showExplanationToggle
                        ? "Hide Explanation"
                        : "Show Explanation",
                    style: const TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
                if (showExplanationToggle) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.green.shade200, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "✅ Correct Answer: $correctAnswer - $option",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CommonLabelValueText(
                          label: "📖 Explanation: ",
                          value: explanation,
                          labelColor: Colors.orange.shade700,
                          valueColor: Colors.black87,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CommonLabelValueText(
                            label: "📚 Reference: ",
                            value: reference,
                            labelColor: Colors.deepPurple,
                            valueColor: Colors.black87,
                            valueStyle: FontStyle.italic,
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
