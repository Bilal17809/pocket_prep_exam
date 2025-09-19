import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

class QuizResultAppBar extends StatelessWidget {
  final List<String> labels;
  final List<int> counts;

  const QuizResultAppBar({
    super.key,
    required this.labels,
    required this.counts,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SliverAppBar(
      pinned: true,
      elevation: 1,
      backgroundColor: kWhiteF7,
      actions: [

      ],
      title: Text("Quick 10 . 0%",style: TextStyle(color: Colors.green),),
      toolbarHeight: 0,
      bottom: PreferredSize(
        preferredSize:  Size.fromHeight(height * 0.12),
        child: Container(
          width: double.infinity,
          color: kWhiteF7,
          child: TabBar(
            isScrollable: false, // evenly distribute
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: List.generate(labels.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      labels[index],
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      counts[index].toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
