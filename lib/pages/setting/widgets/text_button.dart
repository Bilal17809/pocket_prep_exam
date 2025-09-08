import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors.dart';

class ButtonText extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const ButtonText({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: kBlue.withOpacity(0.2), // Optional: Customize the splash color
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Align(
          alignment: Alignment.centerLeft, // Align the text to the left
          child: Text(
            title,
            style: context.textTheme.bodySmall!.copyWith(
              color: kBlue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
