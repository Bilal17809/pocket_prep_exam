import 'package:flutter/cupertino.dart';
import 'package:pocket_prep_exam/pages/switch_exam/controller/switch_exam_cont.dart';
import 'package:pocket_prep_exam/pages/switch_exam/widget/exam_detail.dart';

class ExamList extends StatelessWidget {
  final SwitchExamController controller;
  const ExamList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
            itemCount: controller.exam.length,
            itemBuilder: (context, index) {
              final data = controller.exam[index];
              return GestureDetector(
                onTap: () => controller.selectedExam(index),
                child: ExamDetail(data: data, index: index),
              );
            },
          ),
    );
  }
}
