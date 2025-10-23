import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common/common_button.dart';
import '../../login/view/login_view.dart';
import '../controller/reports_controller.dart';
import '/core/theme/app_colors.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final detailController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: lightSkyBlue,
        elevation: 0,
        title: const Text(
          "Report an Issue",
          style: TextStyle(color: kWhite, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: kWhite),
          onPressed: () => Get.back(),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const Text(
                "Enter your name",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              ValidatedField(
                hintText: "Enter your name",
                controller: nameController,
                validator: (v) => null,
                icon: Icons.person_outline,
                label: "name",
              ),
              const SizedBox(height: 24),
              const Text(
                "Select issue(s) *",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Column(
                  children:
                      controller.issues.map((issue) {
                        return CheckboxListTile(
                          value: controller.selectedIssues.contains(issue),
                          onChanged: (_) => controller.toggleIssue(issue),
                          title: Text(
                            issue,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          activeColor: lightSkyBlue,
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Tell us more",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              ValidatedField(
                MaxLine: 5,
                hintText: "Add more details here...",
                controller: detailController,
                validator: (v) => null,
                icon: null,
                label: "details",
              ),
              const SizedBox(height: 40),
              CommonButton(
                title: "Send Report",
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    controller.sendReport(
                      context: context,
                      Name: nameController.text,
                      details: detailController.text,
                    );
                    nameController.clear();
                    detailController.clear();
                    controller.selectedIssues.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
