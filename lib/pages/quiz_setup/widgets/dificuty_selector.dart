import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import 'package:pocket_prep_exam/pages/quiz_setup/controller/quiz_setup_controller.dart';

class DifficultySelector extends StatelessWidget {
  const DifficultySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizSetupController>();
    return Obx(() => Row(
      children: [
        _DifficultyCard(
          label: "Easy",
          icon: Icons.tag_faces,
          iconColor: Colors.yellow,
          isSelected: controller.selectedDifficulty.value == "Easy",
          onTap: () => controller.setDifficulty("Easy"),
        ),
        const SizedBox(width: 10),
        _DifficultyCard(
          label: "Medium",
          icon: Icons.balance,
          iconColor: Colors.orange,
          isSelected: controller.selectedDifficulty.value == "Medium",
          onTap: () => controller.setDifficulty("Medium"),
        ),
        const SizedBox(width: 10),
        _DifficultyCard(
          label: "Hard",
          icon: Icons.flash_on,
          iconColor: Colors.red,
          isSelected: controller.selectedDifficulty.value == "Hard",
          onTap: () => controller.setDifficulty("Hard"),
        ),
      ],
    ));
  }
}

class _DifficultyCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _DifficultyCard({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: quizSetupContainer.copyWith(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? lightSkyBlue : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.blue : iconColor),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.blue : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
