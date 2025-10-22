import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/term_of_services/view/term_services_view.dart';
import '../widgets/plane_tile.dart';
import '../widgets/premium_top_baner.dart';
import '/core/common/common_button.dart';
import '/core/theme/app_colors.dart';
import '../controller/premium_controller.dart';
import '../widgets/premium_plans_carousel.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PremiumPlansController>();
    return Scaffold(
      backgroundColor: kWhiteF7,
      body: Column(
        children: [
          const PremiumTopBanner(),
          SizedBox(height:16),
          const PremiumPlansCarousel(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                  final plans = controller.plan;
                  final selected = controller.selectedIndex.value;
                  return ListView.separated(
                    itemCount: plans.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      final plan = plans[index];
                      final isSelected = selected == index;
                      return PlanTile(
                        plan: plan,
                        isSelected: isSelected,
                        onTap: () async {
                          final selected = controller.selectedPlan;
                          final product = controller.purchaseService.products.firstWhere(
                                (p) => p.id == selected.productId,
                          );
                          await controller.purchaseService.buyProduct(product, null, context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: CommonButton(
          //     title: "Upgrade to premium",
          //     onTap: () {
          //       final selected = controller.selectedPlan;
          //       Get.snackbar(
          //         "Selected Plan",
          //         selected.title,
          //         snackPosition: SnackPosition.BOTTOM,
          //       );
          //     },
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                _BottomLink(text: "How to cancel",onTap: (){},),
                // _BottomLink(text: "Restore Purchase"),
                _BottomLink(text: "Terms & Conditions",onTap: (){Get.to(() => TermServicesView());},),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _BottomLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _BottomLink({required this.text,required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: context.textTheme.bodySmall!.copyWith(
            color: kBlue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

