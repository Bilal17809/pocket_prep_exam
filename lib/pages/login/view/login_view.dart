import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/common/custom_textfield.dart';
import '/core/common/common_button.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_styles.dart';
import '/pages/switch_exam/view/examp_switch_view.dart';
import '../controller/login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: kWhiteF7,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/appicon.png", height: 100),
                // const SizedBox(height: 20),
                Text(
                  "Professional",
                  style: textTheme.displaySmall!.copyWith(color: Colors.blue.shade700,fontWeight: FontWeight.w600,fontSize: 16),
                ),
                Text(
                  "PocketPrep",
                  style: textTheme.displaySmall!.copyWith(color: Colors.blue.shade700,fontWeight: FontWeight.w600,fontSize: 24),
                ),
                const SizedBox(height: 36),
                Form(
                  key: _formKey,
                  child: Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                    decoration: roundedDecoration,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Welcome to  Professional PocketPrep!",
                          style: context.textTheme.titleLarge!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Please enter your details to continue",
                          style: context.textTheme.titleSmall!.copyWith(color: grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 28),
                        _ValidatedField(
                          hintText: "First Name",
                          label: "First Name",
                          controller: firstNameController,
                          validator: controller.validateFirstName,
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),
                        _ValidatedField(
                          hintText: "Last Name",
                          label: "Last Name",
                          controller: lastNameController,
                          validator: controller.validateLastName,
                          icon: Icons.badge_outlined,
                        ),
                        const SizedBox(height: 24),
                        CommonButton(
                          title: "Login",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              controller.firstName.value = firstNameController.text.trim();
                              controller.lastName.value = lastNameController.text.trim();
                              await controller.saveUser();
                              Get.off(() => ExamSwitchView());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _ValidatedField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final IconData icon;
  final String label;
  const _ValidatedField({
    required this.hintText,
    required this.controller,
    required this.validator,
    required this.icon,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (val) {
        final value = controller.text.trim();
        if (value.isEmpty) return "Please enter $label";
        return validator(val);
      },
      builder: (field) {
        final hasError = field.hasError;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: roundedDecoration.copyWith(
                color: const Color(0xFFF6F8FA),
                borderRadius: BorderRadius.circular(14),
                border: hasError
                    ? Border.all(color: Colors.red.shade400, width: 1)
                    : Border.all(color: Colors.transparent, width: 0),
              ),
              child: CustomTextFormField(
                  controller: controller,
                  onChanged: (val) => field.didChange(val),
                    prefixIcon: Icon(icon, color: Colors.grey),
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle:
                    const TextStyle(color: Colors.grey, fontSize: 15),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                  ),
              ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 6),
                child: Text(
                  field.errorText ?? '',
                  style:
                  const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
