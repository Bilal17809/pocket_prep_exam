import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/study/controller/study_controller.dart';

class QuizModeList extends StatelessWidget {
  final StudyController controller;
  const QuizModeList({super.key,required this.controller});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      child: ListView.builder(
          itemCount: controller.quizModeDataList.length,
          itemBuilder: (context,index){
            final item = controller.quizModeDataList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kWhite,
                borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kBlue.withAlpha(200),width: 0.50)),
                child: Center(
                  child: ListTile(
                    leading: Image.asset(item.icon.toString()),
                    title: Text(item.title.toString(),),
                    trailing: Text(item.date.toString(),style: TextStyle(color: kBlue,fontSize: 14),),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}


