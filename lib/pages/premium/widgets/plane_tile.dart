import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/premium_controller.dart';
import '/core/theme/app_colors.dart';


class PlanTile extends StatelessWidget {
  final PlanModelForFree plan;
  final bool isSelected;
  final VoidCallback onTap;

  const PlanTile({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? kWhite.withAlpha(80)
              : kWhite.withAlpha(80),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? pinkAccent : grey,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? pinkAccent : kBlack,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.title,
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: kBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    plan.subtitle,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: kBlack,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? pinkAccent :grey,
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
      ),
    );
  }
}
