import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/app_divider.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/controller/edite_subject_controller.dart';



class SubjectsList extends StatelessWidget {
  const SubjectsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditeSubjectController>();
    return Obx(() {
      final exam = controller.selectedExam.value;
      if (exam == null) {
        return const Center(child: Text("No Exam Found"));
      }
      return Expanded(
        child: Container(
          decoration: roundedDecoration.copyWith(
            border: Border.all(color: greyColor.withAlpha(100), width: 0.6),
          ),
          child: ListView.separated(
            itemCount: exam.subjects.length + 1,
            separatorBuilder: (context, index) => AppDivider(
              thickness: 0.6,
              height: 1,
              color: greyColor.withAlpha(100),
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                final totalSubjects = exam.subjects.length;
                final selectedCount = controller.selectedSubjectIds.length;
                final allSelected = selectedCount == totalSubjects;
                final noneSelected = selectedCount == 0;
                String titleText;
                if (noneSelected) {
                  titleText = "No subject selected";
                } else if (allSelected) {
                  titleText = "All subjects selected ($selectedCount of $totalSubjects)";
                } else {
                  titleText = "Subjects selected  ($selectedCount of $totalSubjects)";
                }
                return ListTile(
                  title: Text(
                    titleText,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: const Icon(Icons.book_online_outlined),
                  trailing: Checkbox(
                    activeColor: Colors.blue,
                    tristate: true,
                    value: noneSelected
                        ? false
                        : (allSelected ? true : null),
                    onChanged: (_) => controller.toggleAllSubjects(),
                  ),
                );
              }
              final subject = exam.subjects[index - 1];
              return Obx(() {
                final isSelected = controller.selectedSubjectIds.contains(subject.subjectId);
                return ListTile(
                  title: Text(
                    subject.subjectName,
                    style: context.textTheme.titleMedium!.copyWith(color: isSelected ? lightSkyBlue : kBlack),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Checkbox(
                    activeColor: Colors.black,
                    value: isSelected,
                    onChanged: (_) => controller.toggleSubject(subject.subjectId),
                  ),
                );
              });
            },
          ),
        ),
      );
    });
  }
}

