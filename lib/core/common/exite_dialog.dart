import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

class CustomDialogForExitAndWarning extends StatelessWidget {
  final String title;
  final String message;
  final String positiveButtonText;
  final VoidCallback onPositiveTap;
  final String? negativeButtonText;
  final VoidCallback? onNegativeTap;
  final bool isWarning;
  const CustomDialogForExitAndWarning({
    super.key,
    required this.title,
    required this.message,
    required this.positiveButtonText,
    required this.onPositiveTap,
    this.negativeButtonText,
    this.onNegativeTap,
    this.isWarning = true,
  });
  static void show({
    required String title,
    required String message,
    required String positiveButtonText,
    required VoidCallback onPositiveTap,
    String? negativeButtonText,
    VoidCallback? onNegativeTap,
    bool isWarning = true,
  }) {
    Get.dialog(
      CustomDialogForExitAndWarning(
        title: title,
        message: message,
        positiveButtonText: positiveButtonText,
        onPositiveTap: onPositiveTap,
        negativeButtonText: negativeButtonText,
        onNegativeTap: onNegativeTap,
        isWarning: isWarning,
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 32,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            margin: const EdgeInsets.only(top: 60),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 8.0),
                Text(
                  title,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold
                  )
                ),
                const SizedBox(height: 10.0),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontSize: 14,
                    color: Colors.grey
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (negativeButtonText != null) ...[
                      _ExitButtons(buttonText: negativeButtonText!,
                        onTap: onNegativeTap ?? () => Get.back(),
                        color: kBlack,),
                      const SizedBox(width: 10),
                    ],
                    _ExitButtons(
                        buttonText:
                    positiveButtonText,
                      color: isWarning ? kRed : lightSkyBlue,
                      onTap: onPositiveTap ?? () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            child: Container(
              decoration: const BoxDecoration(
                color: kWhite,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: CircleAvatar(
                  backgroundColor: isWarning ? Colors.red : Colors.amber,
                  radius: 45,
                  child: Icon(
                    isWarning ? Icons.help_outline : Icons.warning,
                    color: isWarning ?  kWhite :kWhite ,
                    size: isWarning ?  80 : 60,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 70,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.close,
                  color: kWhite,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExitButtons extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Color? color;
  const _ExitButtons({super.key,required this.buttonText,required this.onTap,this.color});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: GestureDetector(
        onTap:onTap,
        child: Container(
          height: 38,
          decoration: BoxDecoration(
            color:color,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
           buttonText,
            style: const TextStyle(
              fontSize: 14,
              color: kWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
