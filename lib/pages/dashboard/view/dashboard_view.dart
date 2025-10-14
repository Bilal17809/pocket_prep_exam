import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/core/common/exite_dialog.dart';
import '/core/theme/app_colors.dart';
import '/pages/practice/view/practice_view.dart';
import '/pages/quiz_view_second/controller/quiz_controller.dart';
import '/pages/stats/view/stats_view.dart';
import '/pages/study/view/study_view.dart';
import '/pages/dashboard/control/dashboard_controller.dart';
import '/pages/setting/setting_view/setting_view.dart';

class DashboardView extends StatelessWidget {
  final int initialIndex;

  const DashboardView({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setInitialIndex(initialIndex);
    });

    final List<Widget> screens = [
      StudyView(),
      StatsView(),
      PracticeView(result: Get.arguments is QuizResult
          ? Get.arguments as QuizResult
          : null),
      SettingView()
    ];
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          if (controller.setIndex.value != 0) {
            controller.setInitialIndex(0);
            return false;
          }
          CustomDialogForExitAndWarning.show(
            title: "Exit App",
            message: "Do you really want to exit the app?",
            positiveButtonText: "Yes",
            onPositiveTap: () {
              SystemNavigator.pop();
            },
            negativeButtonText: "No",
            onNegativeTap: () {
              Get.back();
            },
            isWarning: true,
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: screens[controller.setIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: lightSkyBlue,
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            currentIndex: controller.setIndex.value,
            onTap: controller.trackIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.book), label: "Study"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Stats"),
              BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "Practice"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
            ],
          ),
        ),
      );
    });
  }
}