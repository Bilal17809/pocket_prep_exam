
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

import '../common/custom_dialog.dart';


class Utils {
  Utils._();
  static void showSuccess(String message,String title) {
    _showSnackBar(title ?? "Success", message, isSuccess: true,showBottom: true);
  }
  static void showError(String message,String title) {
    _showSnackBar(title ?? "Error", message, isSuccess: false,showBottom: true);
  }
  static void _showSnackBar(String title, String message, {bool isSuccess = false,bool showBottom = false}) {
    Get.snackbar(
      title,
      message,
      snackPosition: showBottom ? SnackPosition.BOTTOM : SnackPosition.TOP,
      backgroundColor: isSuccess ? const Color(0xFF4CAF50).withAlpha(100) : Colors.red.withAlpha(100),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }
  static Future<bool> leaveBottomSheet(BuildContext context, String message) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Leave Quiz? ⚠️",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
               Text(
               message,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightSkyBlue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Leave"),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
    return result ?? false;
  }

  static String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return minutes > 0 ? "${minutes}m ${secs}s" : "${secs}s";
  }

  static Future<void> showLeaveQuizDialog({
    required bool isTimedQuiz,
    required int answered,
    required int totalQuestions,
    required VoidCallback onLeave,
  }) async {
    if (isTimedQuiz) {
      CustomDialog.show(
        title: "Leave Quiz?",
        message: "You've answered $answered questions but you still have more time",
        positiveButtonText: "Leave Quiz",
        onPositiveTap: onLeave,
        negativeButtonText: "Cancel",
        onNegativeTap: () => Get.back(),
      );
    } else {
      CustomDialog.show(
        title: "Leave Quiz?",
        message:
        "You've answered $answered of $totalQuestions questions. If you leave now, your progress will be lost.",
        positiveButtonText: "Leave Quiz",
        onPositiveTap: onLeave,
        negativeButtonText: "Cancel",
        onNegativeTap: () => Get.back(),
      );
    }
  }
}