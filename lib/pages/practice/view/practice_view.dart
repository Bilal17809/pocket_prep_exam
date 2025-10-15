import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/constant/constant.dart';
import '/core/theme/app_colors.dart';
import '/pages/main_appbar/main_appbar.dart';
import '/pages/practice/controller/practice_controller.dart';
import '/pages/quiz_view_second/controller/quiz_controller.dart';
import '/pages/study/widgets/game_button.dart';
import '/pages/practice/widgets/widgets.dart';

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
              GameButton(),
              // const StatsCard(text: "Return to last test"),
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