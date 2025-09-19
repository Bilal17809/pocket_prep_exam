
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_theme.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
 // final Color color;
   CommonButton({super.key,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: bodySmallWH,horizontal: 32),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height * 0.07,
          // width: width * 0.60,
          decoration: AppTheme.buttonDecoration,
          child: Center(
            child: Text(title,style: context.textTheme.bodyLarge!.copyWith(
                color: kWhite,
                fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
    );
  }
}

class HideCommonButton extends StatelessWidget {
  const HideCommonButton ({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: bodySmallWH,horizontal: 32),
      child: Container(
        height: height * 0.07,
        // width: width * 0.60,
        decoration: AppTheme.buttonDecoration.copyWith(
          color: Colors.blue.withAlpha(120)
        ),
        child: Center(
          child: Text("Switch Exam",style: context.textTheme.bodyLarge!.copyWith(
              color: kWhite,
              fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}
