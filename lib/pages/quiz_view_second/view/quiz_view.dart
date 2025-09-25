import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/common_button.dart';
import 'package:pocket_prep_exam/core/common/custom_dialog.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/quiz_view_second/controller/quiz_controller.dart';
import '../widgets/quiz_card.dart';

class SecondQuizView extends StatelessWidget {
 SecondQuizView({super.key});

 final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final quizController =  Get.find<QuizController>();
    return Obx(() {
      final questions = quizController.questions;
      if (questions.isEmpty) {
        return const Scaffold(
          body: Center(child: Text("No questions available")),
        );
      }
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Obx(() {
                      final currentIndex = quizController.currentPage.value;
                      final time = quizController.remainingTime[currentIndex] ?? 0;
                      return Text(
                        "Time Left: ${time}s",
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      );
                    }),
                  ],
                ),
              )
            ],
            // title:
            // centerTitle: true,
          ),
          body: Column(
            children: [
              // const SizedBox(height: 10),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: questions.length,
                  onPageChanged: (index) {
                    quizController.currentPage.value = index;
                    quizController.startTimerForQuestion(index);
                  },
                  itemBuilder: (context, index) {
                    final q = questions[index];
                    return SecondQuizCard(
                      question: q,
                      index: index,
                    );
                  },
                ),
              ),

              if (quizController.isSubmitVisible.value)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 26),
                  child: CommonButton(
                    title: "Submit Quiz",
                    onTap: () {
                      final quizResults =
                      // quizController.calculateQuizResults();
                      CustomDialog.show(
                        title: "Submit Quiz?",
                        message:"",
                        // "You've answered ${quizResults['answered']} of ${quizResults['totalQuestions']} questions. "
                        //     "If you submit, you'll only be scored on the ${quizResults['answered']} question you answered.",
                        positiveButtonText: "Submit",
                        onPositiveTap: () {
                          // Get.off(() => QuizResultView(
                          //   quizQuestions: quizController.questions,
                          //   // quizResults: quizResults,
                          // ));
                        },
                        negativeButtonText: "Cancel",
                        onNegativeTap: () => Get.back(),
                      );
                    },
                  ),
                ),
              _NavigationRow(
                controller: quizController,
                pageController: _pageController,
              )
            ],
          ),
        ),
      );
    });
  }
}

class _NavigationRow extends StatelessWidget {
  final QuizController controller;
  final PageController pageController;

  const _NavigationRow({
    super.key,
    required this.controller,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentIndex = controller.currentPage.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavButton(
            icon: Icons.arrow_back_ios,
            onTap: () {
              if (pageController.hasClients && pageController.page!.toInt() > 0) {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            },
          ),
          _NavButton(
            icon: Icons.arrow_forward_ios,
            onTap: () {
              if (pageController.hasClients &&
                  pageController.page!.toInt() <
                      controller.questions.length - 1) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            },
          ),
        ],
      );
    });
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          size: 34,
          color: kWhite,
        ),
      ),
    );
  }
}
