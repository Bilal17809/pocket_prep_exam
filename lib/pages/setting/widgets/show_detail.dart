import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/pages/setting/widgets/text_button.dart';

class ShowDetail extends StatelessWidget {
  const ShowDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("I'm preparing for"),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: greyColor.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Firefighter I & II",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: kBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Firefighter I & II",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: kBlack,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Free Study Progress . 0 / 30 Questions",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: kBlack,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const _ReusableDivider(),
                // Use the updated ButtonText here
                ButtonText(
                  title: "Exam Settings",
                  onTap: () {},
                ),
                const _ReusableDivider(),
                // Use the updated ButtonText here
                ButtonText(
                  title: "Switch Exam",
                  onTap: () {},
                ),
                const SizedBox(height: 08),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _ReusableDivider extends StatelessWidget {
  const _ReusableDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey[60],
      height: 10.0,
    );
  }
}