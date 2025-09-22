import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/controller/edite_subject_controller.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/view/subjects_edite_view.dart';
import 'package:pocket_prep_exam/pages/exam_settings/controller/exam_setting_controller.dart';
import '/core/common/app_divider.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_theme.dart';
import '../../setting/widgets/text_button.dart';

class Details extends StatelessWidget {

  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExamSettingController>();
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: AppTheme.card,
        child: Obx((){
          final selectedSubjects = Get.find<EditeSubjectController>().selectedSubjectIds.length;
          final exam = controller.selectedExam.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShowButtons(name: "Exam Date",buttonTitle: "Add Date",onTap: (){
                  },),
                  _EditeData(text: "September 18, 2025"),
                  SizedBox(height: 06)
                ],
              ),
              AppDivider(height: 10.0,color: greyColor.withAlpha(60),),
              _ShowButtons(name: "Subjects",buttonTitle: "Edite Subjects",onTap: (){
                Get.to(() => SubjectsEditeView());
              },),
              _EditeData(text: exam == null ? "Null" :  " $selectedSubjects of ${ exam.subjects.length.toString()} subjects"),
              SizedBox(height: 08),
              AppDivider(height: 08.0,color: greyColor.withAlpha(60),),
              _ShowButtons(name: "Organizations",buttonTitle: "Activate Code",onTap: (){},),
              const SizedBox(height: 08),
            ],
          );
        })
    )
    );
  }
}

class _ShowButtons extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
  final String buttonTitle;
  const _ShowButtons({super.key,required this.onTap,required this.name,required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),),
           ButtonText(title: buttonTitle, onTap: onTap)
        ],
      ),
    );
  }
}

class _EditeData extends StatelessWidget {
  final String text;
  const _EditeData({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(text,style: context.textTheme.bodyMedium!.copyWith(
        height: 1.0
      )),
    );
  }
}
