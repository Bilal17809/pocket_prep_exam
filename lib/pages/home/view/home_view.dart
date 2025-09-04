import 'package:flutter/material.dart';

import '/pages/home/control/home_control.dart';
import '../../questions/view/questions_view.dart';
import 'package:get/get.dart';

class ExamAndSubjectScreen extends StatelessWidget {
  const ExamAndSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExamAndSubjectController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Exams & Subjects')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.exams.isEmpty) {
          return const Center(child: Text('No exams available'));
        }

        return ListView.builder(
          itemCount: controller.exams.length,
          itemBuilder: (context, examIndex) {
            final exam = controller.exams[examIndex];
            return Card(
              margin: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.examName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('Subjects: ${exam.totalSubjects}'),
                    Text('Questions: ${exam.totalQuestions}'),
                    const SizedBox(height: 10),
                    const Text('Subjects:', style: TextStyle(fontWeight: FontWeight.bold)),
                    ListView.builder(
                      itemCount: exam.subjects.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, subjectIndex) {
                        final subject = exam.subjects[subjectIndex];
                        return ListTile(
                          dense: true,
                          leading: CircleAvatar(radius: 12, child: Text('${subject.subjectId}')),
                          title: Text(subject.subjectName),
                          onTap: () {
                            Get.to(() => QuestionScreen(subject: subject));
                          },

                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}



