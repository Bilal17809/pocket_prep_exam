
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors.dart';


class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color colorA;
  final Color colorB;
  final Color textColor;
   final IconData? icon;
   final bool isIcon;
  final  bool useTextShadow;
   const CommonButton({super.key, required this.title, required this.onTap,
     this.useTextShadow = true,
     this.textColor = kWhite,
    this.colorA = lightSkyBlue,
     this.colorB = lightSkyBlue,
     this.icon,
     this.isIcon = false
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.06,
        width: double.infinity,
        decoration: BoxDecoration(
      color: colorA,
          borderRadius: BorderRadius.circular(08),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.25),
          //     offset: const Offset(3, 3),  // right-bottom shadow
          //     blurRadius: 4,
          //   ),
          // ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(isIcon)
              Icon(icon,size: 16,color: kWhite,),
              if(isIcon)
              SizedBox(width: 04),
              Text(
                title,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  shadows: useTextShadow ? [
                     Shadow(
                      blurRadius: 3,
                      color: Colors.black45,
                      offset: Offset(1, 1),
                    ),
                  ]:[]
                ),
              ),
            ],
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
    return Container(
      height: height * 0.06,
      width: double.infinity,
      decoration: BoxDecoration(
      color: lightSkyBlue.withAlpha(120),
        borderRadius: BorderRadius.circular(08),
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
    );
  }
}
