
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/stats/controller/stats_controller.dart';
import '/pages/stats/widgets/widgets.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatsController>();
      return Scaffold(
        backgroundColor: kWhiteF7,
        body: Column(
          children: [
            const StatsHeader(),
            SizedBox(height: 16),
            const PremiumButton(),
            TileList(controller: controller),
          ],
        ),
      );

  }
}
