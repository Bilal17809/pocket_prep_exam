import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/constant/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/main_appbar/main_appbar.dart';
import 'package:pocket_prep_exam/pages/practice/controller/practice_controller.dart';
import 'package:pocket_prep_exam/pages/practice/widgets/statscard.dart';
import 'package:pocket_prep_exam/pages/practice/widgets/subject_list.dart';
import 'package:pocket_prep_exam/pages/quiz_view_second/controller/quiz_controller.dart';
import '../widgets/question_progress.dart';

class PracticeView extends StatelessWidget {
  final QuizResult? result;
  const PracticeView({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    final practiceController = Get.find<PracticeController>();

    return Scaffold(
      backgroundColor: kWhiteF7,
      appBar: MainAppBar(title: "Practice", subtitle: ""),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              result != null
                  ? _buildQuestionProgress(result!)
                  : Obx(() {
                final quizResult = practiceController.savedResult.value;
                if (quizResult == null) {
                  return _buildQuestionProgress(null);
                }
                return _buildQuestionProgress(quizResult);
              }),
              const SizedBox(height: 10),
              const StatsCard(text: "Return to last test"),
              const SizedBox(height: 10),
              Text(
                "Practice By Subject",
                style: context.textTheme.bodyMedium!.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const SubjectList(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildQuestionProgress(QuizResult? quizResult) {
    final int correct = quizResult?.totalCorrect ?? 0;
    final int skipped = quizResult?.totalSkipped ?? 0;
    final int totalTime = quizResult?.selectedQuizTime ?? 0;
    final int totalQuestions = quizResult?.totalQuestions ?? (correct + skipped);
    return QuestionProgress(
      correct: correct,
      skipped: skipped,
      totalTime: totalTime,
      totalQuestions: totalQuestions,
    );
  }
}