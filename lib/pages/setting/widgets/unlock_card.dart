import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/pages/premium/view/premium_screen.dart';
import '/core/theme/theme.dart';
import '/core/common/common_button.dart';

class UnlockProCard extends StatelessWidget {
  final VoidCallback? onTap;
  const UnlockProCard({super.key, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 03),
      decoration: roundedDecoration.copyWith(
        color: lightSkyBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text(
            "Unlock Pro Features!",
            style: titleSmallStyle.copyWith(color: kWhite, fontSize: 16),
          ),
          SizedBox(height: 04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _FeatureText("✓  No Ads anymore."),
                  _FeatureText("✓  Access to All features."),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kWhite.withAlpha(60),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.white,
                  size: 42,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CommonButton(
            title: "Upgrade to premium",
            onTap: () {
              Get.to(() => PremiumScreen());
            },
            colorA: kWhite,
            colorB: kWhite,
            textColor: Color(0xFFFF4D4D),
            useTextShadow: false,
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}

class _FeatureText extends StatelessWidget {
  final String text;
  const _FeatureText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: bodyMediumStyle.copyWith(
          color: kWhite,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
