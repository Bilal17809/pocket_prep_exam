
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/pages/setting/widgets/text_button.dart';
import '/core/theme/app_colors.dart';

class StudyPlane extends StatelessWidget {
  const StudyPlane({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Study Plan"),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: kWhite,
                borderRadius: BorderRadius.circular(06),
                border: Border.all(color: greyColor.withAlpha(60))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Free Pocket Prep",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: kBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                     _TextWidget(text: "Questions of the Day"),
                      _TextWidget(text: "30 Questions (of 1000 Question Bank)"),
                      _TextWidget(text: "Limited Quiz Modes"),

                    ],
                  ),
                ),
                Divider(height: 24,color: greyColor.withAlpha(60),),
                ButtonText(title: "Upgrade to Premium", onTap: (){}),
                SizedBox(height: 10)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TextWidget extends StatelessWidget {
  final String text;
  const _TextWidget({super.key,required this.text});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Icon(Icons.circle,color: Colors.grey,size: 06,),
          SizedBox(width: 04),
          Text(
            text,
            style: context.textTheme.bodySmall!.copyWith(
              color: kBlack,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

