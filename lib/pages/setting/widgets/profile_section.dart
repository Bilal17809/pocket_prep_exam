
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/app_divider.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text("Pocket Prep"),
        SizedBox(height: 30),
        Text("izharbadshah788@gmail...",style: context.textTheme.bodySmall!.copyWith(
            color: kBlack,fontSize: 26,fontWeight: FontWeight.bold
        )),
        SizedBox(height: 10),
        Text("Edite",style: context.textTheme.bodySmall!.copyWith(
           color: kBlue,fontSize: 16,fontWeight: FontWeight.bold
        ),),
      ],
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: AppDivider(thickness: 02,height: 30.0,color: Color(0xFF1E90FF),),
    );
  }
}

