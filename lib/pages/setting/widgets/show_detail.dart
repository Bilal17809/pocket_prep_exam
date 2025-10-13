import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_theme.dart';
import 'package:pocket_prep_exam/pages/exam_settings/view/exam_setting_view.dart';
import 'package:pocket_prep_exam/pages/setting/control/setting_controller.dart';
import 'package:pocket_prep_exam/pages/switch_exam/view/examp_switch_view.dart';
import '/core/common/app_divider.dart';
import '/core/theme/app_colors.dart';
import '/pages/setting/widgets/text_button.dart';
import '/core/common/constant.dart';

class ShowDetail extends StatelessWidget {
  const ShowDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("I'm preparing for"),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
           decoration: AppTheme.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 08, vertical: 10),
                  child: Obx((){
                    final exam = controller.selectedExam.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exam == null ? "Null" :
                         exam.examName,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: kBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          exam == null ? "Null" :
                          exam.examName,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: kBlack,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Free Study Progress . 0 / 30 Questions",
                          style: context.textTheme.bodySmall!.copyWith(
                            color: kBlack,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  })
                ),
                AppDivider(height: 10.0,color: greyColor.withAlpha(60),),
                ButtonText(
                  title: "Exam Settings",
                  onTap: () {
                    Get.to(() => ExamSettingView());
                  },
                ),
                AppDivider(height: 10.0,color: greyColor.withAlpha(60),),
                ButtonText(
                  title: "Switch Exam",
                  onTap: () {
                    Get.off( ()=> ExamSwitchView());
                  },
                ),
                const SizedBox(height: 08),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

