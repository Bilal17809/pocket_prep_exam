import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quiz_builder_controller.dart';

class TimePickerWidget extends StatelessWidget {
  const TimePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizBuilderController>();

    return Obx(() {
      final selectedMinutes = controller.selectedTime.value.inMinutes;
      final durationText = selectedMinutes > 0
          ? "$selectedMinutes minutes"
          : "Tap to set time";

      return GestureDetector(
        onTap: () async {
          final result = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (result != null) {
            final duration = Duration(hours: result.hour, minutes: result.minute);
            controller.setQuizDuration(duration);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(06),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: selectedMinutes > 0 ? Colors.blue : Colors.grey.shade300,
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.timer_rounded,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Set Total Quiz Duration",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      durationText,
                      style: TextStyle(
                        fontSize: 13,
                        color: selectedMinutes > 0
                            ? Colors.blue.shade700
                            : Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );
    });
  }
}
