import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/Utility/utils.dart';
import '/core/common/common_button.dart';
import '/core/common/custom_dialog.dart';
import '/core/routes/routes_name.dart';
import '/core/theme/app_colors.dart';
import '/pages/quiz_view_second/controller/quiz_controller.dart';
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
        return await Utils.leaveBottomSheet(context,"Are you sure you want to leave the quiz? Your progress will be lost");
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,color: kWhite,),
              onPressed: () async {
                bool shouldLeave = await Utils.leaveBottomSheet(context,"Are you sure you want to leave the quiz? Your progress will be lost");
                if (shouldLeave) Get.back();
              },
            ),
            actions: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Obx(() {
              //     final currentIndex = quizController.currentPage.value;
              //     final time = quizController.remainingTime[currentIndex] ?? 0;
              //     return Text(
              //       "Time Left: ${time}s",
              //       style: const TextStyle(color: Colors.white, fontSize: 18),
              //     );
              //   }),
              // )
            ],
          ),
          body: Stack(
            children: [
              Column(
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
                      padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26),
                      child: CommonButton(
                        title: "Submit Quiz",
                        onTap: () {
                          final answered = quizController.questions.length -
                              quizController.totalSkipped;
                          CustomDialog.show(
                            title: "Submit Quiz?",
                            message:
                            "You've answered $answered of ${quizController.questions.length} questions. "
                                "If you submit, you'll only be scored on the $answered question you answered.",
                            positiveButtonText: "Submit",
                            onPositiveTap: () async {
                              final result = quizController.generateResult();
                              final subject = Get.find<QuizSetupController>()
                                  .selectedSubject
                                  .value;
                              if (subject != null) {
                                await Get.find<StatsController>().saveResultAndStore(subject, result);
                              }
                              final dashboardController =
                              Get.find<DashboardController>();
                              dashboardController.setIndex.value = 2;
                              Get.offNamed(
                                RoutesName.dashBoard,
                                arguments: result,
                              );
                            },
                            negativeButtonText: "Cancel",
                            onNegativeTap: () => Get.back(),
                          );
                        },
                      ),
                    )
                        : const SizedBox.shrink();
                  }),
                  _NavigationRow(
                    controller: quizController,
                    pageController: pageController,
                  ),
                ],
              ),
              // Obx(() {
              //   final currentIndex = quizController.currentPage.value;
              //   final int remainingTime = quizController.remainingTime[currentIndex] ?? 0;
              //
              //   if (remainingTime == 0) {
              //     return SizedBox();
              //   }
              //   const Color darkTeal = Color(0xFF006080);
              //   const Color lightAquaBlue = Color(0xFF00ACD2);
              //   const Color lightSegmentGray = Color(0xFFE0E0E0);
              //   const Color lowTimeGray = Colors.red;
              //
              //   final int initialMaxTime = Get.find<QuizSetupController>().selectedTimeLimit.value;
              //   final double progress = (remainingTime / initialMaxTime).clamp(0.0, 1.0);
              //   final bool isLowTime = remainingTime <= 5;
              //   final Color timerNumberColor = isLowTime ? lowTimeGray : lightSkyBlue;
              //   const double outerRingWidth = 10.0;
              //   const double innerProgressWidth = 10.0;
              //
              //   return Positioned.fill(
              //     child: Center(
              //       child:
              //         Stack(
              //         alignment: Alignment.center,
              //         children: [
              //           Image.asset(
              //             'images/alarm.png',
              //             width: 300,
              //             height: 300,
              //             fit: BoxFit.contain,
              //           ),
              //           Container(
              //             width: 250,
              //             height: 250,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               border: Border.all(
              //                 color: lightSkyBlue,
              //                 width: outerRingWidth,
              //               ),
              //               color: Colors.white,
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.all(16),
              //               child: CircularProgressIndicator(
              //                 value: progress, // 0.0 to 1.0
              //                 strokeWidth: innerProgressWidth,
              //                 backgroundColor: lightSegmentGray,
              //                 valueColor: AlwaysStoppedAnimation<Color>(lightAquaBlue),
              //               ),
              //             )
              //           ),
              //           AnimatedSwitcher(
              //             duration: const Duration(milliseconds: 800),
              //             transitionBuilder: (Widget child, Animation<double> animation) {
              //               return ScaleTransition(
              //                 scale: CurvedAnimation(parent: animation, curve: Curves.easeIn),
              //                 child: FadeTransition(opacity: animation, child: child),
              //               );
              //             },
              //             child: Column(
              //               key: ValueKey<int>(remainingTime),
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 Text(
              //                   "$remainingTime",
              //                   style: TextStyle(
              //                     fontSize: 80,
              //                     color: timerNumberColor,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 Text(
              //                   'sec',
              //                   style: TextStyle(
              //                     fontSize: 24,
              //                     color: timerNumberColor,
              //                     fontWeight: FontWeight.normal,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     ));
              // }),
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
