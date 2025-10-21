
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

import '../common/custom_dialog.dart';


class Utils {
  Utils._();
  static final AudioPlayer _player = AudioPlayer();
  static final FlutterTts _flutterTts = FlutterTts();

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
  static Future<bool> leaveBottomSheet(
      BuildContext context,
      String title,
      String message, {
        String cancelText = "Cancel",
        String confirmText = "Leave",
        Color confirmColor = const Color(0xFF2196F3), // lightSkyBlue
        VoidCallback? onConfirm, // ✅ Reusable action
      }) async {
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                      child: Text(cancelText),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: confirmColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        if (onConfirm != null) onConfirm();
                      },
                      child: Text(confirmText),
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


  static Future<void> playSound(bool isCorrect) async {
    try {
      await _player.stop();
      await _player.play(
        AssetSource(isCorrect ? 'correctness.mp3' : 'ForWrong.mp3'),
      );
    } catch (e) {
      print("Audio play error: $e");
    }
  }
  static Future<void> speak(String text) async {
    try {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setSpeechRate(0.45);
      await _flutterTts.speak(text);
    } catch (e) {
      print("TTS error: $e");
    }
  }

  static Future<void> stopAll() async {
    try {
      await _player.stop();
      await _flutterTts.stop();
    } catch (e) {
      print("Stop audio error: $e");
    }
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