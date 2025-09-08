import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/study/controller/study_controller.dart';
import '/core/theme/app_theme.dart';

class CalenderListCard extends StatelessWidget {
  final CalenderModel item;
  final int? index;
  final double height;
  final double width;
  const CalenderListCard({
    super.key,
    this.index,
    required this.item,
    this.height = 100,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudyController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Obx(() {
        final bool isSelected = controller.selectedIndex.value == index;
        return GestureDetector(
          onTap: () {
            controller.selectItem(index!);
          },
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: isSelected ? kBlue.withAlpha(220) : kWhite,
              borderRadius: BorderRadius.circular(40),
              boxShadow: AppTheme.defaultShadow,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.date.toString(),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 06),
                Text(
                  item.day.toString(),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}