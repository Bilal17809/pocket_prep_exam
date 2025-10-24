import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/pages/premium/widgets/plane_card.dart';
import '../controller/premium_controller.dart';

// class PremiumPlansCarousel extends StatelessWidget {
//   final PremiumPlansController controller;
//   PremiumPlansCarousel({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Obx(() {
//       if (controller.isLoading.value) {
//       return SizedBox();
//       }
//       if (controller.plan.isEmpty) {
//         return const Center(
//           child: Text(
//             "No plans available",
//             style: TextStyle(fontSize: 14),
//           ),
//         );
//       }
//       return SizedBox(
//         height: height * 0.15,
//         width: width * 0.74,
//         child: PageView.builder(
//           controller: controller.pageController,
//           itemCount: controller.plans.length,
//           clipBehavior: Clip.none,
//           onPageChanged: controller.onPageChanged,
//           itemBuilder: (context, index) {
//             final plan = controller.plans[index];
//             return Obx(() {
//               final isActive = index == controller.currentPage.value;
//               return AnimatedScale(
//                 duration: const Duration(milliseconds: 350),
//                 scale: isActive ? 1.05 : 0.92,
//                 child: AnimatedOpacity(
//                   duration: const Duration(milliseconds: 350),
//                   opacity: isActive ? 1.0 : 0.7,
//                   child: PlanCard(plan: plan, isActive: isActive),
//                 ),
//               );
//             });
//           },
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/pages/premium/widgets/plane_card.dart';
import '../controller/premium_controller.dart';
import '/core/theme/app_colors.dart';

class PremiumPlansCarousel extends StatelessWidget {
  final PremiumPlansController controller;
  const PremiumPlansCarousel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox();
      }

      if (controller.plans.isEmpty) {
        return const Center(
          child: Text(
            "No plans available",
            style: TextStyle(fontSize: 14),
          ),
        );
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: height * 0.15,
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
                      // child: PlanCard(plan: plan, isActive: isActive),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      );
    });
  }
}

