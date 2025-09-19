import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/exam_settings/controller/exam_setting_controller.dart';

class ExamName extends StatelessWidget {
  final ExamSettingController controller;
  const ExamName({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child:Obx((){
        final exam = controller.selectedExam.value;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exam == null ? "Null":  exam.examName,style: context.textTheme.bodyLarge!.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: "Ariel",
            ),),
            Text(exam == null ? "Null":  exam.examName,style: context.textTheme.bodyLarge!.copyWith(
              fontSize: 16,
              // fontWeight: FontWeight.bold,
              fontFamily: "Ariel",
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("images/exam setting.png",height: 160,)
              ],
            )
          ],
        );
      })
    );
  }
}
