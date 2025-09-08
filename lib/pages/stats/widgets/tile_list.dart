import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/pages/stats/controller/stats_controller.dart';
import 'expandable_title.dart';


class TileList extends StatelessWidget {
  final StatsController controller;
  const TileList({super.key,required this.controller});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          padding: EdgeInsets.zero,
            itemCount: controller.titleList.length,
            itemBuilder: (context,index){
              final items = controller.titleList[index];
              return ExpandableTile(items: items);
            }
        ),
    );
  }
}
