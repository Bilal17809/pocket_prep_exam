
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/services/exam_and_subjects_services.dart';

import '../../../data/models/exams_and_subject.dart';
import '../../../data/models/user_model.dart';


class SettingController extends GetxController {

  final StorageService _storageService;
  final ExamService _examService;

  Rxn<Exam> selectedExam = Rxn<Exam>();
  RxBool isTtsEnabled = true.obs;
  var isDarkMode = false.obs;
  var user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    loadExamFromStorage();
    loadUser();
    isTtsEnabled.value = _storageService.loadTTsToggle();
    // isDarkMode.value = _storageService.loadDarkMode();
    // _applyTheme(isDarkMode.value);
  }


  SettingController({required StorageService storageService, required ExamService examServices})
      : _storageService = storageService , _examService = examServices;


  Future<void> loadExamFromStorage() async {
    final examId = await _storageService.getExam();
    final exams = await _examService.fetchExams();
    if (examId != null) {
      selectedExam.value = exams.firstWhere((e) => e.examId == examId);
    }
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    StorageService.saveDarkMode(value);
    _applyTheme(value);
  }

  void _applyTheme(bool isDark) {
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }


  Future<void> loadUser() async {
    final savedUser =  _storageService.getUser();
    user.value = savedUser;
  }

  String get fullName {
    if (user.value == null) return "Guest User";
    return "${user.value!.firstName} ${user.value!.lastName}";
  }

  String get initials {
    if (user.value == null) return "--";
    final first = user.value!.firstName.isNotEmpty ? user.value!.firstName[0].toUpperCase() : '';
    final last = user.value!.lastName.isNotEmpty ? user.value!.lastName[0].toUpperCase() : '';
    return "$first$last";
  }

}