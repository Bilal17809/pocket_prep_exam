import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/Utility/utils.dart';
import 'package:pocket_prep_exam/core/common/common_button.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import '../controller/quiz_builder_controller.dart';

class TimePickerWidget extends StatelessWidget {
  const TimePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizBuilderController>();
    return Obx(() {
      final selected = controller.selectedTime.value;
      final durationText = selected.inSeconds > 0
          ? controller.formattedDuration
          : "Tap to set time";
      return GestureDetector(
        onTap: () => _showCustomDurationPicker(context, controller),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected.inSeconds > 0 ? lightSkyBlue : Colors.grey.shade300,
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: lightSkyBlue.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.timer_rounded,
                  color: lightSkyBlue,
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
                        color: selected.inSeconds > 0
                            ? lightSkyBlue
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
  void _showCustomDurationPicker(
      BuildContext context, QuizBuilderController controller) {
    final currentDuration = controller.selectedTime.value;
    final minutes = currentDuration.inMinutes.obs;
    final seconds = (currentDuration.inSeconds % 60).obs;
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: lightSkyBlue.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: lightSkyBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Select Quiz Duration",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Minutes Slider
                  Obx(() => _buildSliderSection(
                    label: "Minutes",
                    value: minutes.value,
                    max: 120,
                    divisions: 120,
                    onChanged: (val) => minutes.value = val.toInt(),
                  )),
                  const SizedBox(height: 10),
                  Obx(() => _buildSliderSection(
                    label: "Seconds",
                    value: seconds.value,
                    max: 59,
                    divisions: 59,
                    onChanged: (val) => seconds.value = val.toInt(),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 06, right: 06),
              child: CommonButton(
                title: "Set Duration",
                icon: Icons.check_circle_outline,
                isIcon: true,
                onTap: () {
                  final totalMinutes = minutes.value;
                  final totalSeconds = seconds.value;
                  if (totalMinutes == 0 && totalSeconds == 0) {
                  Utils.showError(
                    "Please select at least 1 second","Invalid Duration");
                    return;
                  }
                  final duration = Duration(
                    minutes: totalMinutes,
                    seconds: totalSeconds,
                  );
                  controller.setQuizDuration(duration);
                  Get.back();
              Utils.showSuccess(
                "Quiz duration: ${_formatDuration(totalMinutes, totalSeconds)}",
                    "Duration Set"
              );
                },
              ),
            ),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  Widget _buildSliderSection({
    required String label,
    required int value,
    required double max,
    required int divisions,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 02),
              decoration: BoxDecoration(
                color: lightSkyBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "$value",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: lightSkyBlue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: lightSkyBlue,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: lightSkyBlue,
            overlayColor: lightSkyBlue.withOpacity(0.2),
            valueIndicatorColor: lightSkyBlue,
            trackHeight: 4,
          ),
          child: Slider(
            value: value.toDouble(),
            min: 0,
            max: max,
            divisions: divisions,
            label: "$value",
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
  String _formatDuration(int minutes, int seconds) {
    List<String> parts = [];
    if (minutes > 0) parts.add("${minutes}m");
    if (seconds > 0) parts.add("${seconds}s");
    return parts.isEmpty ? "0s" : parts.join(" ");
  }
}