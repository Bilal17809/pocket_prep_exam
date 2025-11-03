import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import 'package:pocket_prep_exam/pages/premium/view/premium_screen.dart';
import '/core/theme/app_styles.dart';

class SetPurchaseCard extends StatelessWidget {
  const SetPurchaseCard({super.key});
  @override
  Widget build(BuildContext context) {
    final premium = Get.find<RemoveAds>();

    return Obx(() {
      final subscribed = premium.isSubscribedGet.value;
      return InkWell(
        onTap: () {
          if (!subscribed) {
            Get.to(() => const PremiumScreen());
          }
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(12),
          decoration: roundedDecoration.copyWith(
            color: subscribed ? Colors.green.shade400 : Colors.blue.shade400,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Lottie.asset(
                    "assets/premium.json",
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                    repeat: true,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subscribed
                            ? "Premium Activated 🎉"
                            : "Upgrade to Premium!",
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subscribed
                            ? "Enjoy full learning access ✨"
                            : "Unlock full learning experience ✨",
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
