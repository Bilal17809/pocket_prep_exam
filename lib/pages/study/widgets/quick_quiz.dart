import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../core/common/unlock_question_dialog.dart';
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

    return Expanded(
      child: Obx(() {
        final modes = controller.buildQuizModeList();

        return ListView.builder(
          itemCount: modes.length,
          itemBuilder: (context, idx) {
            final item = modes[idx];
            final isHidden = item.title == "Hidden until tomorrow";
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: bodySmallWH),
              child: Container(
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
                        final quizQuestions = Get.find<EditeSubjectController>().startQuiz();
                       // controller.clearQuestionOfDayAttempt();
                        if (quizQuestions.isEmpty) {
                          Utils.showError("Please select at least one subject!", "Error");
                          return;
                        }
                        Get.to(() => QuizzesView(allQuestion: quizQuestions, isTimedQuiz: false));
                      } else if (item.title == "Timed Quiz") {
                        Get.find<QuestionController>().resetController();
                        // showAccessDialog(context);
                        TimedQuizBottomSheet.show();
                      } else if (item.title == "Quiz Builder") {
                        Get.to(() => QuizBuilderScreen());
                      }
                    },
                    child: ListTile(
                      leading: Image.asset(
                        item.icon ?? "",
                        height: 40,
                        // color: isHidden ? Colors.grey.shade500 : null,
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
            );
          },
        );
      }),
    );
  }
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