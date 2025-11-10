import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/local_storage/storage_helper.dart';
import '/core/common/unlock_question_dialog.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import '/core/theme/app_styles.dart';
import '/core/common/constant.dart';
import '../../questions/widgets/quiz_bottomsheet.dart';
import '/core/theme/app_colors.dart';
import '/core/Utility/utils.dart';
import '/pages/questions/view/questions_view.dart';
import '/pages/edite_subjects/controller/edite_subject_controller.dart';
import '/pages/study/controller/study_controller.dart';
import '/pages/questions/control/questions_controller.dart';
import '/pages/Quiz_builder/view/quiz_builder_screen.dart';


class QuickQuiz extends StatelessWidget {
  final StudyController controller;
  const QuickQuiz({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Obx(() {
      // final RxBool hasFirstAttempt = StorageService.getFirstAttempt().obs;
      // final RxBool isSubscribed = Get.find<RemoveAds>().isSubscribedGet;
      final modes = controller.buildQuizModeList();

      return Expanded(
        child: ListView.builder(
          itemCount: modes.length,
          itemBuilder: (context, idx) {
            final item = modes[idx];
            final isHidden = item.title == "Hidden until tomorrow";
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: bodySmallWH),
                child: Opacity(
                  opacity: item.isLockedTimedQuiz ? 0.5 : 1.0,
                  child:  Container(
                    height: height * 0.09,
                    margin: EdgeInsets.symmetric(horizontal: bodySmallWH, vertical: 5),
                    width: double.infinity,
                    decoration:roundedDecoration.copyWith(
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          if (item.title == "Question of the Day") {
                            final q = await controller.getQuestionOfTheDay();
                            if (q == null) {
                              Utils.showError("No Question", "No question available for today.");
                              return;
                            }
                            Get.to(() => QuizzesView(
                              allQuestion: [q],
                              reviewMode: false,
                              isTimedQuiz: false,
                            ));
                          }
                          else if (idx == 1) {
                            final QuizQuestionsForFreeUser = Get.find<EditeSubjectController>().startQuizForFreeUser();
                            final quizQuestions = Get.find<EditeSubjectController>().startQuiz();
                            final isSubscribed = Get.find<RemoveAds>().isSubscribedGet.value;
                            if (quizQuestions.isEmpty || QuizQuestionsForFreeUser.isEmpty) {
                              Utils.showError("Please select at least one subject!", "Error");
                              return;
                            }
                            Get.to(() => QuizzesView(allQuestion: isSubscribed ? quizQuestions : QuizQuestionsForFreeUser, isTimedQuiz: false));
                          }
                          else if (item.title!.startsWith("Timed Quiz")) {
                            if (item.isLockedTimedQuiz) {
                              SizedBox();
                            } else {
                              Get.find<QuestionController>().resetController();
                              TimedQuizBottomSheet.show();
                            }
                          }
                          else if (item.title == "Quiz Builder") {
                            Get.to(() => QuizBuilderScreen());
                          }
                        },
                        child: ListTile(
                          leading: Image.asset(
                            item.icon ?? "",
                            height: 40,
                          ),
                          title: Text(
                            item.title ?? "",
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontSize: 17,
                              color: isHidden ? Colors.grey.shade600 : kBlack.withAlpha(180),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Text(
                            item.date ?? "",
                            style: TextStyle(color: isHidden ? greyColor :  lightSkyBlue, fontSize: 16,fontWeight: isHidden ? FontWeight.normal : FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            );
          },
        ),
      );
    });}
}

void showAccessDialog(BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleAdAccessDialog(
        title: "Unlock Today's Question",
        description: "This feature is currently locked. Watch an ad to unlock today's question.",
        onWatchAds: () {
          Navigator.of(context).pop();
        },
      );
    },
  );
}