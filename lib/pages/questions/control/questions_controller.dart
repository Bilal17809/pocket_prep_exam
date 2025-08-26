import 'package:get/get.dart';

import '../../../data/models/question_model.dart';
import '../../../services/questions_services.dart';


class QuestionController extends GetxController {
  final QuestionService _service = QuestionService();

  RxList<Question> questions = <Question>[].obs;
  RxBool isLoading = true.obs;

  void loadQuestions(int subjectId) async {
    isLoading.value = true;
    try {
      final result = await _service.fetchQuestionsBySubject(subjectId);
      questions.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load questions: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
