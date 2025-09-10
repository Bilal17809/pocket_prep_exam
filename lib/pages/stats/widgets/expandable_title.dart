import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/common/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_theme.dart';
import 'package:pocket_prep_exam/pages/stats/controller/stats_controller.dart';
import '/core/theme/app_styles.dart';

class ExpandableTile extends StatelessWidget {
  final Items items;
  const ExpandableTile({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: bodySmallWH),
      child: Container(
        margin:  EdgeInsets.symmetric(horizontal: bodySmallWH, vertical: 5),
        padding: const EdgeInsets.all(15),
        decoration: AppTheme. borderedBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(items.title,style:  buttonTextStyle),
            const Icon(Icons.arrow_drop_down, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
