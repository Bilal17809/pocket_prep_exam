
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '/core/theme/app_styles.dart';

class GameButton extends StatelessWidget {
  const GameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    "Noun Kingdom Awakens!",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Learn Grammar by Game",
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
    );
  }
}
