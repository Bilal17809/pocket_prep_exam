
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/common.dart';
import 'package:pocket_prep_exam/core/common/common_button.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/dashboard/view/dashboard_view.dart';
import 'package:pocket_prep_exam/pages/switch_exam/controller/switch_exam_cont.dart';
import 'package:pocket_prep_exam/pages/switch_exam/widget/exam_list.dart';
import 'package:pocket_prep_exam/pages/switch_exam/widget/top_text.dart';

class ExamSwitchView extends StatelessWidget {
  const ExamSwitchView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.find<SwitchExamController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteF7,
        body: Obx((){
          if(controller.isLoading.value){
            return Center(child: CircularProgressIndicator(),);
          }
          if(controller.exam.isEmpty){
            return NoDataFound(description: "EXAM IS EMPTY");
          }
          return Column(
            children: [
              TopText(),
              ExamList(controller: controller),
              controller.showButton.value ?
              CommonButton(
                title: "Switch Exam",
                onTap: () {
                  controller.saveSelectedExam();
                  Get.to(() => DashboardView());
                },
              ):
              HideCommonButton(title: "Switch Exam",)
            ],
          );
        })
      ),
    );

  }
}
