import 'dart:async';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/data/models/models.dart';
import '../../quiz_setup/controller/quiz_setup_controller.dart';

enum QuizState { loading, success, error }

class QuizController extends GetxController {
  var selectedOptions = <int, int>{}.obs;
  var showExplanation = <int, bool>{}.obs;
  var remainingTime = <int, int>{}.obs;
  var currentPage = 0.obs;
  RxBool isSubmitVisible = false.obs;
  var elapsedTime = 0.obs;

  Timer? _questionTimer;
  Timer? _globalTimer;

  final state = QuizState.loading.obs;

  List<Question> questions = [];

  @override
  void onInit() {
    super.onInit();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      state.value = QuizState.loading;
      final setupController = Get.find<QuizSetupController>();
      await Future.delayed(const Duration(milliseconds: 500));
      questions = setupController.finalSelectedQuestions;
      if (questions.isEmpty) {
        state.value = QuizState.error;
      } else {
        state.value = QuizState.success;
        _startGlobalTimer();
        startTimerForQuestion(0);
      }
    } catch (e) {
      state.value = QuizState.error;
    }
  }

  void startTimerForQuestion(int questionIndex) {
    final selectedTime = Get.find<QuizSetupController>().selectedTimeLimit.value;
    _stopQuestionTimer();
    if (selectedOptions.containsKey(questionIndex)) return;
    remainingTime[questionIndex] = selectedTime;
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
      _stopQuestionTimer();
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

  int get totalCorrect {
    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedOptions.containsKey(i)) {
        final selectedIndex = selectedOptions[i]!;
        final correctIndex = getCorrectOptionIndex(
          questions[i].correctAnswer,
          questions[i].options,
        );
        if (selectedIndex == correctIndex) correct++;
      }
    }
    return correct;
  }

  int get totalSkipped {
    return questions.length - selectedOptions.length;
  }

  int get totalWrong {
    return selectedOptions.entries.where((entry) {
      final q = questions[entry.key];
      final correctIndex =
      getCorrectOptionIndex(q.correctAnswer, q.options);
      return entry.value != correctIndex;
    }).length;
  }

  int get quizSetupTime {
    final setupController = Get.find<QuizSetupController>();
    return setupController.selectedTimeLimit.value;
  }


  void _startGlobalTimer() {
    _stopGlobalTimer();
    elapsedTime.value = 0;
    _globalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedTime.value++;
    });
  }


  void _stopQuestionTimer() {
    _questionTimer?.cancel();
    _questionTimer = null;
  }

  void _stopGlobalTimer() {
    _globalTimer?.cancel();
    _globalTimer = null;
  }

  void stopAllTimers() {
    _stopQuestionTimer();
    _stopGlobalTimer();
  }

  QuizResult generateResult() {
    final selectedQTime = Get.find<QuizSetupController>().selectedTimeLimit.value;
    final totalCorrect = selectedOptions.entries.where((e) {
      final q = questions[e.key];
      return getCorrectOptionIndex(q.correctAnswer, q.options) == e.value;
    }).length;
    final totalSkipped = questions.length - selectedOptions.length;
    final totalWrong = selectedOptions.length - totalCorrect;
    stopAllTimers();
    return QuizResult(
      totalCorrect: totalCorrect,
      totalSkipped: totalSkipped,
      totalWrong: totalWrong,
      totalTime: elapsedTime.value,
      selectedQuizTime: selectedQTime,
      totalQuestions: questions.length,
    );
  }

  void stopTimer() {
    stopAllTimers();
  }

  @override
  void onClose() {
    stopAllTimers();
    super.onClose();
  }

  void resetQuiz() {
    selectedOptions.clear();
    showExplanation.clear();
    remainingTime.clear();
    currentPage.value = 0;
    isSubmitVisible.value = false;
    elapsedTime.value = 0;
    stopAllTimers();
    // questions = [];
    // state.value = QuizState.loading;
  }
}



class QuizResult {
  final int totalCorrect;
  final int totalSkipped;
  final int totalWrong;
  final int totalTime;
  final int selectedQuizTime;
  final int totalQuestions;

  QuizResult({
    required this.totalCorrect,
    required this.totalSkipped,
    required this.totalWrong,
    required this.totalTime,
    required this.selectedQuizTime,
    required this.totalQuestions,
  });

  Map<String, dynamic> toJson() => {
    "totalCorrect": totalCorrect,
    "totalSkipped": totalSkipped,
    "totalWrong": totalWrong,
    "totalTime": totalTime,
    "selectedQuizTime": selectedQuizTime,
    "totalQuestions": totalQuestions,
  };
  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
    totalCorrect: json["totalCorrect"],
    totalSkipped: json["totalSkipped"],
    totalWrong: json["totalWrong"],
    totalTime: json["totalTime"],
    selectedQuizTime: json["selectedQuizTime"],
    totalQuestions: json["totalQuestions"],
  );
}