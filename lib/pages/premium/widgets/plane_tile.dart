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
    final priceMatch = RegExp(r'/\s*Rs\.?\s*[\d,]+(?:\.00)?').firstMatch(plan.subtitle);
    final price = priceMatch?.group(0)?.replaceAll('/', '').trim() ?? '';
    final cleanedSubtitle = plan.subtitle
        .replaceAll(RegExp(r'/\s*Rs\.?\s*[\d,]+(?:\.00)?'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: kWhite.withAlpha(80),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? pinkAccent : grey,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    plan.title,
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: kBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (price.isNotEmpty)
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 08, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? pinkAccent : grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      price,
                      style: context.textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              cleanedSubtitle,
              style: context.textTheme.headlineSmall!.copyWith(
                color: kBlack,
                fontSize: 12,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
    );
  }
}
