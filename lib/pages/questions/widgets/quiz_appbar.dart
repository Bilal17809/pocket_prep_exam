import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/questions/control/questions_controller.dart';

class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  final QuestionController controller;
  final int totalQuestions;
  final String tabTitle;
  const QuizAppBar({
    super.key,
    required this.controller,
    required this.totalQuestions,
    required this.tabTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final current = controller.currentPage.value + 1;
      return AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "$current/$totalQuestions",
              style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
        backgroundColor: const Color(0xFF1E90FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        centerTitle: false,
        title: Text(
          tabTitle,
          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18),
        ),
      );
    });
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
