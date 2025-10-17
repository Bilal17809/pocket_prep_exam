import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/premium/widgets/plane_card.dart';
import '../controller/premium_controller.dart';

class PremiumPlansCarousel extends StatelessWidget {
  const PremiumPlansCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PremiumPlansController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.19,
      width: width * 0.74,
      child: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.plans.length,
        clipBehavior: Clip.none,
        onPageChanged: controller.onPageChanged,
        itemBuilder: (context, index) {
          final plan = controller.plans[index];
          return Obx(() {
            final isActive = index == controller.currentPage.value;
            return AnimatedScale(
              duration: const Duration(milliseconds: 350),
              scale: isActive ? 1.05 : 0.92,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 350),
                opacity: isActive ? 1.0 : 0.7,
                child: PlanCard(plan: plan, isActive: isActive),
              ),
            );
          });
        },
      ),
    );
  }
}
