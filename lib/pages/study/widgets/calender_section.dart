import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_styles.dart';
import '../controller/study_controller.dart';
import 'package:get/get.dart';

class CalendarSection extends StatelessWidget {
  final StudyController controller;
  const CalendarSection({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Obx(() {
        if (controller.calendarDates.isEmpty) {
          return const SizedBox.shrink();
        }
        final todayIndex = controller.calendarDates.indexWhere((d) => d.isToday);
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: controller.calendarDates.map((dateModel) {
                return Expanded(
                  child: Center(
                    child: Text(
                      dateModel.dayName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: lightSkyBlue,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 6),
            Stack(
              children: [
                // Connecting lines between all consecutive dates
                Positioned.fill(
                  child: CustomPaint(
                    painter: ConnectingLinePainter(
                      dateCount: controller.calendarDates.length,
                      todayIndex: todayIndex,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: controller.calendarDates.asMap().entries.map((entry) {
                    final dateModel = entry.value;
                    final isToday = dateModel.isToday;
                    return Expanded(
                      child: Center(
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: calender.copyWith(
                            color: isToday
                                ? lightSkyBlue
                                : (dateModel.date.isBefore(DateTime.now())
                                ? lightSkyBlue.withOpacity(0.3)
                                : Colors.white),
                            border: Border.all(
                              color: isToday
                                  ? lightSkyBlue
                                  : (dateModel.date.isBefore(DateTime.now())
                                  ? lightSkyBlue.withOpacity(0.3)
                                  : (dateModel.date.isAfter(DateTime.now()) &&
                                  dateModel.date.day == DateTime.now().add(const Duration(days: 1)).day)
                                  ? lightSkyBlue
                                  : Colors.white),
                              width: isToday ? 1.5 : 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateModel.dayNumber.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: isToday ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class ConnectingLinePainter extends CustomPainter {
  final int dateCount;
  final int todayIndex;
  ConnectingLinePainter({required this.dateCount, required this.todayIndex});

  @override
  void paint(Canvas canvas, Size size) {
    if (dateCount < 2) return;
    final itemWidth = size.width / dateCount;
    final centerY = size.height / 2;
    for (int i = 0; i < dateCount - 1; i++) {
      final startX = (i + 0.5) * itemWidth + 18;
      final endX = (i + 1.5) * itemWidth - 18;
      late Color lineColor;
      if (todayIndex != -1) {
        if (i == todayIndex) {
          lineColor = lightSkyBlue;
        } else if (i < todayIndex) {
          lineColor = lightSkyBlue.withAlpha(100);
        } else {
          lineColor = Colors.grey.shade300;
        }
      } else {
        lineColor = Colors.grey.shade300;
      }
      final paint = Paint()
        ..color = lineColor
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      canvas.drawLine(
        Offset(startX, centerY),
        Offset(endX, centerY),
        paint,
      );
    }
  }
  @override
  bool shouldRepaint(ConnectingLinePainter oldDelegate) =>
      oldDelegate.todayIndex != todayIndex || oldDelegate.dateCount != dateCount;
}
