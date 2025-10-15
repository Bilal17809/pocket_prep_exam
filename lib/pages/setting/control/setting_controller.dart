
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/services/exam_and_subjects_services.dart';

import '../../../data/models/exams_and_subject.dart';


class SettingController extends GetxController {

  final StorageService _storageService;
  final ExamService _examService;

  Rxn<Exam> selectedExam = Rxn<Exam>();
  RxBool isTtsEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadExamFromStorage();
    isTtsEnabled.value = _storageService.loadTTsToggle();
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


  // Future<void> loadExamName() async {
  //   final examName = await _storageService.loadExamName();
  //   if (examName != null && examName.isNotEmpty) {
  //     selectedExamName.value = examName[0];
  //   }
  // }
}