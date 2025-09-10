import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      leading: Icon(item.icon, color: Colors.blue),
      title: Text(item.title,  style: context.textTheme.titleMedium!.copyWith(
        color: kBlue
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
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Image.asset("images/exam.png",height: 60,color: kWhite,),
                  Text(
                    "Pocket prep exam",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: 22,
                      color: kWhite,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
            ),
          ),
           DrawerItemWidget(
            item: SettingsItem(icon: Icons.settings_outlined, title: 'App Preferences',),
             onTap: (){
             },
          ),
          const DrawerItemWidget(
            item: SettingsItem(icon: Icons.style_outlined, title: 'Study Reminders'),
          ),
          const DrawerItemWidget(
            item: SettingsItem(icon: Icons.front_hand_outlined, title: 'Help'),
          ),
          const DrawerItemWidget(
            item: SettingsItem(icon: Icons.email_outlined, title: 'Email Preferences'),
          ),
          const DrawerItemWidget(
            item: SettingsItem(icon: Icons.favorite_border, title: 'Accessibility, Terms, Privacy'),
          ),
          const DrawerItemWidget(
            item: SettingsItem(icon: Icons.share_outlined, title: 'Share App'),
          ),
          const DrawerItemWidget(
            item: SettingsItem(icon: Icons.star_border, title: 'Rate & Review'),
          ),
        ],
      ),
    );
  }
}
