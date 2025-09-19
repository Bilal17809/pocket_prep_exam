
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/exam_settings/controller/exam_setting_controller.dart';
import 'package:pocket_prep_exam/pages/exam_settings/widgets/details.dart';
import 'package:pocket_prep_exam/pages/exam_settings/widgets/exam_name.dart';
import '/core/common/common_appbar.dart';

class ExamSettingView extends StatelessWidget {
  const ExamSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExamSettingController>();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Exam Settings",
        backgroundColor: kWhiteF7,
        bottomLineColor: lightSkyBlue,
      ),
          backgroundColor: kWhiteF7,
      body:
        Column(
          children: [
         ExamName(controller: controller),
            Details(),
          ],
    ));

  }
}
