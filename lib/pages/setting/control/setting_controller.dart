
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';

class SettingController extends GetxController{

  final  StorageService _storageService;


  SettingController({required StorageService storageService}) : _storageService = storageService;

  @override
  void onInit() {
    super.onInit();
    // _storageService.loadExamName();
  }

  final List<SettingsItem> settingsItems = [
    SettingsItem(icon: Icons.settings_outlined, title: 'App Preferences'),
    SettingsItem(icon: Icons.style_outlined, title: 'Study Reminders'),
    SettingsItem(icon: Icons.front_hand_outlined, title: 'Help'),
    SettingsItem(icon: Icons.email_outlined, title: 'Email Preferences'),
    SettingsItem(icon: Icons.favorite_border, title: 'Accessibility, Terms, Privacy'),
    SettingsItem(icon: Icons.share_outlined, title: 'Share App'),
    SettingsItem(icon: Icons.star_border, title: 'Rate & Review'),
  ];
}



class SettingsItem {
  final IconData icon;
  final String title;
  SettingsItem({required this.icon, required this.title});
}