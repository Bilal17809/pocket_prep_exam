
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/services/exam_and_subjects_services.dart';

import '../../../ad_manager/interstitial_ads.dart';
import '/data/models/exams_and_subject.dart';

class ExamSettingController extends GetxController{

  final StorageService _storageService;
  final ExamService _examService;


  Rxn<Exam> selectedExam = Rxn<Exam>();

  ExamSettingController({required StorageService storageServices,
    required ExamService examService}):
        _storageService = storageServices , _examService = examService;

  @override
  void onInit() {
    super.onInit();
    Get.find<InterstitialAdManager>().checkAndDisplayAd();
    loadExamFromStorage();
  }

  Future<void> loadExamFromStorage() async {
    final examId = await _storageService.getExam();
    final exams = await _examService.fetchExams();
    if (examId != null) {
      selectedExam.value = exams.firstWhere((e) => e.examId == examId);
    }
  }

}