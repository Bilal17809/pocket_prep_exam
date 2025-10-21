import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/setting/widgets/unlock_card.dart';
import '/core/local_storage/storage_helper.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UnlockProCard(),
              ProfileSection(),
              ShowDetail(),
              StudyPlane(),
             SizedBox(height: 24),
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  width: double.infinity,
                  decoration: AppTheme.card,
                  child: SwitchListTile(
                    title:  Text("Enable Text-to-Speech (TTS)",
                      style: context.textTheme.titleSmall!.copyWith(color:kBlack,fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                    subtitle: Text(
                      "Turn off if you don’t want voice reading in quizzes.",
                      style: context.textTheme.titleSmall!.copyWith(color:grey,fontWeight: FontWeight.w600),
                    ),
                    value: controller.isTtsEnabled.value,
                    activeColor: kWhite,
                    tileColor: kWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    activeTrackColor: lightSkyBlue,
                    inactiveThumbColor: lightSkyBlue,
                    inactiveTrackColor: kWhite,
                    onChanged: (value) {
                      controller.isTtsEnabled.value = value;
                      StorageService.saveTTsToggle(value);
                    },
                  ),
                )
              )),
              SizedBox(height: 24),
            ],
          ),
        )
    ));
  }
}



