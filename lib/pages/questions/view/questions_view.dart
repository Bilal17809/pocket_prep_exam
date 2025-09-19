// lib/pages/questions/view/questions_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/common_button.dart';
import 'package:pocket_prep_exam/pages/questions/widgets/quiz_appbar.dart';
import 'package:pocket_prep_exam/services/services.dart';
import '/data/models/exams_and_subject.dart';
import 'package:pocket_prep_exam/pages/questions/widgets/page_indicator.dart';
import 'package:pocket_prep_exam/pages/questions/widgets/quize_card.dart';
import 'package:pocket_prep_exam/pages/quiz_result/view/quiz_result_view.dart';
import '/core/common/custom_dialog.dart';
import '../control/questions_controller.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

class QuizzesView extends StatefulWidget {
  final Subject subject;
  final bool reviewMode;
  final int? initialPage;
  final String? tabTitle;
  final List<int>? questionIdsToReview;
  final Map<int, int>? selectedOptions;
  final String reviewType;
  QuizzesView({
    super.key,
    required this.subject,
    this.reviewMode = false,
    this.initialPage,
    this.tabTitle,
    this.questionIdsToReview,
    this.selectedOptions,
    this.reviewType = 'All',
  });

  @override
  State<QuizzesView> createState() => _QuizzesViewState();
}

class _QuizzesViewState extends State<QuizzesView> {
  late PageController _pageController;
  late final QuestionController controller;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage ?? 0);
    controller = Get.find<QuestionController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.reviewMode && widget.questionIdsToReview != null && widget.selectedOptions != null) {
        controller.setReviewQuestions(widget.questionIdsToReview!, widget.selectedOptions!);
      } else if (controller.questions.isEmpty) {
        controller.loadQuestions();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1E90FF),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final questionsToShow = widget.reviewMode ? controller.reviewQuestions : controller.questions;
          if (questionsToShow.isEmpty) {
            return const Center(child: Text("No questions available."));
          }
          return Column(
            children: [
              if (widget.reviewMode)
                QuizAppBar(controller: controller, totalQuestions:
                questionsToShow.length, tabTitle: widget.tabTitle.toString())
              else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: PageIndicator(
                    pageController: _pageController,
                    itemCount: questionsToShow.length,
                  ),
                ),
              const SizedBox(height: 10),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: questionsToShow.length,
                  onPageChanged: (index) {
                    controller.onPageChange(index);
                  },
                  itemBuilder: (context, index) {
                    final question = questionsToShow[index];
                    return QuizCard(
                      question: question,
                      index: index,
                      reviewMode: widget.reviewMode,
                      reviewType: widget.reviewType,
                    );
                  },
                ),
              ),
              if (!widget.reviewMode && controller.isSubmitVisible.value)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26),
                  child: CommonButton(
                    title: "Submit Quiz",
                    onTap: ()  {
                      final quizResults = controller.calculateQuizResults();
                        CustomDialog.show(
                          title: "Submit Quiz?",
                          message: "You've answered ${quizResults['answered']} of ${quizResults['totalQuestions']} questions. if you submit, you'll only be scored on the ${quizResults['answered']} question you answered ",
                          positiveButtonText: "Submit",
                          onPositiveTap: () {
                            Get.off(() => QuizResultView(
                              subject: widget.subject,
                              quizResults: quizResults,
                            ));
                          },
                          negativeButtonText: "Cancel",
                          onNegativeTap: () => Get.back(),
                        );

                        // Get.put(()=>QuestionController(q: QuestionService()));
                       // await Get.off(() => QuizResultView(
                       //    subject: widget.subject,
                       //    quizResults: quizResults,
                       //  ));


                    },
                  ),
                ),
              _NavigationRow(
                controller: controller,
                pageController: _pageController,
                reviewMode: widget.reviewMode,
                reviewQuestionIds: widget.questionIdsToReview,
              )
            ],
          );
        }),
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
          color: isFlag ? Colors.orange : kWhite,
        ),
      ),
    );
  }
}

class _NavigationRow extends StatelessWidget {
  final QuestionController controller;
  final PageController pageController;
  final bool reviewMode;
  final List<int>? reviewQuestionIds;

  const _NavigationRow({
    super.key,
    required this.controller,
    required this.pageController,
    this.reviewMode = false,
    this.reviewQuestionIds,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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

              if (pageController.hasClients &&
                  pageController.page!.toInt() < questionsToShow - 1) {
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