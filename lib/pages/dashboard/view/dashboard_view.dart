import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      PracticeView(result: Get.arguments is QuizResult ? Get.arguments as QuizResult : null),
      SettingView()
    ];
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          if (controller.setIndex.value != 0) {
            controller.setInitialIndex(0);
            return false;
          }
          final shouldExit = await _showExitDialog();
          return shouldExit ?? false;
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


  Future<bool?> _showExitDialog() {
    return Get.dialog<bool>(
      AlertDialog(
        title: Center(child: const Text("Exit App?",)),
        content: const Text("Do you really want to exit the app?"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("No", style: TextStyle(color: kBlue)),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Exit",style: TextStyle(color: kWhite),),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
