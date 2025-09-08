import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/setting/widgets/logout_button.dart';
import 'package:pocket_prep_exam/pages/setting/widgets/profile_section.dart';
import 'package:pocket_prep_exam/pages/setting/widgets/show_detail.dart';
import '../../main_appbar/main_appbar.dart';
import '../control/setting_controller.dart';
import '../widgets/items_list.dart';
import '../widgets/study_plane.dart';
import '/core/theme/theme.dart';

class SettingView extends StatelessWidget {

 const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingController>();
    return Scaffold(
      backgroundColor: kWhiteF7,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileSection(),
             DividerWidget(),
              ShowDetail(),
              StudyPlane(),
             SizedBox(height: 24),
              ItemsList(),
              LogoutButton(),
              SizedBox(height: 24),
            ],
          ),
        )
      // ),

    ));
  }
}



