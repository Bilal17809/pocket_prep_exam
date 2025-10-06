import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/common_button.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import '../controller/quiz_builder_controller.dart';
import '../widgets/exam_selection.dart';
import '../widgets/subject_selection.dart';
import '../widgets/time_picker.dart';
import '../../../services/exam_and_subjects_services.dart';
import '../../../services/questions_services.dart';

class QuizBuilderScreen extends StatelessWidget {
  const QuizBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(QuizBuilderController(
      examService: ExamService(),
      questionService: QuestionService(),
    ));

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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                "Chose one or more exams to include in your quiz",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              const ExamSelectionWidget(),
              const SizedBox(height: 20),
              if (controller.selectedExams.isNotEmpty)
                const Text("Select Subjects:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
              ImprovedExamSelectionWidget(),
              // const Text("Select Exams:"),
              //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

              // const Divider(height: 30),
              //
              // if (controller.selectedExams.isNotEmpty) ...[
              //   const Text("Select Subjects:",
              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              //   const SizedBox(height: 8),
              //   const SubjectSelectionWidget(),
              //   const SizedBox(height: 16),
              //   const QuestionCountWidget(),
                const SizedBox(height: 16),
                const TimePickerWidget(),
                const SizedBox(height: 24),
                Center(
                  child: CommonButton(title: "Start Quiz", onTap:(){})
                ),
              // ]
            ],
          ),
        );
      }),
    );
  }
}
