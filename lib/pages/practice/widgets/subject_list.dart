import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/routes/routes_name.dart';
import '/core/theme/theme.dart';
import '/pages/quiz_setup/controller/quiz_setup_controller.dart';
import '/pages/practice/controller/practice_controller.dart';


class SubjectList extends StatelessWidget {
  const SubjectList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PracticeController>();
    return Obx((){
      final exam = controller.selectExam.value;
      if(controller.isLoading.value){
        return Center(child: CircularProgressIndicator());
      }
      if(exam == null || exam.subjects.isEmpty){
        return Center(child: Text("No Subject Available"));
      }
      return   ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: exam.subjects.length,
        itemBuilder: (context, index) {
          final subject = exam.subjects[index];
         final questions = controller.getQuestionCountBySubject(subject.subjectId);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 06),
            child: Container(
              decoration: roundedDecoration,
              child: GestureDetector(
                onTap: (){
                  Get.find<QuizSetupController>().setSubject(subject);
                  Get.toNamed(RoutesName.quizSetup);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: lightSkyBlue.withAlpha(40),
                    child: Text("${index + 1}",style: context.textTheme.titleMedium!.copyWith(
                      color: kBlack,fontWeight: FontWeight.bold
                    ),),
                  ),
                  title: Text(subject.subjectName,style: bodyLargeStyle.copyWith(fontWeight: FontWeight.bold),),
                  subtitle: Text("Questions: $questions",style: bodyMediumStyle.copyWith(color: Colors.black54,fontWeight: FontWeight.bold),),
                ),
              ),
            )
          );
        },
      );
    });
  }
}
