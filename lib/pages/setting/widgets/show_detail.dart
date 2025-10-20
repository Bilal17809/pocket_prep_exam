import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_theme.dart';
import 'package:pocket_prep_exam/pages/exam_settings/view/exam_setting_view.dart';
import 'package:pocket_prep_exam/pages/setting/control/setting_controller.dart';
import 'package:pocket_prep_exam/pages/setting/widgets/widgets.dart';
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
           Text("I'm preparing for",style: Theme.of(context).textTheme.titleSmall!.copyWith(color: grey)),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
           decoration: AppTheme.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                      ],
                    );
                  })
                ),
                ClickableDividerRow(
                  title: "Exam Settings",
                  onTap: () {
                    Get.to(() => ExamSettingView());
                  },
                ),
                ClickableDividerRow(
                  title: "Switch Exam",
                  onTap: () {
                    Get.off(() => ExamSwitchView());
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

class ClickableDividerRow extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ClickableDividerRow({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      splashColor: kBlack,
      highlightColor: kBlack,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            AppDivider(height: 10.0, color: greyColor.withAlpha(40)),
            ReusableRow(
              widget: ButtonText(
                title: title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
