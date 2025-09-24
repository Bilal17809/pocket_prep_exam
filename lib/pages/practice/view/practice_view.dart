
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/constant/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/main_appbar/main_appbar.dart';
import 'package:pocket_prep_exam/pages/practice/widgets/statscard.dart';
import 'package:pocket_prep_exam/pages/practice/widgets/subject_list.dart';
import '../widgets/question_progress.dart';

class PracticeView extends StatelessWidget {
  const PracticeView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteF7,
          appBar: MainAppBar(title: "Practice", subtitle: "",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              QuestionProgress(),
              SizedBox(height: 10,),
              StatsCard(text: "Return to last test",),
              SizedBox(height: 10),
              Text("Practice By Subject",style: context.textTheme.bodyMedium!.copyWith(fontSize: 18)),
              SizedBox(height: 10),
              SubjectList()
            ],
          ),
        ),
      ),
    );
  }
}
