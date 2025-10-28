import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/back_button.dart';
import '../../../core/local_storage/storage_helper.dart';
import '../../premium/view/premium_screen.dart';
import '/core/common/common.dart';
import '/core/common/common_button.dart';
import '/core/theme/app_colors.dart';
import '/pages/dashboard/view/dashboard_view.dart';
import '/pages/switch_exam/controller/switch_exam_cont.dart';
import '/pages/switch_exam/widget/exam_list.dart';
import '/pages/switch_exam/widget/top_text.dart';
import '/core/common/loading_container.dart';

class ExamSwitchView extends StatelessWidget {
  const ExamSwitchView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SwitchExamController>();
    return SafeArea(
      child: Scaffold(
          backgroundColor: kWhiteF7,
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.exam.isEmpty) {
              return const NoDataFound(description: "EXAM IS EMPTY");
            }
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  child: Column(
                    children: [
                      const TopText(),
                      const SizedBox(height: 10),
                      ExamList(controller: controller),
                      const SizedBox(height: 10),
                      controller.showButton.value
                          ? CommonButton(
                        title: "Switch Exam",
                        onTap: () async {
                          final isFirstLaunch = !StorageService.getFirstLaunch();
                          if (isFirstLaunch) {
                            await StorageService.saveFirstLaunch(true);
                            Get.to(() => const PremiumScreen());
                            return;
                          }
                          LoadingDialog.show(message: "Switching Exam...");
                          await controller.saveSelectedExam();
                          await Future.delayed(const Duration(milliseconds: 500));
                          LoadingDialog.hide();
                          Get.offAll(() => DashboardView(initialIndex: 0));
                        },
                        // onTap: () async {
                        //   LoadingDialog.show(message: "Switching Exam...");
                        //   await controller.saveSelectedExam();
                        //   await Future.delayed(
                        //     const Duration(milliseconds: 500),
                        //   );
                        //   LoadingDialog.hide();
                        //   Get.offAll(() => DashboardView(initialIndex: 0));
                        // },
                      )
                          : const HideCommonButton(title: "Switch Exam"),
                      SizedBox(height: 14)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 06,vertical: 08),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CommonBackButton(
                      size: 36,
                      iconSize: 22,
                      backgroundColor: lightSkyBlue,
                      onTap: () => Get.back(),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),

    );
  }
}
