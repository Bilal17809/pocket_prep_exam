import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/common_button.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import '../../questions/view/questions_view.dart';
import '../controller/quiz_builder_controller.dart';
import '../widgets/subject_selection.dart';
import '../widgets/time_picker.dart';

class QuizBuilderScreen extends StatelessWidget {
  const QuizBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizBuilderController>();

    return Scaffold(
      backgroundColor: kWhiteF7,
      appBar: AppBar(
        title: const Text("Custom Quiz Builder"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  "Choose subjects from the selected exam to build your quiz.",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                ImprovedExamSelectionWidget(),
                const SizedBox(height: 20),
                const TimePickerWidget(),
                const SizedBox(height: 26),
                Center(
                  child: Obx(() {
                    final hasTime =
                        controller.selectedTime.value != Duration.zero;
                    final hasSubjects = controller.selectedSubjects.isNotEmpty;
                    final hasQuestionCount =
                        controller.questionCountPerSubject.isNotEmpty;
                    final canStartQuiz =
                        hasTime && hasSubjects && hasQuestionCount;
                    return canStartQuiz
                        ? CommonButton(
                          title: "Start Quiz",
                          onTap: () async {
                            final allQuestionsForQuiz =
                                await controller.prepareQuizQuestions();
                            final totalSeconds =
                                controller.selectedTime.value.inSeconds;
                            Get.off(
                              () => QuizzesView(
                                allQuestion: allQuestionsForQuiz,
                                reviewMode: false,
                                isTimedQuiz: true,
                                timedQuizMinutes: totalSeconds,
                              ),
                            );
                          },
                        )
                        : HideCommonButton(title: "Start Quiz");
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
