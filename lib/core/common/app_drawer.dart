import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import 'package:pocket_prep_exam/core/common/app_divider.dart';
import 'package:pocket_prep_exam/core/constant/constant.dart';
import 'package:pocket_prep_exam/pages/premium/view/premium_screen.dart';
import 'package:pocket_prep_exam/pages/reports/view/reports_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class SettingsItem {
  final IconData icon;
  final String title;
  const SettingsItem({required this.icon, required this.title});
}

class DrawerItemWidget extends StatelessWidget {
  final SettingsItem item;
  final VoidCallback? onTap;

  const DrawerItemWidget({super.key, required this.item, this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon, color: lightSkyBlue),
      title: Text(
        item.title,
        style: context.textTheme.titleMedium!.copyWith(color: kBlack),
      ),
      onTap: onTap ?? () => Navigator.pop(context),
    );
  }
}

class AppDrawer extends StatelessWidget {
   AppDrawer({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        "Error",
        "Could not open link",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  final isSubscribed = Get.find<RemoveAds>().isSubscribedGet.value;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(color: lightSkyBlue.withAlpha(200)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset("images/appicon.png", height: 80),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppFirstName,
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontSize: 16,
                                color: kWhite.withAlpha(200),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              AppLastName,
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontSize: 24,
                                color: kWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          DrawerItemWidget(
            item: SettingsItem(icon: Icons.star_outline, title: 'Rate Us'),
            onTap: () {
              _launchURL("https://play.google.com/store/apps/details?id=com.examprep.professionalcertification");
            },
          ),
          AppDivider(height: 2.0),
          DrawerItemWidget(
            item: SettingsItem(icon: Icons.apps_outlined, title: 'More Apps'),
            onTap: () {
              _launchURL(
                "https://play.google.com/store/apps/developer?id=Modern+School",
              );
            },
          ),
          AppDivider(height: 2.0),
          DrawerItemWidget(
            item: SettingsItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
            ),
            onTap: () {
              _launchURL(
                "https://modernmobileschool.blogspot.com/2017/07/modern-school-privacy-policy.ht",
              );
            },
          ),
          AppDivider(height: 2.0),
          DrawerItemWidget(
            item: SettingsItem(
              icon: Icons.report_outlined,
              title: 'Report an Issue',
            ),
            onTap: () {
              Get.to(() => ReportScreen());
            },
          ),
          AppDivider(height: 2.0),
          DrawerItemWidget(
            item: SettingsItem(
              icon: Icons.workspace_premium_outlined,
              title: isSubscribed ? 'Ads Free' : "Premium",
            ),
            onTap: () {
              Get.to(() => PremiumScreen());
            },
          ),
        ],
      ),
    );
  }
}
