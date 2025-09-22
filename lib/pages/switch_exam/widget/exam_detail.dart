import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import 'package:pocket_prep_exam/data/models/exams_and_subject.dart';
import 'package:pocket_prep_exam/pages/switch_exam/controller/switch_exam_cont.dart';

class ExamDetail extends StatelessWidget {
  final Exam data;
  final int index;
  const ExamDetail({super.key,required this.data,required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SwitchExamController>();
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: bodyWH,vertical: bodySmallWH),
      child: Obx((){
        final isSelected = controller.selectExamIndex.value == index;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: roundedDecoration.copyWith(
            border: Border.all(color: isSelected ? lightSkyBlue.withAlpha(240) : greyColor.withAlpha(60),width:isSelected? 2:1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.examName, style: context.textTheme.bodySmall!.copyWith(
                color: kBlack,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 30),
              Row(
                children: [
                  _QuesAndSubText(text: "${data.totalQuestions.toString()} questions," ),
                  SizedBox(width: 10),
                  _QuesAndSubText(text: "${data.totalSubjects.toString()} subjects"),
                ],
              )
            ],
          ) ,
        );
      }
      )
    );
  }
}

class _QuesAndSubText extends StatelessWidget {
  final String text;
  const _QuesAndSubText({super.key,required this.text});
  @override
  Widget build(BuildContext context) {
    return  Text(text, style: context.textTheme.bodySmall!.copyWith(
      color: greyColor,
      fontSize: 15,
    ),);
  }
}
