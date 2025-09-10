
import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

class AppDivider extends StatelessWidget {
  final double thickness;
  final double indent;
  final double endIndent;
  final double height;
  final Color color;

  const AppDivider({
    super.key,
    this.height = 9.0,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.color = greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color,
    );
  }
}