import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/local_storage/storage_helper.dart';
import '/pages/term_of_services/view/term_services_view.dart';
import '../widgets/plane_tile.dart';
import '../widgets/premium_top_baner.dart';
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
          const SizedBox(height: 12),
          PremiumPlansCarousel(controller: controller),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Obx(() {
                      final plans = controller.plan;
                      final selected = controller.selectedIndex.value;

                      if (controller.isLoading.value) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: CircularProgressIndicator(
                              color: Colors.pinkAccent,
                            ),
                          ),
                        );
                      }

                      if (plans.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Text("No plans available"),
                          ),
                        );
                      }

                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 8, top: 18),
                        itemCount: plans.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (_, index) {
                          final plan = plans[index];
                          final isSelected = selected == index;

                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              PlanTile(
                                plan: plan,
                                isSelected: isSelected,
                                onTap: () => controller.selectPlan(index),
                              ),
                              if (index == 0)
                                Positioned(
                                  top: -32,
                                  right: 4,
                                  child: Image.asset(
                                    'images/special-tag.png',
                                    height: 52,
                                    width: 52,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                            ],
                          );
                        },
                      );
                    }),
                    const SizedBox(height: 12),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return ProfileShimmerLoader();
                      }

                      final selected = controller.selectedPlan;

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: selected == null
                            ? null
                            : () async {
                          final product = controller.purchaseService.products.firstWhere(
                                (p) => p.id == selected.productId,
                          );
                          await controller.purchaseService.buyProduct(product, null, context);
                        },
                        child: Text(
                          selected == null ? 'Select a Plan' : 'Purchase Premium',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _BottomLink(
                  text: "How to cancel",
                  onTap: () => controller.cancelAnyTime(),
                ),
                _BottomLink(
                  text: "Terms & Conditions",
                  onTap: () => Get.to(() => TermServicesView()),
                ),

                TextButton(
                  onPressed: () async {
                    await Get.find<RemoveAds>().setSubscriptionStatus(true);
                  },
                  child: const Text("Activate Test Premium"),
                ),

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

  const _BottomLink({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: context.textTheme.bodySmall!.copyWith(
          color: kBlue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}




class ProfileShimmerLoader extends StatelessWidget {
  const ProfileShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Shimmer.fromColors(
          baseColor:Colors.grey.shade200,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height:60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height:20),
              Container(
                height:60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              const SizedBox(height:20),
              Container(
                height:60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }

}