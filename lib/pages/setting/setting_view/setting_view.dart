import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common/common_button.dart';
import '../control/setting_controller.dart';
import '/core/theme/theme.dart';
import '/pages/setting/widgets/widgets.dart';

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
              CommonButton(title: "Logout",onTap: (){},),
              SizedBox(height: 24),
            ],
          ),
        )
      // ),

    ));
  }
}



