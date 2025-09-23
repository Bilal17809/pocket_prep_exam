import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pocket_prep_exam/core/Utility/utils.dart';
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
    final height = MediaQuery.of(context).size.height;
    final controlle = Get.find<EditeSubjectController>();
    return Expanded(
      child: ListView.builder(
          itemCount: controller.quizModeDataList.length,
          itemBuilder: (context,index){
            final item = controller.quizModeDataList[index];
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: bodySmallWH),
              child: Container(
                height: height * 0.11,
                margin:  EdgeInsets.symmetric(horizontal:bodySmallWH , vertical: 5),
                width: double.infinity,
                decoration: AppTheme.borderedBlue,
                child: Center(
                  child: GestureDetector(
                      onTap: (){
                        final quizQuestions = Get.find<EditeSubjectController>().startQuiz();
                        if (quizQuestions.isEmpty) {
                          Utils.showError("Please select at least one subject!");
                          return;
                        }
                        Get.to(() => QuizzesView(allQuestion: quizQuestions));
                      },
                    child: ListTile(
                      leading: Image.asset(item.icon.toString(),height: 50,),
                      title: Text(item.title.toString(),style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                        color: kBlack.withAlpha(140),
                        fontWeight: FontWeight.bold,

                      ),),
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


