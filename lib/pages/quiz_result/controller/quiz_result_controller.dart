
import 'package:get/get.dart';
import 'package:pocket_prep_exam/data/models/exams_and_subject.dart';
import 'package:pocket_prep_exam/services/exam_and_subjects_services.dart';
import 'package:pocket_prep_exam/services/questions_services.dart';
import '/data/models/question_model.dart';


class QuizResultController extends GetxController {

  final ExamService examService = ExamService();
  final QuestionService _service = QuestionService();
  var selectedIndex = 0.obs;
  var exams = <Exam>[].obs;

  // List<Subject> modelList=<Subject>[];
  RxList<Question> questions = <Question>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetcExam();
  }
  Future<void> fetcExam() async {
    try {
      final data = await examService.fetchExams();
      exams.assignAll(data);
    } catch (e) {
      print("Error $e");
    }
  }

  void loadQuestions(int subjectId) async {
    // isLoading.value = true;
    try {
      final result = await _service.fetchAllQuestions();
      questions.assignAll(result);
      print("Questions loaded successfully. Total questions: ${questions.length}");
    } catch (e) {
      Get.snackbar('Error', 'Failed to load questions: $e');
    } finally {
      // isLoading.value = false;
    }
  }

}
