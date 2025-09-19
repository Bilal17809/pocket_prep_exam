import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_theme.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String subtitle;
   final bool statView;
  const StatCard({super.key, required this.title, required this.subtitle,this.statView = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration:  statView ?  AppTheme.statViewStateDecoration : AppTheme.resultViewStateDecoration,
      child: Column(
        children: [
          Text(title, style:  TextStyle(fontSize: 18,color: statView ? kBlack : kWhite, fontWeight: FontWeight.bold)),
          Text(subtitle, style:  TextStyle(fontSize: 12, color: statView ? kBlack : kWhite,)),
        ],
      ),
    );
  }
}
