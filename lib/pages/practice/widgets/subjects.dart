import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';

class SubjectWidget extends StatelessWidget {
  final String subjectsName;
  final String? totalQuestion;
  const SubjectWidget({super.key,this.subjectsName = "Empty",this.totalQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: roundedDecoration,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subjectsName,style: bodyLargeStyle.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),
          Text(totalQuestion ?? "0",style: bodyLargeStyle.copyWith(color: Colors.black54,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
