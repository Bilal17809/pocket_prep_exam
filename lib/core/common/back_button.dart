import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

class CommonBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;
  final IconData icon;

  const CommonBackButton({
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.icon = Icons.arrow_back_ios_new_rounded,
    this.size = 20,
    this.iconSize = 26,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTap ?? () => Get.back(),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: backgroundColor ?? lightSkyBlue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: iconColor ?? Colors.white,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
