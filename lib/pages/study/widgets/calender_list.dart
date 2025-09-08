import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/pages/study/controller/study_controller.dart';
import 'package:pocket_prep_exam/pages/study/widgets/calender_card.dart';


class CalenderListSection extends StatelessWidget {
  final StudyController controller;
  final double height;
  final double width;
const CalenderListSection ({
    super.key,
    required  this.controller,
    required this.height,
    required this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height * 0.16,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            scrollDirection: Axis.horizontal,
            itemCount: controller.calenderList.length,
            separatorBuilder: (context, index) => const SizedBox(width: 0),
            itemBuilder: (context, index) {
              final item = controller.calenderList[index];
              final cardWidth = (width / 5) * 0.58;
              return InkWell(
                onTap: (){
                  // controller.selectItem(index);
                },
                child:
                    SizedBox(
                        width: cardWidth,
                        child: CalenderListCard(item: item,index: index,)

                )
              );
            },
          ),
        ),
      ],
    );
  }
}
