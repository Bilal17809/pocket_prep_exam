import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  const CustomHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 08),
      decoration: const BoxDecoration(
        color: lightSkyBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  maxRadius: 18,
                  backgroundColor: kWhite.withAlpha(80),
                  child: IconButton(
                    onPressed: onBack ?? () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,size: 18,),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: kWhite.withAlpha(200),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 8),
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: kWhite,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
