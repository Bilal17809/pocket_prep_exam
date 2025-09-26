import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors.dart';
import '/pages/quiz_view_second/controller/quiz_controller.dart';
import '/core/common/loading_container.dart';
import '../view/quiz_view.dart';


class QuizStateHandler extends StatelessWidget {
  final PageController pageController;
  const QuizStateHandler({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final quizController = Get.find<QuizController>();
    return Obx(() {
      switch (quizController.state.value) {
        case QuizState.loading:
          return const LoadingContainer(
            backgroundColor: lightSkyBlue,
            indicatorColor: Colors.white,
            messageTextColor: kWhite,
            message: "Loading quiz...",
          );

        case QuizState.error:
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Failed to load quiz questions"),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => quizController.onInit(),
                    child: const Text("Retry"),
                  )
                ],
              ),
            ),
          );
        case QuizState.success:
          return QuizScaffold(
            quizController: quizController,
            pageController: pageController,
          );
      }
    });
  }
}
