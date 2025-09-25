import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import 'package:pocket_prep_exam/pages/quiz_view_second/controller/quiz_controller.dart';
import '../../quiz_setup/controller/quiz_setup_controller.dart';
import '/data/models/question_model.dart';

import 'options_card.dart';

class SecondQuizCard extends StatelessWidget {
  final Question question;
  final int index;

  const SecondQuizCard({
    super.key,
    required this.question,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<QuizController>();
    final setupController = Get.find<QuizSetupController>();

    return Container(
      width: double.infinity,
      decoration: roundedDecoration.copyWith(color: kWhite,borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Icon(Icons.book_online_outlined),
                      const SizedBox(height: 6),
                      Text(
                        "Question ${index + 1} / ${setupController.selectedQuestions.value}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  question.questionText,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Options List
                Obx(() {
                  final bool showExp = controller.showExplanation[index] ?? false;
                  return Column(
                    children: List.generate(
                      question.options.length,
                          (i) => OptionsCard(
                        questionIndex: index,
                        optionIndex: i,
                        option: question.options[i],
                        correctAnswer: question.correctAnswer,
                        explanation: question.explanation,
                        reference: question.reference,
                            showExp: showExp,
                        // timeLimit: setupController.selectedTimeLimit.value,
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
