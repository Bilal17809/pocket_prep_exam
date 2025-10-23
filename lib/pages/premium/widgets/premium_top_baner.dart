import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors.dart';

class PremiumTopBanner extends StatelessWidget {
  const PremiumTopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.36,
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
            top: 36,
            right: 16,
            child: CircleAvatar(
              maxRadius: 18,
              backgroundColor: kWhite.withAlpha(50),
              child: IconButton(
                icon: const Icon(Icons.close, color: kWhite,size: 20,),
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
                      "Professional PocketPrep",
                      style: context.textTheme.headlineSmall!.copyWith(
                        color: kBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Unlock all premium features and functions. No Ads",
                  style:
                  context.textTheme.titleSmall!.copyWith(color: kBlack,fontSize: 11),
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
