import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/theme/app_theme.dart';
import 'package:pocket_prep_exam/pages/stats/widgets/progress_gauge.dart';
import 'package:pocket_prep_exam/pages/stats/widgets/stat_card.dart';

class StatsHeader extends StatelessWidget {
  const StatsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 10),
      decoration: AppTheme.gradientHeader,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Stats",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                "Add Exam Countdown",
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              SizedBox(height: 24),
              Center(child: ProgressGauge(progress: 0.6,size: 250,)),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  StatCard(title: "0/1", subtitle: "Answered Correctly",statView: true),
                  StatCard(title: "83%", subtitle: "Community",statView: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
