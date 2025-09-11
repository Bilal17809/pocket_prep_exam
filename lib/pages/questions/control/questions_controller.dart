import 'package:get/get.dart';
import '../../../data/models/question_model.dart';
import '../../../services/questions_services.dart';

class QuestionController extends GetxController {
  final QuestionService _service = QuestionService();

  RxList<Question> questions = <Question>[].obs;
  RxBool isLoading = true.obs;


  var selectedOptions = <int, int>{}.obs;
  var showExplanation = <int, bool>{}.obs;

  void loadQuestions(int subjectId) async {
    isLoading.value = true;
    try {
      final result = await _service.fetchQuestionsBySubject(subjectId);
      questions.assignAll(result);
      selectedOptions.clear();
      showExplanation.clear();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load questions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectOption(int questionIndex, int optionIndex, String option, String correctAnswer) {
    if (selectedOptions[questionIndex] != null) {
      return;
    }
    selectedOptions[questionIndex] = optionIndex;
    showExplanation[questionIndex] = true;
  }

  void toggleExplanation(int questionIndex) {
    bool current = showExplanation[questionIndex] ?? false;
    showExplanation[questionIndex] = !current;
  }
}
