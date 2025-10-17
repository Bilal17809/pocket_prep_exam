import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_styles.dart';
import '../control/setting_controller.dart';


class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingController>();

    return Obx(() {
      final name = controller.fullName;
      final initials = controller.initials;
      return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        width: double.infinity,
        decoration: roundedDecoration,
        child: Row(
          children: [
            CircleAvatar(
              maxRadius: 24,
              backgroundColor: grey.withOpacity(0.3),
              child: Text(
                initials,
                style: titleSmallStyle.copyWith(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: titleSmallStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    });
  }
}
