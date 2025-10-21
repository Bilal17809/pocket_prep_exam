import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/app_divider.dart';
import 'package:pocket_prep_exam/pages/premium/view/premium_screen.dart';
import '../theme/app_colors.dart';

class SettingsItem {
  final IconData icon;
  final String title;
  const SettingsItem({required this.icon, required this.title});
}

class DrawerItemWidget extends StatelessWidget {
  final SettingsItem item;
  final VoidCallback? onTap;

  const DrawerItemWidget({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon, color: lightSkyBlue),
      title: Text(item.title,  style: context.textTheme.titleMedium!.copyWith(
        color:kBlack
      )),
      onTap: onTap ?? () => Navigator.pop(context),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

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
                  Image.asset("images/appicon.png",height: 60),
                  Text(
                    "Professional",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: 16,
                      color: kWhite,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                      "PocketPrep",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontSize: 26,
                          color: kWhite,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ],
              ),
            ),
          ),
          DrawerItemWidget(
            item: SettingsItem(
              icon: Icons.star_outline,
              title: 'Rate Us',
            ),
            onTap: () {
            },
          ),
           Divider(height: 2.0,color: grey.withAlpha(60),),
          DrawerItemWidget(
            item: SettingsItem(
              icon: Icons.apps_outlined,
              title: 'More Apps',
            ),
            onTap: () {

            },
          ),
          AppDivider(height: 2.0,),
          DrawerItemWidget(
            item: SettingsItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
            ),
            onTap: () {
            },
          ),
          AppDivider(height: 2.0,),
          DrawerItemWidget(
            item: SettingsItem(
              icon: Icons.bar_chart_outlined,
              title: 'Reports',
            ),
            onTap: () {
            },
          ),
          AppDivider(height: 2.0,),
          DrawerItemWidget(
            item: SettingsItem(
              icon: Icons.workspace_premium_outlined,
              title: 'Premium',
            ),
            onTap: () {
              Get.to(()=> PremiumScreen());
            },
          ),

        ],
      ),
    );
  }
}

