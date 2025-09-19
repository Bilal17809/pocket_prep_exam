
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';


class Utils{
  Future<void> snackBarMessage(String errorORSuccess,String message,{bool isSuccess = false})async{
    Get.snackbar(
      errorORSuccess,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isSuccess ?  Color(0xFF4CAF50) : kRed,
      colorText: const Color(0xFFFFFFFF),
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }
}