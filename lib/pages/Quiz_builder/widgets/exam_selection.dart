import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quiz_builder_controller.dart';

class ExamSelectionWidget extends StatelessWidget {
  const ExamSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizBuilderController>();

    return Obx(() {
      if (controller.exams.isEmpty) {
        return const Center(child: Text("No exams available"));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.exams.map((exam) {
          final isSelected = controller.selectedExams.contains(exam);
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(06),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.15),
              //     blurRadius: 8,
              //     offset: const Offset(0, 3),
              //   ),
              // ],
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                width: 1.2,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => controller.toggleExamSelection(exam),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? Colors.blue : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? Colors.blue
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(Icons.check,
                          color: Colors.white, size: 16)
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exam.examName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color:
                              isSelected ? Colors.blue.shade800 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${exam.subjects.length} subjects  •  ${exam.totalQuestions} questions",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
