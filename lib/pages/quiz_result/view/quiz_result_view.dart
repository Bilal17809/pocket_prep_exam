import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/common_button.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/data/models/exams_and_subject.dart';
import 'package:pocket_prep_exam/pages/questions/control/questions_controller.dart';
import 'package:pocket_prep_exam/pages/questions/view/questions_view.dart';
import 'package:pocket_prep_exam/pages/quiz_result/controller/quiz_result_controller.dart';
import 'package:pocket_prep_exam/pages/quiz_result/widgets/quizzes_result_tabview.dart';
import 'package:pocket_prep_exam/pages/stats/widgets/progress_gauge.dart';
import 'package:pocket_prep_exam/pages/stats/widgets/stat_card.dart';
import '../widgets/quiz_filtered_tab.dart';

class QuizResultView extends StatelessWidget {
  final Subject subject;
  final Map<String, dynamic>? quizResults;

  const QuizResultView({
    super.key,
    required this.subject,
    this.quizResults,
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
    final fixedIncorrect = incorrectAnswers.clamp(0, totalQuestions - fixedCorrect);
    final flaggedQuestions = (safeResults['flagged'] as List?)?.length ?? 0;
    final percentage = totalQuestions > 0 ? (fixedCorrect / totalQuestions) * 100 : 0.0;
    final timeTaken = safeResults['timeTaken'] ?? '0m';
    final labels = ["All", "Flagged", "Incorrect", "Correct"];

    final counts = [
      answeredQuestions,
      flaggedQuestions,
      fixedIncorrect,
      fixedCorrect,
    ];

    return SafeArea(
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
              subject: subject,
              quizResults: safeResults,
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
        const SizedBox(height: 20),

       TweenAnimationBuilder<double>(tween: Tween<double>(begin: 0,end:  percentage / 100),
           duration: Duration(seconds: 4),
            curve: Curves.easeOut,
            builder:(context,value,child){
         return ProgressGauge(progress: value,color: kBlack,size: 270);
            }
       ),


        const SizedBox(height: 20),

        // Stats row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child:StatCard(
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
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CommonButton(
            title: "Retake Quiz",
            onTap: () async {
              if (Get.isRegistered<QuestionController>()) {
                Get.delete<QuestionController>();
              }
              await Get.to(() => QuizzesView(subject: subject));
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}