import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/data/models/models.dart';
import 'package:pocket_prep_exam/pages/quiz_setup/controller/quiz_setup_controller.dart';
import 'package:pocket_prep_exam/pages/study/controller/study_controller.dart';
import 'package:pocket_prep_exam/services/services.dart';

import '../../quiz_view_second/controller/quiz_controller.dart';


class PracticeController extends GetxController {

  final QuestionService _questionService;
  final StorageService _storageService;

  Rxn<Exam> selectExam = Rxn<Exam>();
  RxList<Question> allQuestions = <Question>[].obs;
  final isLoading = false.obs;
  Rxn<QuizResult> savedResult = Rxn<QuizResult>();

  PracticeController({required QuestionService questionService, required StorageService storageServices })
      : _questionService = questionService ,_storageService = storageServices;


  @override
  void onInit() {
    super.onInit();
    loadExam();
  }

  final showQuizTime = Get.find<QuizSetupController>().selectedTimeLimit.value;

  Future<void> loadExam() async {
    isLoading.value = true;
    try {
      final exam = Get.find<StudyController>().selectedExam.value;
      final questions = await _questionService.fetchAllQuestions();
      allQuestions.assignAll(questions);
      if (exam != null) {
        selectExam.value = exam;
      }
      final result = await _storageService.loadQuizResult();
      if (result != null) {
        savedResult.value = result;
      } else {
      }
    } finally {
      isLoading.value = false;
    }
  }

  int? getQuestionCountBySubject(int subjectId) {
    return allQuestions.where((q) => q.subjectId == subjectId).length;
  }

  List<Question> getQuestionsBySubject(int subjectId) {
    return allQuestions.where((q) => q.subjectId == subjectId).toList();
  }
}