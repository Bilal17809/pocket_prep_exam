import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/pages/stats/controller/stats_controller.dart';
import '/core/theme/app_colors.dart';

class ExpandableTile extends StatelessWidget {
  final Items items;
  const ExpandableTile({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: kWhite, borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kBlue.withAlpha(200),width: 0.50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(items.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Icon(Icons.arrow_drop_down, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
