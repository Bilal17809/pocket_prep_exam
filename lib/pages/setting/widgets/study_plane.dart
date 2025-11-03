import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/premium/view/premium_screen.dart';
import 'package:pocket_prep_exam/pages/setting/widgets/show_detail.dart';
import '../../../ad_manager/remove_ads.dart';
import '../../../core/constant/constant.dart';
import '/core/theme/app_theme.dart';
import '/core/theme/app_colors.dart';

class StudyPlane extends StatelessWidget {
  const StudyPlane({super.key});

  @override
  Widget build(BuildContext context) {
    final premium = Get.find<RemoveAds>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "Study Plan",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: grey),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: AppTheme.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Free $AppFirstName $AppLastName",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: kBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  final isSubscribed = premium.isSubscribedGet.value;
                  return ClickableDividerRow(
                    title: isSubscribed
                        ? "Premium Activated 🎉"
                        : "Upgrade to Premium",
                    onTap: () {
                      if (!isSubscribed) {
                        Get.to(() => PremiumScreen());
                      }
                    },
                  );
                }),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final Widget widget;
  const ReusableRow({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget,
          const Icon(Icons.arrow_forward_ios, color: lightSkyBlue, size: 20),
        ],
      ),
    );
  }
}
