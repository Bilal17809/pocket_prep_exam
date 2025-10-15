import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

class QuizResultAppBarTwo extends StatelessWidget {
  final String title;

  const QuizResultAppBarTwo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    const double expandedHeight = 100;

    return SliverAppBar(
      pinned: true,
      floating: false,
      actions: [
        Icon(Icons.cancel_outlined)
      ],
      expandedHeight: expandedHeight,
      backgroundColor: kWhiteF7,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final double currentHeight = constraints.biggest.height;

          return FlexibleSpaceBar(
            centerTitle: true,
            
            title: currentHeight <= kToolbarHeight + 40
                ? Text(
              title,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              
            )
            
                : null,
          );
        },
      ),
    );
  }
}
