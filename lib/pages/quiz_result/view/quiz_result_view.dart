import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/dashboard/view/dashboard_view.dart';
import 'package:pocket_prep_exam/pages/study/view/study_view.dart';
import '../../../services/questions_services.dart';
import '/core/common/common_button.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_styles.dart';
import '/pages/questions/control/questions_controller.dart';
import '/pages/questions/view/questions_view.dart';
import '/pages/quiz_result/controller/quiz_result_controller.dart';
import '/pages/quiz_result/widgets/quizzes_result_tabview.dart';
import '/pages/stats/widgets/progress_gauge.dart';
import '/pages/stats/widgets/stat_card.dart';
import '/data/models/question_model.dart';
import '/core/routes/routes_name.dart';
import '../widgets/quiz_filtered_tab.dart';

class QuizResultView extends StatelessWidget {
  final Map<String, dynamic>? quizResults;
  final List<Question> quizQuestions;

  const QuizResultView({
    super.key,
    this.quizResults,
    required this.quizQuestions,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(QuizResultController());

    final safeResults = quizResults ?? {};
    final totalQuestions = (safeResults['totalQuestions'] ?? 0) as int;
    final correctAnswers = (safeResults['correct'] ?? 0) as int;
    final incorrectAnswers = (safeResults['incorrect'] ?? 0) as int;
    final answeredQuestions = (safeResults['answered'] ?? 0) as int;
    final fixedCorrect = correctAnswers.clamp(0, totalQuestions);
    final fixedIncorrect =
    incorrectAnswers.clamp(0, totalQuestions - fixedCorrect);
    final flaggedQuestions =
        (safeResults['flagged'] as List?)?.length ?? 0;
    final percentage =
    totalQuestions > 0 ? (fixedCorrect / totalQuestions) * 100 : 0.0;
    final timeTaken = safeResults['timeTaken'] ?? '0m';
    final labels = ["All", "Flagged", "Incorrect", "Correct"];

    final counts = [
      answeredQuestions,
      flaggedQuestions,
      fixedIncorrect,
      fixedCorrect,
    ];
    return WillPopScope(
      onWillPop: () async {
        Get.find<QuestionController>().resetController();
        Get.offAll(() =>  DashboardView());
        return false;
      },
      child: SafeArea(
        child: DefaultTabController(
          length: labels.length,
          child: Scaffold(
            backgroundColor: kWhiteF7,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _buildHeader(
                    context: context,
                    totalQuestions: totalQuestions,
                    answeredQuestions: answeredQuestions,
                    correctAnswers: fixedCorrect,
                    timeTaken: timeTaken,
                    percentage: percentage,
                  ),
                ),
                QuizResultAppBar(
                  labels: labels,
                  counts: counts,
                ),
              ],
              body: QuizResultTabView(
                quizResults: safeResults,
                quizQuestions: quizQuestions,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader({
    required BuildContext context,
    required int totalQuestions,
    required int answeredQuestions,
    required int correctAnswers,
    required String timeTaken,
    required double percentage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 28),
        Image.asset("images/exam.png", height: 40),
        const SizedBox(height: 12),
        Text(
          "Quick 10 Quiz Results",
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            decoration: roundedDecoration.copyWith(),
            child: Column(
              children: [
                const SizedBox(height: 16),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: percentage / 100),
                  duration: const Duration(seconds: 4),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return ProgressGauge(
                        progress: value, color: kBlack, size: 270);
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          title: "$correctAnswers/$totalQuestions",
                          subtitle: "Answer Correctly",
                          statView: false,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          title: timeTaken,
                          subtitle: "Quiz Time",
                          statView: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CommonButton(
            title: "Retake Quiz",
            onTap: () async {
              final isTime = Get.find<QuestionController>().isTimedQuiz.value;
              final isTimeQMin =  Get.find<QuestionController>().timedQuizDuration;
              Get.find<QuestionController>().resetController(isRetake: true);
              await Get.off(() => QuizzesView(
                allQuestion: quizQuestions,
                fromRetake: true,
                isTimedQuiz: isTime,
                timedQuizMinutes: isTimeQMin,
              ));
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
