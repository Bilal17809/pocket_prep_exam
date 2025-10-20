import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common/constant.dart';
import '/core/theme/app_colors.dart';

class ButtonText extends StatelessWidget {
  final String title;
  final Color color;
  const ButtonText({super.key, required this.title,this.color = lightSkyBlue});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: context.textTheme.bodySmall!.copyWith(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
