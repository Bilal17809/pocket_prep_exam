

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';


class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CommonButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: bodySmallWH, horizontal: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height * 0.07,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                lightSkyBlue.withOpacity(0.9),
                lightSkyBlue,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(40),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.25),
            //     offset: const Offset(3, 3),  // right-bottom shadow
            //     blurRadius: 4,
            //   ),
            // ],
          ),
          child: Center(
            child: Text(
              title,
              style: context.textTheme.bodyLarge!.copyWith(
                color: kWhite,
                fontWeight: FontWeight.bold,
                shadows: [
                  const Shadow(
                    blurRadius: 3,
                    color: Colors.black45,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HideCommonButton extends StatelessWidget {
  final String title;

  const HideCommonButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: bodySmallWH, horizontal: 10),
      child: Container(
        height: height * 0.07,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              lightSkyBlue.withOpacity(0.4), // lighter disabled look
              lightSkyBlue.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15), // softer shadow
              offset: const Offset(2, 2),
              blurRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: context.textTheme.bodyLarge!.copyWith(
              color: Colors.white.withOpacity(0.7), // faded text
              fontWeight: FontWeight.bold,
              shadows: const [
                Shadow(
                  blurRadius: 2,
                  color: Colors.black26,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
