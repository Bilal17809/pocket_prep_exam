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
    final textTheme = context.textTheme;
    final controller = Get.find<QuizBuilderController>();

    return Obx(() {
      final selected = controller.selectedTime.value;
      final durationText = selected.inSeconds > 0
          ? controller.formattedDuration
          : "Tap to set time";
      return GestureDetector(
        onTap: () => _showCustomDurationPicker(context, controller),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
              selected.inSeconds > 0 ? lightSkyBlue : Colors.grey.shade300,
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
                    Text(
                      "Set Total Quiz Duration",
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      durationText,
                      style: textTheme.bodyMedium?.copyWith(
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
    final textTheme = context.textTheme;
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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: lightSkyBlue.withOpacity(0.1),
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
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
                  Text(
                    "Select Quiz Duration",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
                  Obx(() => _buildSliderSection(
                    context: context,
                    label: "Minutes",
                    value: minutes.value,
                    max: 30,
                    divisions: 30,
                    onChanged: (val) => minutes.value = val.toInt(),
                  )),
                  const SizedBox(height: 10),
                  // Seconds slider (optional)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
              child: CommonButton(
                title: "Set Duration",
                icon: Icons.check_circle_outline,
                isIcon: true,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  final totalMinutes = minutes.value;
                  final totalSeconds = seconds.value;

                  if (totalMinutes == 0 && totalSeconds == 0) {
                    Utils.showError(
                        "Please select at least 1 minute", "Invalid Duration");
                    return;
                  }

                  final duration = Duration(
                    minutes: totalMinutes,
                    seconds: totalSeconds,
                  );

                  controller.setQuizDuration(duration);
                  FocusManager.instance.primaryFocus?.unfocus();
                  Get.back();

                  Utils.showSuccess(
                    "Quiz duration: ${_formatDuration(totalMinutes, totalSeconds)}",
                    "Duration Set",
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
    required BuildContext context,
    required String label,
    required int value,
    required double max,
    required int divisions,
    required Function(double) onChanged,
  }) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: lightSkyBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "$value",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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
