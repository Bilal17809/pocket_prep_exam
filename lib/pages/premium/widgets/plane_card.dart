import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';
import '../controller/premium_controller.dart';

class PlanCard extends StatelessWidget {
  final PlanModel plan;
  final bool isActive;
  const PlanCard({
    super.key,
    required this.plan,
    required this.isActive,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: kBlack.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
        border: Border.all(
          color: isActive ? kWhite : kWhite,
          width: isActive ? 1.8 : 1,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -12,
            left: -12,
            child: Image.asset(
              plan.duration,
              height: 34,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  plan.type,
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 06),
                Text(
                  plan.price,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: kBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
