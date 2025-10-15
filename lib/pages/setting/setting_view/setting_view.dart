import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/local_storage/storage_helper.dart';
import '../control/setting_controller.dart';
import '/core/common/common_button.dart';
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
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SwitchListTile(
                  title:  Text("Enable Text-to-Speech (TTS)",
                    style: context.textTheme.titleSmall!.copyWith(color:kBlack,fontWeight: FontWeight.bold,fontSize: 16),
                  ),
                  subtitle: Text(
                    "Turn off if you don’t want voice reading in quizzes.",
                    style: context.textTheme.titleSmall!.copyWith(color:kWhite),
                  ),
                  value: controller.isTtsEnabled.value,
                  activeColor: kWhite,
                  tileColor: lightSkyBlue.withAlpha(200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  activeTrackColor: kBlack,
                  inactiveThumbColor: lightSkyBlue,
                  inactiveTrackColor: kWhite,
                  onChanged: (value) {
                    controller.isTtsEnabled.value = value;
                    StorageService.saveTTsToggle(value);
                  },
                ),
              )),
              SizedBox(height: 10),
              CommonButton(title: "Logout",onTap: (){},),
              SizedBox(height: 24),
            ],
          ),
        )
      // ),

    ));
  }
}



