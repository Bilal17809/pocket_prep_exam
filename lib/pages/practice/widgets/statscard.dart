
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';

class StatsCard extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onTap;
  const StatsCard({super.key,this.color = lightSkyBlue,this.text = "Empty",this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: roundedDecoration.copyWith(
            color: color
          ),
          child: Center(
            child: Text(text,style: context.textTheme.titleLarge!.copyWith(
          fontSize: 20,
              color: kWhite,
                fontWeight: FontWeight.bold
            ),
            ),
          ),
        ),
      ),
    );
  }
}
