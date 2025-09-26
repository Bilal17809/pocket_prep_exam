import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/Utility/utils.dart';
import 'package:pocket_prep_exam/core/common/common_button.dart';
import 'package:pocket_prep_exam/core/common/custom_dialog.dart';
import 'package:pocket_prep_exam/core/routes/routes_name.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/dashboard/view/dashboard_view.dart';
import 'package:pocket_prep_exam/pages/practice/view/practice_view.dart';
import 'package:pocket_prep_exam/pages/quiz_view_second/controller/quiz_controller.dart';
import '../../../data/models/exams_and_subject.dart';
import '../../dashboard/control/dashboard_controller.dart';
import '../../quiz_setup/controller/quiz_setup_controller.dart';
import '../../stats/controller/stats_controller.dart';
import '../widgets/quiz_card.dart';
import '../widgets/quiz_stats_handler.dart';

class SecondQuizView extends StatelessWidget {
  SecondQuizView({super.key});
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return QuizStateHandler(pageController: _pageController);
  }
}



class QuizScaffold extends StatelessWidget {
  final QuizController quizController;
  final PageController pageController;
  const QuizScaffold({
    super.key,
    required this.quizController,
    required this.pageController,
  });
  @override
  Widget build(BuildContext context) {
    final questions = quizController.questions;

    return WillPopScope(
      onWillPop: () async {
        return await Utils.leaveBottomSheet(context);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,color: kWhite,),
              onPressed: () async {
                bool shouldLeave = await Utils.leaveBottomSheet(context);
                if (shouldLeave) Get.back();
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  final currentIndex = quizController.currentPage.value;
                  final time = quizController.remainingTime[currentIndex] ?? 0;
                  return Text(
                    "Time Left: ${time}s",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  );
                }),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: questions.length,
                  onPageChanged: (index) {
                    quizController.currentPage.value = index;
                    quizController.startTimerForQuestion(index);
                    if (index == quizController.questions.length - 1) {
                      quizController.isSubmitVisible.value = true;
                    } else {
                      quizController.isSubmitVisible.value = false;
                    }

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
              Obx(() {
                return quizController.isSubmitVisible.value
                    ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 26),
                  child: CommonButton(
                    title: "Submit Quiz",
                      onTap: () {
                        CustomDialog.show(
                          title: "Submit Quiz?",
                          message: "",
                          positiveButtonText: "Submit",
                          onPositiveTap: () {
                            final result = quizController.generateResult();
                            final subject = Get.find<QuizSetupController>().selectedSubject.value;
                            if (subject != null) {
                              Get.find<StatsController>().saveResult(subject, result);
                            }
                            final dashboardController = Get.find<DashboardController>();
                            dashboardController.setIndex.value = 2;
                            Get.offNamed(
                              RoutesName.dashBoard,
                              arguments: result,
                            );
                          },
                          negativeButtonText: "Cancel",
                          onNegativeTap: () => Get.back(),
                        );
                      }

                  ),
                )
                    : const SizedBox.shrink();
              }),
              _NavigationRow(
                controller: quizController,
                pageController: pageController,
              )
            ],
          ),
        ),
      ),
    );
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _NavButton(
          icon: Icons.arrow_back_ios,
          onTap: () {
            if (pageController.hasClients &&
                pageController.page!.toInt() > 0) {
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
