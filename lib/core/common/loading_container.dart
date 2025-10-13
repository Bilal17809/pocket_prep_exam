import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../theme/app_colors.dart';

class LoadingContainer extends StatelessWidget {
  final Color? backgroundColor;
  final Color? indicatorColor;
  final String? message;
  final Color? messageTextColor;

  const LoadingContainer({
    super.key,
    this.backgroundColor,
    this.indicatorColor,
    this.message,
    this.messageTextColor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: indicatorColor ?? Theme.of(context).primaryColor,
            ),
            if (message != null) ...[
              const SizedBox(height: 12),
              Text(
                message!,
                style:  TextStyle(fontSize: 16,color: messageTextColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}



class LoadingDialog extends StatelessWidget {
  final String? message;
  const LoadingDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
         width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: Colors.blueAccent,
                strokeWidth: 3,
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  message ?? "Loading...",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  static void show({String? message}) {
    Get.dialog(
      LoadingDialog(message: message),
      barrierDismissible: false,
    );
  }

  static void hide() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}
