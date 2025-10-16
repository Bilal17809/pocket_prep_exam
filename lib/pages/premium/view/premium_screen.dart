import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/plane_card.dart';
import '/core/common/common_button.dart';
import '/core/theme/app_colors.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final List<PlanModel> plans = [
      PlanModel("Free 3 Days", "Weekly / \$2.99", "58% OFF", true),
      PlanModel("Free 7 Days", "Monthly / \$4.99", "64% OFF", false),
    ];

    return Scaffold(
      backgroundColor: kWhiteF7,
      body: Column(
        children: [
          /// 🔹 Top Banner Section
          SizedBox(
            height: height * 0.38,
            child: Stack(
              fit: StackFit.expand,
              children: [
                /// Background color
                const DecoratedBox(
                  decoration: BoxDecoration(
                    color: lightSkyBlue,
                  ),
                ),

                /// Gradient overlay (fade from transparent → white)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        kWhiteF7.withAlpha(00),
                        kWhiteF7,
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "images/premiumpic.png",
                    height: 248,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: kWhite.withOpacity(0.2),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: kWhite),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pocket Prep",
                            style: context.textTheme.headlineSmall!.copyWith(
                              color: kBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: kBlack,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Pro",
                              style: context.textTheme.titleSmall!.copyWith(
                                color: kWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Unlock all premium features\nand functions. No Watermark, No Ads",
                        style: context.textTheme.titleSmall!
                            .copyWith(color: kBlack),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PremiumPlansCarousel(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemCount: plans.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, index) {
                  final plan = plans[index];
                  return _PlanTile(plan: plan);
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CommonButton(
              title: "Start 7 Days Free Trial",
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _BottomLink(text: "How to cancel"),
                _BottomLink(text: "Restore Purchase"),
                _BottomLink(text: "Privacy Policy"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlanModel {
  final String title;
  final String subtitle;
  final String discount;
  final bool isSelected;
  PlanModel(this.title, this.subtitle, this.discount, this.isSelected);
}


class _PlanTile extends StatelessWidget {
  final PlanModel plan;
  const _PlanTile({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: plan.isSelected ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: plan.isSelected ? Colors.pinkAccent : grey,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            plan.isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: plan.isSelected ? Colors.pinkAccent : kBlack,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plan.title, style: context.textTheme.bodyLarge!.copyWith(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                )),
                const SizedBox(height: 2),
                Text(plan.subtitle, style: context.textTheme.bodyMedium!.copyWith(
                  color: kBlack,
                )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.pinkAccent.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              plan.discount,
              style: context.textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _BottomLink extends StatelessWidget {
  final String text;
  const _BottomLink({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        text,
        style: context.textTheme.bodySmall!.copyWith(
          color: kBlack,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
