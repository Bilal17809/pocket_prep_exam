import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pocket_prep_exam/core/common/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_theme.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/controller/edite_subject_controller.dart';
import 'package:pocket_prep_exam/pages/questions/view/questions_view.dart';
import 'package:pocket_prep_exam/pages/study/controller/study_controller.dart';

class QuizModeList extends StatelessWidget {
  final StudyController controller;
  const QuizModeList({super.key,required this.controller});
  @override
  Widget build(BuildContext context) {
    final controlle = Get.find<EditeSubjectController>();
    return Expanded(
      child: ListView.builder(
          itemCount: controller.quizModeDataList.length,
          itemBuilder: (context,index){
            final item = controller.quizModeDataList[index];
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: bodySmallWH),
              child: Container(
                margin:  EdgeInsets.symmetric(horizontal:bodySmallWH , vertical: 5),
                width: double.infinity,
                decoration: AppTheme.borderedBlue,
                child: Center(
                  child: GestureDetector(
                      onTap: (){
                        final controller = Get.find<EditeSubjectController>();
                        final quizQuestions = controller.startQuiz();
                        if (quizQuestions.isEmpty) {
                          Get.snackbar("Error", "Please select at least one subject!");
                          return;
                        }
                        Get.to(() => QuizzesView(allQuestion: quizQuestions));
                      },
                    child: ListTile(
                      leading: Image.asset(item.icon.toString()),
                      title: Text(item.title.toString(),),
                      trailing: Text(item.date.toString(),style: TextStyle(color: kBlue,fontSize: 14),),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}


