import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/common_button.dart';
import 'package:pocket_prep_exam/core/constant/constant.dart';
import 'package:pocket_prep_exam/core/routes/routes_name.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import 'package:pocket_prep_exam/pages/quiz_setup/controller/quiz_setup_controller.dart';
import '../widgets/dificuty_selector.dart';
import '../widgets/options_chip.dart';

class QuizSetupView extends StatelessWidget {
  const QuizSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizSetupController>();
    return Scaffold(
      backgroundColor: kWhiteF7,
      appBar: AppBar(
        backgroundColor: kWhiteF7,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quiz", style: titleMediumStyle),
            Text(
              "Set up your quiz preferences",
              style: titleSmallStyle.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: roundedDecoration,
                child: Center(
                  child:Obx(() => Text(
                    controller.selectedSubject.value?.subjectName ?? "",
                    style: titleMediumStyle.copyWith(color: lightSkyBlue),
                  )),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: lightSkyBlue, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "⏳ Each question has its own timer. Be quick and stay focused!",
                      style: context.textTheme.titleMedium!.copyWith(
                        color: Colors.blueGrey.shade700,
                        fontSize: 13.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // const _SectionTitle(title: "Note: The timer applies to each question individually"),
            // const SizedBox(height: ),
            // DifficultySelector(),
            const SizedBox(height: 20),
            const _SectionTitle(title: "Select Time Limit : sec"),
            const SizedBox(height: 10),
            const _TimeLimitSelector(),
            const SizedBox(height: 20),
            const _SectionTitle(title: "Select Number of Questions"),
            const SizedBox(height: 10),
            const QuestionCountSelector(),
            const SizedBox(height: 20),
            const Text(
              "Note: If the quiz fails to load repeatedly, consider "
                  "changing the question limit, difficulty, or category.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 20),
            CommonButton(
              title: "Start Quiz",
              onTap: () {
                controller.clearQuiz();
                Get.toNamed(RoutesName.secondQuizView);
              },
            )

          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: titleMediumStyle.copyWith(fontSize: 22,fontWeight: FontWeight.normal));
  }
}

class _TimeLimitSelector extends StatelessWidget {
  const _TimeLimitSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizSetupController>();
    return Obx(() {
      final options = controller.timeOptions;
      return Padding(
        padding: const EdgeInsets.only(right: 80),
        child: Row(
          children: options.map((time) {
            final isSelected = controller.selectedTimeLimit.value == time;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: OptionChip(
                  label: "$time",
                  isSelected: isSelected,
                  onTap: () => controller.setTimeLimit(time),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }}

