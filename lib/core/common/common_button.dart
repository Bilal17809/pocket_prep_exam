
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CommonButton({super.key,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: bodySmallWH),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height * 0.06,
          width: width * 0.60,
          decoration: BoxDecoration(
              color: kBlue,
              borderRadius: BorderRadius.circular(22)
          ),
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
      padding:  EdgeInsets.symmetric(vertical: bodySmallWH),
      child: Container(
        height: height * 0.06,
        width: width * 0.60,
        decoration: BoxDecoration(
            color: kBlue.withAlpha(100),
            borderRadius: BorderRadius.circular(22)
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
