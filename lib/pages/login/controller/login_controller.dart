import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/local_storage/storage_helper.dart';
import '/data/models/user_model.dart';

class LoginController extends GetxController {

  var firstName = "".obs;
  var lastName = "".obs;

  final StorageService _storage ;

  LoginController({required StorageService storageServices}) : _storage = storageServices;


  Future<void> saveUser() async {
    if (firstName.value.trim().isEmpty || lastName.value.trim().isEmpty) {
      // _showError("Please enter your name properly");
      return;
    }
    final user = UserModel(
      firstName: firstName.value.trim(),
      lastName: lastName.value.trim(),
    );
    await _storage.saveUser(user);
  }



  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter first name";
    }

    final name = value.trim();
    final regex = RegExp(r"^[A-Za-z]{2,}$");
    if (!regex.hasMatch(name)) {
      return "Enter a valid first name";
    }
    final repeatedChar = RegExp(r"(.)\1{2,}");
    if (repeatedChar.hasMatch(name)) {
      return "Name cannot have repeated same letters";
    }
    firstName.value = name;
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter last name";
    }
    final name = value.trim();
    final regex = RegExp(r"^[A-Za-z]{2,}$");
    if (!regex.hasMatch(name)) {
      return "Enter a valid last name";
    }
    final repeatedChar = RegExp(r"(.)\1{2,}");
    if (repeatedChar.hasMatch(name)) {
      return "Name cannot have repeated same letters";
    }
    lastName.value = name;
    return null;
  }

  // void _showError(String message) {
  //   if (!Get.isSnackbarOpen) {
  //     Get.snackbar(
  //       "Error",
  //       message,
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  @override
  void onClose() {
    firstName.value = '';
    lastName.value = '';
    super.onClose();
  }
}
