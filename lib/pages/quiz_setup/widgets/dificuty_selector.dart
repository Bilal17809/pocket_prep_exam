
import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';

class DifficultySelector extends StatelessWidget {
  const DifficultySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:  [
        DifficultyCard(label: "Easy", icon: Icons.tag_faces, isSelected: true,iconColor: Colors.yellow,),
        SizedBox(width: 10),
        DifficultyCard(label: "Medium", icon: Icons.balance, isSelected: false,iconColor: Colors.orange,),
        SizedBox(width: 10),
        DifficultyCard(label: "Hard", icon: Icons.flash_on, isSelected: false,iconColor: Colors.red,),
      ],
    );
  }
}

class DifficultyCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;

  const DifficultyCard({
    super.key,
    this.iconColor = Colors.grey,
    required this.label,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration:roundedDecoration.copyWith(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.green.shade50 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.green : iconColor),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.green : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}