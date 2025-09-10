import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common/app_drawer.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_theme.dart';
import '/pages/study/controller/study_controller.dart';
import '/pages/study/widgets/widgets.dart';

class StudyView extends StatelessWidget {
  const StudyView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    final controller = Get.find<StudyController>();
    return  SafeArea(
      child: Scaffold(
        drawer: const AppDrawer(),
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            HomeBanner(height: height),
            _BuildMenuButton(),
             _ScreenWidgetsContainer(
                 widget: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: height * 0.06),
                     CalenderListSection(
                       controller: controller,
                       height: height,
                       width: width,
                     ),
                     ShowAnswers(),
                     UpgradeButton(),
                     Padding(
                       padding: EdgeInsets.symmetric(
                           horizontal: 20, vertical: 6),
                       child: Text(
                         "Quiz Modes",
                         style: context.textTheme.titleMedium
                       ),
                     ),
                     QuizModeList(controller: controller),
                   ],
                 ),
             )
          ],
        ),
      ),
    );
  }
}
class _ScreenWidgetsContainer extends StatelessWidget {
  final Widget widget;
  const _ScreenWidgetsContainer({required this.widget});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return   Positioned(
        top: height * 0.23,
        left: 0,
        bottom: 0,
        right: 0,
        child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: AppTheme.topRounded(height),
        child: widget,
    ));
  }
}

class _BuildMenuButton extends StatelessWidget {
  const _BuildMenuButton({super.key});
  @override
  Widget build(BuildContext context) {
    return  Positioned(
      top: 06,
      left: 16,
      child: Builder(
        builder: (context) => IconButton(icon: const Icon(Icons.menu, color: kBlack, size: 30),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );
  }
}

