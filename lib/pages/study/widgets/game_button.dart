
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_prep_exam/pages/premium/view/premium_screen.dart';
import '/core/theme/app_styles.dart';

class GameButton extends StatelessWidget {
  const GameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(() => PremiumScreen());
      },
      child: Container(
        margin: const EdgeInsets.all(04),
        padding: const EdgeInsets.all(12),
        decoration: roundedDecoration.copyWith(
            color: Colors.blue.shade400,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Lottie.asset("assets/premium.json",
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
                      "Upgrade to premium!",
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Unlock full learning experience ✨",
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
  }
}
