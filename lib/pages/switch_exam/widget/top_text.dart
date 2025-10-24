import 'package:flutter/cupertino.dart';

import '/core/theme/app_styles.dart';

class TopText extends StatelessWidget {
  const TopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Image.asset("images/exams.png",height: 28,),
        Text("Switch Exam"),
        SizedBox(height: 14),
        Text("What are you preparing for?",style:buttonTextStyle.copyWith(
          fontSize: 18
        ),),
      ],
    );
  }
}
