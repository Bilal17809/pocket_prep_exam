
import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_styles.dart';
import '../controller/study_controller.dart';

class CalendarSection extends StatelessWidget {
  final StudyController controller;
  const CalendarSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final dates = ["FRI", "SAT", "SUN", "MON", "TUE", "WED", "THU"];
    final days = ["26", "27", "28", "29", "30", "1", "2"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(dates.length, (index) {
              return Expanded(
                child: Center(
                  child: Text(
                    dates[index],
                    style: TextStyle(
                      fontSize: 12,
                      // fontWeight: FontWeight.w500,
                      color: lightSkyBlue,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(days.length, (index) {
              final isSelected = days[index] == "30";
              return Expanded(
                child: Center(
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: roundedDecoration.copyWith(
                        color: isSelected ? lightSkyBlue : Colors.white,
                        border:  Border.all(
                            color: isSelected ? lightSkyBlue : Colors.white
                        )
                    ),
                    child: Center(
                      child: Text(
                        days[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
