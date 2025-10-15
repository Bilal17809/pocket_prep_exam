
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
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
   OptionsCard({
    super.key,
    required this.showExp,
    required this.questionIndex,
    required this.optionIndex,
    required this.option,
    required this.correctAnswer,
    required this.explanation,
    required this.reference,
  });

  final AudioPlayer _player = AudioPlayer();
  final FlutterTts _tts = FlutterTts();
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
            ? ()async {
          controller.selectOption(
            questionIndex,
            optionIndex,
            option,
            correctAnswer,
          );
//           String optionPrefix = option.trim().isNotEmpty
//               ? option.trim().substring(0, 1).toUpperCase()
//               : '';
//           String correctPrefix = correctAnswer.trim().isNotEmpty
//               ? correctAnswer.trim().substring(0, 1).toUpperCase()
//               : '';
//           bool isCorrect = optionPrefix == correctPrefix;
//
// // If correct, speak full option (prefix + text)
//           if (isCorrect) {
//             await _tts.setLanguage("en-US");
//             await _tts.setSpeechRate(0.9);
//             await _tts.speak("Correct answer is option $option");
//           }
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
            Text(
            option,
            style: TextStyle(fontSize: 16, color: textColor,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
            ),
          ),
              if (selectedOptionIndex != null && isCorrectOption) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => controller.toggleExplanation(questionIndex),
                  child: Text(
                    showExp ? "Hide Explanation" : "Show Explanation",
                    style: const TextStyle(color: Colors.blue, fontSize: 14,fontWeight: FontWeight.bold),
                  ),
                ),
                if (showExp) ...[
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.green.shade300, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "✅ Correct Answer: $correctAnswer",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        CommonLabelValueText(
                          label: "📖 Explanation: ",
                          value: explanation,
                          labelColor: Colors.orange.shade700,
                          valueColor: Colors.black87,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.green.shade200, width: 1),
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
