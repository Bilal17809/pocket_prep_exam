import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/study/controller/study_controller.dart';
import 'package:pocket_prep_exam/pages/study/widgets/calender_list.dart';
import 'package:pocket_prep_exam/pages/study/widgets/quiz_mode_list.dart';
import 'package:pocket_prep_exam/pages/study/widgets/top_banner.dart';
import '../widgets/show_answers.dart';
import '../widgets/upgrade_button.dart';

class StudyView extends StatelessWidget {
  const StudyView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    final controller = Get.find<StudyController>();
    return  SafeArea(
        child: Scaffold(
            backgroundColor: backgroundColor,
            body: Stack(
              children: [
                HomeBanner(height: height),
                Positioned(
                  top: height * 0.23,
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kWhiteF7,
                      borderRadius: BorderRadius.vertical(top: Radius.elliptical(height, 200.0)),) ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.06,),
                        CalenderListSection(controller: controller,height: height * 1.00, width: width * 1.00),
                        ShowAnswers(),
                        UpgradeButton(),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 06),
                           child: Text("Quiz Modes",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                         ),
                         QuizModeList(controller: controller)
                      ],
                    ),
                  ),
                )
              ],
            )
        ),
      );


  }
}
