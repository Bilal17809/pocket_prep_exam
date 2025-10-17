import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors.dart';

class PremiumTopBanner extends StatelessWidget {
  const PremiumTopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.38,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(decoration: BoxDecoration(color: lightSkyBlue)),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [kWhiteF7.withAlpha(0), kWhiteF7],
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
            top: height * 0.29,
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
                        fontSize: 20,
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
                  style:
                  context.textTheme.titleSmall!.copyWith(color: kBlack,fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
