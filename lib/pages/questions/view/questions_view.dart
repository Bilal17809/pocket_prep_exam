import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/local_storage/storage_helper.dart';
import '/core/Utility/utils.dart';
import '/core/common/common_button.dart';
import '/core/common/loading_container.dart';
import '/data/models/models.dart';
import '/pages/dashboard/view/dashboard_view.dart';
import '/pages/quiz_result/view/quiz_result_view.dart';
import '/pages/study/controller/study_controller.dart';
import '/core/common/custom_dialog.dart';
import '../control/questions_controller.dart';
import '/core/theme/app_colors.dart';
import '/pages/questions/widgets/widgets.dart';


class QuizzesView extends StatelessWidget {
  final bool reviewMode;
  final int? initialPage;
  final String? tabTitle;
  final List<int>? questionIdsToReview;
  final Map<int, int>? selectedOptions;
  final String reviewType;
  final List<Question>? allQuestion;
  final bool isTimedQuiz;
  final int? timedQuizMinutes;
  final bool fromRetake;

  const QuizzesView({
    super.key,
    this.allQuestion,
    this.reviewMode = false,
    this.initialPage,
    this.tabTitle,
    this.questionIdsToReview,
    this.selectedOptions,
    this.reviewType = 'All',
    this.isTimedQuiz = false,
    this.timedQuizMinutes,
    this.fromRetake = false,
  });
  bool get isQuestionOfDayMode =>
      allQuestion != null && allQuestion!.length == 1 && !isTimedQuiz;

