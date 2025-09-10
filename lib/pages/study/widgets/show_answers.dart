
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';

class ShowAnswers extends StatelessWidget {
  final double height;
  final double width;
  const ShowAnswers({super.key,
    this.height = 40,
     this.width = 40,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: bodyWH,vertical: 06),
      child: Row(
        children: [
          Container(
            height:height ,
            width:width,
            decoration: roundedDecoration.copyWith(
              color:  kBlue.withAlpha(220),
            ),
            child: Center(
              child: Icon(Icons.menu,color: kWhite,size: 28,),
            ),
          ),
          SizedBox(width: 20),
          Container(
            height: 20,
            width: 02,
            decoration: BoxDecoration(
              color: kBlack
            ),
          ),
          Text(" Key : ",style: TextStyle(fontSize: 18),),
          _CorrectWrong(answerTitle: " Correct", icon: Icons.circle,color: Colors.green,),
          SizedBox(width: 14),
          _CorrectWrong(answerTitle: " Incorrect", icon: Icons.circle_outlined,color: Colors.red,)
        ],
      ),
    );
  }
}

class _CorrectWrong extends StatelessWidget {
  final String answerTitle;
 final IconData? icon;
 final Color? color;
  const _CorrectWrong({super.key,
  required  this.answerTitle,
    required this.icon,
    this.color
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,size: 10,color: color,),
        Text(answerTitle,style: context.textTheme.bodyMedium)
      ],
    );
  }
}
