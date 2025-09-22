import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/controller/edite_subject_controller.dart';
import '/data/models/question_model.dart';
import '../control/questions_controller.dart';
import 'options_card.dart';

class QuizCard extends StatelessWidget {
  final Question question;
  final int index;
  final bool reviewMode;
  const QuizCard({super.key, required this.question, required this.index,this.reviewMode = false, required String reviewType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionController>();
     final controlle = Get.find<EditeSubjectController>();
    return Container(
      width: double.infinity,
      decoration: roundedDecoration.copyWith(color: kWhite),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Icon(Icons.cancel_outlined, size: 36),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      if(!reviewMode)
                      const Icon(Icons.book_online_outlined),
                      const SizedBox(height: 6),
                      if(!reviewMode)
                      Text(
                        "Question ${index + 1} / ${controller.questions.length}",
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
                  // textAlign: TextAlign.center,

                ),
                const SizedBox(height: 20),
                Obx(() {
                  final bool currentShowExplanationState = controller.showExplanation[index] ?? false;
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
                        showExplanationToggle: currentShowExplanationState,
                            reviewMode: reviewMode,
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