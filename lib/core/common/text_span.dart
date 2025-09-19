
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonTextSpan extends StatelessWidget {
  final String labelOne;
  final String labelTwo;
  final Color backgroundColorOne;
  // final Color  backgroundColorTwo;
  final Color textColorOne;
  final Color textColorTwo;
  final double fontSize;
  final FontStyle? fontStyle;
  const CommonTextSpan({super.key,
   required this.labelOne,
    required this.labelTwo,
    this.backgroundColorOne = Colors.yellow,
    // this.backgroundColorTwo
    this.textColorOne = Colors.grey,
    this.textColorTwo = Colors.black,
    this.fontSize = 14,
    this.fontStyle
  });

  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: labelOne,
            style: context.textTheme.bodyMedium!.copyWith(
                fontSize: fontSize,
                color: textColorTwo,
                fontStyle: fontStyle,
                backgroundColor: backgroundColorOne,
              fontWeight: FontWeight.bold,
            )
          ),
          TextSpan(
            text: labelTwo,
            style: context.textTheme.bodyLarge!.copyWith(
                fontSize: fontSize,
                color: textColorOne,

                // backgroundColor: backgroundColorTwo,
                fontStyle: fontStyle
            )
          ),
        ],
      ),
    );
  }
}

