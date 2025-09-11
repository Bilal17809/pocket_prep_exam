import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';

import '../../../data/models/question_model.dart';
import '../control/questions_controller.dart';
import 'options_card.dart';

class QuizCard extends StatelessWidget {
  final Question question;
  final int index;
  const QuizCard({super.key, required this.question, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionController>();

    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: roundedDecoration.copyWith(color: kWhite),
      child: Stack(
        children: [

          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.cancel_outlined, size: 36),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Icon(Icons.book_online_outlined),
                      const SizedBox(height: 6),
                      Text(
                        "Question ${index + 1} / ${controller.questions.length}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Question Text
                Text(
                  question.questionText,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 20),

                // Options
                ...List.generate(
                  question.options.length,
                      (i) => OptionsCard(
                    questionIndex: index,
                    optionIndex: i,
                    option: question.options[i],
                    correctAnswer: question.correctAnswer,
                  ),
                ),

                const SizedBox(height: 10),

                // Show Explanation Button and Content
                Obx(() {
                  final selected = controller.selectedOptions[index];
                  final showExp = controller.showExplanation[index] ?? false;

                  if (selected != null) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () => controller.toggleExplanation(index),
                            child: Text(
                              showExp ? "Hide Explanation" : "Show Explanation",
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          if (showExp) ...[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.lightGreen.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Correct answer: ${question.correctAnswer}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(question.explanation),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Reference: ${question.reference}",
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
