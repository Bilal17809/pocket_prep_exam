import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/common/back_button.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color bottomLineColor;
  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.bottomLineColor = const Color(0xFF87CEFA), // lightSkyBlue
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      leading: CommonBackButton(
        size: 26, // button ka actual circle size
        iconSize: 20,
        backgroundColor: lightSkyBlue,
      ),


      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(
          color: bottomLineColor,
          height: 2.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 2);
}
