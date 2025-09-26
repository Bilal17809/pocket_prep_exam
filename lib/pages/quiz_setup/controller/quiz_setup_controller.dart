import 'package:get/get.dart';
import 'package:pocket_prep_exam/data/models/models.dart';
import 'package:pocket_prep_exam/pages/quiz_view_second/controller/quiz_controller.dart';
import 'package:pocket_prep_exam/services/services.dart';

class QuizSetupController extends GetxController {


  final QuestionService _questionService;


  var selectedSubject = Rxn<Subject>();
  var selectedDifficulty = "Easy".obs;
  var selectedTimeLimit = 30.obs;
  var selectedQuestions = 10.obs;
  var subjectQuestions = <Question>[].obs;

  QuizSetupController({required QuestionService questionService})
      : _questionService = questionService;


  Future<void> setSubject(Subject subject) async {
    // clearQuiz();
    selectedSubject.value = subject;
    final allQuestions = await _questionService.fetchAllQuestions();
    subjectQuestions.assignAll(allQuestions.where((q) => q.subjectId == subject.subjectId).toList(),
    );
    setDifficulty("Easy");
  }

  List<int> get questionOptions {
    switch (selectedDifficulty.value) {
      case "Medium":
        return [10, 20];
      case "Hard":
        return [10, 15];
      case "Easy":
      default:
        return [10, 30];
    }
  }

  List<int> get timeOptions => [30, 60, 300];

  void setDifficulty(String difficulty) {
    selectedDifficulty.value = difficulty;
    selectedQuestions.value = questionOptions.first;
    selectedTimeLimit.value = 30;
  }
  void setQuestions(int count) {
    selectedQuestions.value = count;
  }
  void setTimeLimit(int time) {
    selectedTimeLimit.value = time;
  }

    void clearQuiz(){
      Get.delete<QuizController>();
     Get.find<QuizController>().resetQuiz();
    }

  List<Question> get finalSelectedQuestions {
    return subjectQuestions.take(selectedQuestions.value).toList();
  }


}
