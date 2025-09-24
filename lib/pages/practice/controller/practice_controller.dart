import 'package:get/get.dart';
import 'package:pocket_prep_exam/data/models/models.dart';
import 'package:pocket_prep_exam/pages/study/controller/study_controller.dart';
import 'package:pocket_prep_exam/services/services.dart';


class PracticeController extends GetxController {
  final QuestionService _questionService;

  Rxn<Exam> selectExam = Rxn<Exam>();
  RxList<Question> allQuestions = <Question>[].obs;
  RxList<Question> subjectQuestion = <Question>[].obs;
  final isLoading = false.obs;

  PracticeController({required QuestionService questionService}) : _questionService = questionService;


  @override
  void onInit() {
    super.onInit();
    loadExam();
  }

 Future<void>loadExam() async{
    isLoading.value = true;
    try {
      final exam = Get.find<StudyController>().selectedExam.value;
      final questions = await _questionService.fetchAllQuestions();
      allQuestions.assignAll(questions);
      if (exam != null) {
        selectExam.value = exam;
      }
    } finally {
      isLoading.value = false;
    }
  }

  int? getQuestionCountBySubject(int subjectId) {
    return allQuestions.where((q) => q.subjectId == subjectId).length;
  }
}