import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportController extends GetxController {
  final List<String> issues = [
    'App Crashing',
    'Ad not working',
    'Content Issue',
    'Slow performance',
    'App Freezing',
    'UI Glitch',
    'Wrong Answer / Misinformation',
    'Audio not working',
    'Data Not Loaded',
    'Payment/Subscription Issue',
    'Other',
  ];

  final selectedIssues = <String>[].obs;

  void toggleIssue(String issue) {
    if (selectedIssues.contains(issue)) {
      selectedIssues.remove(issue);
    } else {
      selectedIssues.add(issue);
    }
  }

  Future<void> sendReport({
    required BuildContext context,
    required String itemName,
    required String details,
  }) async {
    final subject = Uri.encodeComponent(
      'User Report - ${selectedIssues.isEmpty ? "Unknown" : selectedIssues.join(", ")}',
    );
    final body = Uri.encodeComponent('''
Item Name: $itemName

Issue(s): ${selectedIssues.join(", ")}

Details: $details
''');

    final uri = Uri.parse(
      'mailto:unisoftaps@gmail.com?subject=$subject&body=$body',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Report submission initiated. Please complete the email.",
          ),
        ),
      );
    } else {
      Get.defaultDialog(
        title: "No Email App Found",
        middleText:
            "No email app is installed on your device. Please install one to send the report.",
        confirm: TextButton(onPressed: Get.back, child: const Text("OK")),
      );
    }
  }
}
