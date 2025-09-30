import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/Utility/utils.dart';
import '/core/common/constant.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_styles.dart';
import '/pages/edite_subjects/controller/edite_subject_controller.dart';
import '/pages/questions/view/questions_view.dart';
import '/pages/study/controller/study_controller.dart';

class QuizModeList extends StatelessWidget {
  final StudyController controller;
  const QuizModeList({super.key,required this.controller});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      child: ListView.builder(
          itemCount: controller.quizModeDataList.length,
          itemBuilder: (context,index){
            final item = controller.quizModeDataList[index];
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: bodySmallWH),
              child: Container(
                height: height * 0.09,
                margin:  EdgeInsets.symmetric(horizontal:bodySmallWH , vertical: 5),
                width: double.infinity,
                decoration: roundedDecoration,
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
                      leading: Image.asset(item.icon.toString(),height: 40,),
                      title: Text(item.title.toString(),style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                        color: kBlack.withAlpha(140),
                        fontWeight: FontWeight.bold),),
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


