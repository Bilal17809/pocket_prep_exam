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
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 04),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height:05),
            Image.asset(
              plan.type,
              height:60,
              fit: BoxFit.contain,
            ),
            SizedBox(height:5,),
            Text(
              plan.features.join('\n'),
              style: theme.textTheme.titleMedium!.copyWith(
                color: kBlack,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}



