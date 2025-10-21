import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'common_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String positiveButtonText;
  final String negativeButtonText;
  final VoidCallback onPositiveTap;
  final VoidCallback? onNegativeTap;
  final Color color;

  const CustomDialog({
    super.key,
    this.color = lightSkyBlue,
    required this.title,
    required this.message,
    required this.positiveButtonText,
    required this.onPositiveTap,
    this.negativeButtonText = "Cancel",
    this.onNegativeTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Center(
        child: Text(
          title,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              message,
              style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          CommonButton(
            colorA: Colors.black,
            colorB: Colors.black,
            title: negativeButtonText,
            onTap: onNegativeTap ?? () => Get.back(),
          ),
          SizedBox(height: 16),
          CommonButton(
            colorA: color,
            title: positiveButtonText,
            onTap: onPositiveTap,
          ),
        ],
      ),
    );
  }

  // Original show method - purane code ke liye
  static void show({
    required String title,
    required String message,
    required String positiveButtonText,
    required VoidCallback onPositiveTap,
    String negativeButtonText = "Cancel",
    VoidCallback? onNegativeTap,
  }) {
    Get.dialog(
      CustomDialog(
        title: title,
        message: message,
        positiveButtonText: positiveButtonText,
        onPositiveTap: onPositiveTap,
        negativeButtonText: negativeButtonText,
        onNegativeTap: onNegativeTap,
      ),
    );
  }

  // NEW: Async method for proper dialog handling
  static Future<bool?> showAsync({
    required String title,
    required String message,
    required String positiveButtonText,
    String negativeButtonText = "Cancel",
    Color color = lightSkyBlue,
  }) async {
    return await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Center(
          child: Text(
            title,
            style: Get.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                message,
                style: Get.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 16
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            CommonButton(
              colorA: Colors.black,
              colorB: Colors.black,
              title: negativeButtonText,
              onTap: () => Get.back(result: false),
            ),
            CommonButton(
              colorA: color,
              title: positiveButtonText,
              onTap: () => Get.back(result: true),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}