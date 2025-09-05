import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_appbar/main_appbar.dart';
import '../control/setting_controller.dart';
import '/core/theme/theme.dart';

class SettingView extends StatelessWidget {
  final controller = Get.find<SettingController>();

  SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteF7,
      appBar: const MainAppBar(
        isBackButton: true,
        title: 'Setting',
        subtitle: '',
      ),
      // body: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //     child: Obx(() {
      //       return CustomScrollView(
      //         slivers: [
      //
      //         ],
      //       );
      //     }),
      //   ),
      // ),

    );
  }
}



