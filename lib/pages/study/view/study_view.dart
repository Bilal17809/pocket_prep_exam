import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/ad_manager/banner_ads.dart';
import '/core/theme/app_styles.dart';
import '/core/common/app_drawer.dart';
import '/core/theme/app_colors.dart';
import '/pages/study/controller/study_controller.dart';
import '/pages/study/widgets/widgets.dart';

class StudyView extends StatelessWidget {
  const StudyView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final controller = Get.find<StudyController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: kWhiteF7,
          title: Text("Paramedic Prep",style: titleMediumStyle.copyWith(fontSize: 26),),
          centerTitle: true,
        ),
        drawer: const AppDrawer(),
        backgroundColor: kWhiteF7,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.02),
            CalendarSection(controller: controller),
            SizedBox(height: 10),
            ProgressSection(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SetPurchaseCard(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Text("Quiz Modes", style: context.textTheme.titleMedium),
            ),
            QuickQuiz(controller: controller),
          ],
        ),
        bottomNavigationBar: BannerAdWidget(),
      ),
    );
  }
}




