import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/data/models/exams_and_subject.dart';
import '../control/questions_controller.dart';


class QuestionScreen extends StatelessWidget {
  final Subject subject;

  const QuestionScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionController());
    controller.loadQuestions(subject.subjectId);

    return Scaffold(
      appBar: AppBar(title: Text(subject.subjectName)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.questions.isEmpty) {
          return const Center(child: Text('No questions found'));
        }

        return ListView.builder(
          itemCount: controller.questions.length,
          itemBuilder: (context, index) {
            final q = controller.questions[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Q${index + 1}: ${q.questionText}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ...q.options.map((opt) => ListTile(
                      title: Text(opt),
                      leading: Radio<String>(
                        groupValue: q.correctAnswer,
                        value: opt.substring(0, 1),
                        onChanged: null, // static preview
                      ),
                    )),
                    const SizedBox(height: 5),
                    Text('Explanation: ${q.explanation}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    Text('Reference: ${q.reference}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
