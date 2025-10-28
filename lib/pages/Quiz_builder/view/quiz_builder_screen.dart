import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import '/core/common/unlock_question_dialog.dart';
import '/core/local_storage/storage_helper.dart';
import '/core/common/back_button.dart';
import '/core/common/common_button.dart';
import '/core/theme/app_colors.dart';
import '../../questions/view/questions_view.dart';
import '../controller/quiz_builder_controller.dart';
import '../widgets/subject_selection.dart';
import '../widgets/time_picker.dart';

class QuizBuilderScreen extends StatelessWidget {
   QuizBuilderScreen({super.key});

  final quizBuilderController = Get.find<QuizBuilderController>();
  final subscriptionController = Get.find<RemoveAds>();
  final RxBool hasFirstAttempt = StorageService.getFirstAttempt().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteF7,
      appBar: AppBar(
        leading: const CommonBackButton(size: 36, iconSize: 22),
        title: const Text("Custom Quiz Builder"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (quizBuilderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final bool isSubscribed = subscriptionController.isSubscribedGet.value;
        final bool isLocked = hasFirstAttempt.value && !isSubscribed;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                "Choose subjects from the selected exam to build your quiz.",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),

              // disable when locked
              IgnorePointer(
                ignoring: isLocked,
                child: Opacity(
                  opacity: isLocked ? 0.5 : 1.0,
                  child: const Column(
                    children: [
                      ImprovedExamSelectionWidget(),
                      SizedBox(height: 20),
                      TimePickerWidget(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Center(
                child: Obx(() {
                  final hasTime =
                      quizBuilderController.selectedTime.value != Duration.zero;
                  final hasSubjects =
                      quizBuilderController.selectedSubjects.isNotEmpty;
                  final hasQuestionCount =
                      quizBuilderController.questionCountPerSubject.isNotEmpty;
                  final canStartQuiz =
                      hasTime && hasSubjects && hasQuestionCount;

                  if (isLocked) {
                    return CommonButton(
                      title: "Unlock Quiz Builder",
                      onTap: () =>
                          showAccessDialog(context, hasFirstAttempt),
                    );
                  }
                  return canStartQuiz
                      ? CommonButton(
                    title: "Start Quiz",
                    onTap: () async {
                      final allQuestions =
                      await quizBuilderController.prepareQuizQuestions();
                      final totalSeconds =
                          quizBuilderController.selectedTime.value.inSeconds;
                      if (!hasFirstAttempt.value) {
                        await StorageService.saveFirstAttempt(true);
                        hasFirstAttempt.value = true;
                      }
                      Get.off(() => QuizzesView(
                        allQuestion: allQuestions,
                        reviewMode: false,
                        isTimedQuiz: true,
                        timedQuizMinutes: totalSeconds,
                      ));
                    },
                  )
                      : const HideCommonButton(title: "Start Quiz");
                }),
              ),
              SizedBox(height:40),
              NativeAdWidget(templateType: TemplateType.medium,),
              SizedBox(height: 16)
            ],
          ),
        );
      }),
    );
  }
}
void showAccessDialog(BuildContext context, RxBool hasFirstAttempt) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleAdAccessDialog(
        title: "Unlock Quiz Builder",
        description:
        "This feature is locked. Watch a short ad to unlock one more attempt or subscribe for unlimited access.",
        onWatchAds: () async {
          final adsManager = Get.find<SplashInterstitialManager>();
          if (adsManager.isAdReady) {
            adsManager.showSplashAd(() async {
              await StorageService.watchAdsClearFirstAttempt();
              hasFirstAttempt.value = false;
              Navigator.of(context).pop();
              Get.snackbar(
                "Unlocked!",
                "You can now create a new quiz.",
                snackPosition: SnackPosition.BOTTOM,
              );
            });
          } else {
            Get.snackbar(
              "Ad Not Ready",
              "Please try again in a few seconds.",
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
      );
    },
  );
}

