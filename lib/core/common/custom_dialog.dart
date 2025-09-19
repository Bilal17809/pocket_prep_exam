import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String positiveButtonText;
  final String negativeButtonText;
  final VoidCallback onPositiveTap;
  final VoidCallback? onNegativeTap;

  const CustomDialog({
    super.key,
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
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          CommonButton(
            title: negativeButtonText,
            onTap: onNegativeTap ?? () => Get.back(),
          ),
          CommonButton(
            title: positiveButtonText,
            onTap: onPositiveTap,
          ),
        ],
      ),
    );
  }

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
}
