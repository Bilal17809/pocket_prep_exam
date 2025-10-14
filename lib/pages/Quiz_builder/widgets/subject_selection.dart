import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import '../controller/quiz_builder_controller.dart';

class ImprovedExamSelectionWidget extends StatelessWidget {
  const ImprovedExamSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizBuilderController>();

    return Obx(() {
      final exam = controller.exams.value;
      if (exam == null) {
        return const Center(child: Text("No exam selected"));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.selectedExams.map((exam) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(06),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: ExpansionTile(
              initiallyExpanded: false,
              title: Text(
                exam.examName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "Select subjects from this exam",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              children: exam.subjects.map((subject) {
                final isSubjectSelected =
                controller.selectedSubjects.contains(subject);
                final totalQuestions =
                controller.getQuestionCountBySubject(subject.subjectId);

                return Container(
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color:
                      isSubjectSelected ? Colors.blue : Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        dense: false,
                        title: Text(
                          subject.subjectName,
                          style: const TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          "Total Questions: $totalQuestions",
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade700),
                        ),
                        value: isSubjectSelected,
                        activeColor: Colors.blue,
                        onChanged: (_) =>
                            controller.toggleSubjectSelection(subject),
                      ),

                      if (isSubjectSelected)
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(16, 0, 16, 12),
                          child: Row(
                            children: [
                              const Text(
                                "Questions:",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Enter count",

                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightSkyBlue),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withAlpha(120)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: lightSkyBlue)
                                    ),
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      controller.setQuestionCount(
                                        subject.subjectId,
                                        int.parse(value),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      );
    });
  }
}
