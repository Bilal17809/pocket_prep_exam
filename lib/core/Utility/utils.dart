
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Utils {
  Utils._();
  static void showSuccess(String message) {
    _showSnackBar("Success", message, isSuccess: true);
  }
  static void showError(String message) {
    _showSnackBar("Error", message, isSuccess: false);
  }
  static void _showSnackBar(String title, String message, {bool isSuccess = false}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isSuccess ? const Color(0xFF4CAF50) : Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }
}