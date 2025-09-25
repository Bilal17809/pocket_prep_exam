import 'dart:async';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/data/models/models.dart';
import '../../quiz_setup/controller/quiz_setup_controller.dart';

class QuizController extends GetxController {

  var selectedOptions = <int, int>{}.obs;
  var showExplanation = <int, bool>{}.obs;
  var remainingTime = <int, int>{}.obs;
  var currentPage = 0.obs;
  RxBool isSubmitVisible = false.obs;
  Timer? _activeTimer;

  final finalSelectionQuestion = Get.find<QuizSetupController>().finalSelectedQuestions;
  List<Question> get questions => finalSelectionQuestion;

  @override
  void onInit() {
    super.onInit();
    startTimerForQuestion(0);
  }

  void startTimerForQuestion(int questionIndex) {
    final selectedTime =  Get.find<QuizSetupController>().selectedTimeLimit.value;
    stopTimer();
    if (selectedOptions.containsKey(questionIndex)) return;
    remainingTime[questionIndex] = selectedTime;
    _activeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime[questionIndex]! > 0) {
        remainingTime[questionIndex] = remainingTime[questionIndex]! - 1;
      } else {
        timer.cancel();
        _autoSelectCorrectAnswer(questionIndex);
      }
    });
  }

  void selectOption(int questionIndex, int optionIndex, String selected, String correct) {
    if (!selectedOptions.containsKey(questionIndex)) {
      selectedOptions[questionIndex] = optionIndex;
      stopTimer();
    }
  }

  void toggleExplanation(int questionIndex) {
    showExplanation[questionIndex] = !(showExplanation[questionIndex] ?? false);
  }

  int getCorrectOptionIndex(String correctAnswer, List<String> options) {
    String correctPrefix = correctAnswer.trim().isNotEmpty
        ? correctAnswer.trim().substring(0, 1).toUpperCase()
        : '';
    for (int i = 0; i < options.length; i++) {
      String optionPrefix = options[i].trim().isNotEmpty
          ? options[i].trim().substring(0, 1).toUpperCase()
          : '';
      if (optionPrefix == correctPrefix) {
        return i;
      }
    }
    return -1;
  }

  void _autoSelectCorrectAnswer(int questionIndex) {
    if (!selectedOptions.containsKey(questionIndex)) {
      final question = questions[questionIndex];
      int correctIndex = getCorrectOptionIndex(question.correctAnswer, question.options);
      if (correctIndex != -1) {
        selectedOptions[questionIndex] = correctIndex;
        showExplanation[questionIndex] = false;
      }
    }
  }
  void stopTimer() {
    _activeTimer?.cancel();
    _activeTimer = null;
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }
}
