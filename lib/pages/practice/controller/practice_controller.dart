import 'package:get/get.dart';
import '../../../ad_manager/interstitial_ads.dart';
import '/core/local_storage/storage_helper.dart';
import '/data/models/models.dart';
import '/pages/edite_subjects/controller/edite_subject_controller.dart';
import '/pages/quiz_setup/controller/quiz_setup_controller.dart';
import '/services/services.dart';
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
    Get.find<InterstitialAdManager>().checkAndDisplayAd();
    super.onInit();
    loadExam();
  }

  final showQuizTime = Get.find<QuizSetupController>().selectedTimeLimit.value;

  Future<void> loadExam() async {
    isLoading.value = true;
    try {
      final exam = Get.find<EditeSubjectController>().selectedExam.value;
      final questions = await _questionService.fetchAllQuestions();
      allQuestions.assignAll(questions);
      if (exam != null) {
        selectExam.value = exam;
        final result = await _storageService.loadQuizResult(exam.examId);
        if (result != null) {
          savedResult.value = result;
        } else {
          savedResult.value = null;
        }
      } else {
        savedResult.value = null;
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