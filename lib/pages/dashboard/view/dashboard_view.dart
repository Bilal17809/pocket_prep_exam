import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/stats/view/stats_view.dart';
import 'package:pocket_prep_exam/pages/study/view/study_view.dart';
import '/pages/dashboard/control/dashboard_controller.dart';
import '/pages/home/view/home_view.dart';
import '/pages/live_data/live_data_view/live_data_view.dart';
import '/pages/setting/setting_view/setting_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller= Get.find<DashboardController>();

    final List<Widget> screens=[
      StudyView(),
      StatsView(),
      LiveDataView(),
      SettingView()
    ];
    return Obx((){
      return Scaffold(
        backgroundColor: Colors.transparent,
        body:screens[controller.setIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          currentIndex: controller.setIndex.value,
          onTap: controller.trackIndex,
          items:  [
            BottomNavigationBarItem(icon: Icon(Icons.book),label: "Study",),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Stats"),
            BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "Live Data"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      );
    });
  }
}
