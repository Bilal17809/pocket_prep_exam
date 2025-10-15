
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors.dart';
import '/pages/exam_settings/controller/exam_setting_controller.dart';
import '/pages/exam_settings/widgets/widgets.dart';
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