  Future<void> _handleBackNavigation(BuildContext context) async {
    final controller = Get.find<QuestionController>();
    if (reviewMode == true) {
      Get.back();
      return;
    }
    final isQuestionOfDay = isQuestionOfDayMode;
    if (controller.selectedOptions.isEmpty) {
      if (fromRetake) {
        Get.offAll(() => DashboardView());
      } else {
        Get.back();
      }
      return;
    }
    if (isQuestionOfDay && controller.selectedOptions.isNotEmpty) {
      Get.offAll(() => DashboardView());
      return;
    }
    final results = controller.calculateQuizResults();
    await Utils.showLeaveQuizDialog(
      isTimedQuiz: controller.isTimedQuiz.value,
      answered: results["answered"],
      totalQuestions: results["totalQuestions"],
      onLeave: () {
        if (fromRetake) {
          Get.back();
          Get.offAll(() => DashboardView());
          controller.resetController();
        } else {
          Get.back();
          Get.back();
        }
      });}
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionController>();
    final PageController pageController = PageController(initialPage: initialPage ?? 0);

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      controller.initQuiz(
        reviewMode: reviewMode,
        questionIdsToReview: questionIdsToReview,
        selectedOptions: selectedOptions,
        allQuestions: allQuestion,
        isTimedQuiz: isTimedQuiz,
        timedQuizMinutes: timedQuizMinutes,
        fromRetake: fromRetake,
      );
      final hasAttempted = StorageService.getFirstAttempt();
      if (!hasAttempted) {
        await StorageService.saveFirstAttempt(true);
      }
    });
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _handleBackNavigation(context);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF1E90FF),
          body: Obx(() {
            if (controller.state.value == QuestionState.loading) {
              return const Center(
                child: LoadingContainer(
                  message: "Loading...",
                  backgroundColor: lightSkyBlue,
                  messageTextColor: kWhite,
                  indicatorColor: kWhite,
                ),
              );
            }
            if (controller.state.value == QuestionState.error) {
              return const Center(child: Text("Error loading questions."));
            }
            final questionsToShow =
                allQuestion ?? (reviewMode ? controller.reviewQuestions : controller.questions);
            if (questionsToShow.isEmpty) {
              return const Center(child: Text("No questions available."));
            }
            return Column(
              children: [
                if (controller.isTimedQuiz.value && !reviewMode)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.timer_outlined, color: Colors.white, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          controller.getTimerDisplay().toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (reviewMode)
                  QuizAppBar(
                    controller: controller,
                    totalQuestions: questionsToShow.length,
                    tabTitle: tabTitle.toString(),
                  )
                else if (!controller.isTimedQuiz.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: isQuestionOfDayMode
                        ? Column(
                      children: const [
                        Icon(Icons.wb_sunny_outlined, color: Colors.yellow, size: 36),
                        SizedBox(height: 6),
                        Text(
                          "Question of the Day",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                        : PageIndicator(
                      pageController: pageController,
                      itemCount: questionsToShow.length,
                    ),
                  ),
                const SizedBox(height: 6),
                Expanded(
                  child: Obx(
                        () => PageView.builder(
                      controller: pageController,
                      physics: controller.isTimedQuiz.value
                          ? (controller.remainingSeconds.value == 0
                          ? const NeverScrollableScrollPhysics()
                          : const ClampingScrollPhysics())
                          : const ClampingScrollPhysics(),
                      itemCount: questionsToShow.length,
                      onPageChanged: (index) => controller.onPageChange(index),
                      itemBuilder: (context, index) {
                        final question = questionsToShow[index];
                        return QuizCard(
                          question: question,
                          index: index,
                          reviewMode: reviewMode,
                          reviewType: reviewType,
                          isQuestionOfDay: isQuestionOfDayMode,
                          onBackTap:() => _handleBackNavigation(context),
                        );
                      },
                    ),
                  ),
                ),
                if (!reviewMode && controller.isSubmitVisible.value && !isQuestionOfDayMode)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 26),
                    child: CommonButton(
                      title: "Submit Quiz",
                      onTap: () {
                        final quizResults = controller.calculateQuizResults();
                        final answered = quizResults['answered'] ?? 0;
                        final totalQuestions = quizResults['totalQuestions'] ?? 0;
                        if (answered == 0) {
                          Get.offAll(() => DashboardView(initialIndex: 0));
                          return;
                        }
                        if (answered <= 5) {
                          CustomDialog.show(
                            title: "Submit Quiz?",
                            message:
                            "You've answered $answered of $totalQuestions questions.\n"
                                "If you submit now, you'll only be scored on those $answered questions.",
                            positiveButtonText: "Submit",
                            onPositiveTap: () {
                              Get.offAll(() => QuizResultView(
                                quizQuestions: controller.questions,
                                quizResults: quizResults,
                              ));
                            },
                            negativeButtonText: "Cancel",
                            onNegativeTap: () => Get.back(),
                          );
                          return;
                        }
                        Get.offAll(() => QuizResultView(
                          quizQuestions: controller.questions,
                          quizResults: quizResults,
                        ));
                      },
                    ),
                  ),
                if (isQuestionOfDayMode)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Obx(() {
                      final hasAttempted = controller.selectedOptions.isNotEmpty;
                      return CommonButton(
                        title: "Submitted",
                        onTap: () async{
                          if (hasAttempted) {
                           await Get.find<StudyController>().markQuestionOfDayAttempted();
                            Get.offAll(() => const DashboardView());
                          } else {
                            Utils.showError("Please answer before closing.", "Error");
                          }
                        },
                      );
                    }),
                  )
                else
                  _NavigationRow(
                    isTimeQuiz: isTimedQuiz,
                    controller: controller,
                    pageController: pageController,
                    reviewMode: reviewMode,
                    reviewQuestionIds: questionIdsToReview,
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isFlag;
  const _NavButton({
    required this.icon,
    required this.onTap,
    this.isFlag = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(icon, size: 34, color: isFlag ? Colors.orange : kWhite),
      ),
    );
  }
}

class _NavigationRow extends StatelessWidget {
  final QuestionController controller;
  final PageController pageController;
  final bool reviewMode;
  final List<int>? reviewQuestionIds;
  final bool isTimeQuiz;

  const _NavigationRow({
    required this.controller,
    required this.pageController,
    this.reviewMode = false,
    this.reviewQuestionIds,
    this.isTimeQuiz = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isTimeQuiz) {
        if (controller.remainingSeconds.value == 0) {
          return Container(
              color: const Color(0xFF1E90FF),
              height: 30, width: double.infinity);
        }
      }
      final currentIndex = controller.currentPage.value;
      int originalQuestionIndex;
      if (reviewMode && reviewQuestionIds != null && reviewQuestionIds!.isNotEmpty) {
        if (currentIndex < reviewQuestionIds!.length) {
          originalQuestionIndex = reviewQuestionIds![currentIndex];
        } else {
          originalQuestionIndex = -1;
        }
      } else {
        originalQuestionIndex = currentIndex;
      }
      final bool isFlagged = controller.flaggedQuestions.contains(originalQuestionIndex);
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
            icon: Icons.outlined_flag_rounded,
            isFlag: isFlagged,
            onTap: () {
              if (!reviewMode && originalQuestionIndex != -1) {
                controller.toggleFlag(originalQuestionIndex);
              }
            },
          ),
          _NavButton(
            icon: Icons.arrow_forward_ios,
            onTap: () {
              final questionsToShow = reviewMode && controller.reviewQuestions.isNotEmpty
                  ? controller.reviewQuestions.length
                  : controller.questions.length;

              if (pageController.hasClients && pageController.page!.toInt() < questionsToShow - 1) {
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
