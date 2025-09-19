
import 'package:get/get.dart';
import '/data/models/question_model.dart';
import '/services/questions_services.dart';
import 'dart:async';

class QuestionController extends GetxController {
  final QuestionService _service;

  RxList<Question> questions = <Question>[].obs;
  RxList<Question> reviewQuestions = <Question>[].obs;
  RxBool isLoading = true.obs;
  var currentPage = 0.obs;
  var isSubmitVisible = false.obs;
  RxBool isFlag = false.obs;

  var selectedOptions = <int, int>{}.obs;
  var showExplanation = <int, bool>{}.obs;
  var flaggedQuestions = <int>[].obs;

  DateTime? _startTime;
  DateTime? _endTime;
  var elapsedSeconds = 0.obs;
  Timer? _timer;

  QuestionController({required QuestionService q}) : _service = q;

  void _resetTimerState() {
    _startTime = null;
    _endTime = null;
    elapsedSeconds.value = 0;
    _timer?.cancel();
    _timer = null;
  }

  void _resetQuizState() {
    currentPage.value = 0;
    isSubmitVisible.value = false;
    selectedOptions.clear();
    showExplanation.clear();
    questions.clear();
    flaggedQuestions.clear();
    reviewQuestions.clear();
    _resetTimerState();
  }

  Future<void> loadQuestions() async {
    isLoading.value = true;
    _resetQuizState();
    try {
      final result = await _service.fetchAllQuestions();
      questions.assignAll(result);
      _startQuizTimer();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load questions: $e');
    } finally {
      isLoading.value = false;
    }
  }


  void setReviewQuestions(List<int> questionIdsToReview, Map<int, int> userSelectedOptions) {
    if (questions.isEmpty) {
      Get.snackbar('Error', 'Questions not loaded. Cannot set up review.');
      return;
    }
    reviewQuestions.assignAll(questionIdsToReview.map((id) => questions[id]).toList());
    selectedOptions.assignAll(userSelectedOptions);
    _resetTimerState();
    currentPage.value = 0;
    isLoading.value = false;
    isSubmitVisible.value = false;
  }
  void _startQuizTimer() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedSeconds.value = DateTime.now().difference(_startTime!).inSeconds;
    });
  }

  void _stopQuizTimer() {
    _endTime = DateTime.now();
    _timer?.cancel();
  }

  void selectOption(int questionIndex, int optionIndex, String option, String correctAnswer) {
    if (selectedOptions[questionIndex] != null) return;
    selectedOptions[questionIndex] = optionIndex;
  }

  void toggleExplanation(int questionIndex) {
    showExplanation[questionIndex] = !(showExplanation[questionIndex] ?? false);
  }

  void toggleFlag(int questionIndex) {
    if (flaggedQuestions.contains(questionIndex)) {
      flaggedQuestions.remove(questionIndex);
    } else {
      flaggedQuestions.add(questionIndex);
    }
  }

  void onPageChange(int index) {
    currentPage.value = index;
    if (index == questions.length - 1) {
      isSubmitVisible.value = true;
    }
  }

  String _normalizeAnswer(String text) {
    String clean = text.trim();
    if (clean.length > 1 &&
        ((clean.length > 2 && (clean[1] == "." || clean[1] == ")" || clean[1] == ":")) ||
            (clean.length == 1))) {
      return clean[0].toUpperCase();
    }
    return clean.toUpperCase();
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    if (minutes == 0) {
      return "${seconds}s";
    } else {
      return "${minutes}m ${seconds}s";
    }
  }

  Map<String, dynamic> calculateQuizResults() {
    _stopQuizTimer();
    int totalQuestions = questions.length;
    int answeredQuestions = selectedOptions.length;
    int correctAnswers = 0;
    int incorrectAnswers = 0;
    List<int> correctIds = [];
    List<int> incorrectIds = [];

    String timeTaken = "0s";
    if (_startTime != null && _endTime != null) {
      final duration = _endTime!.difference(_startTime!);
      timeTaken = _formatTime(duration.inSeconds);
    } else if (_startTime != null) {
      final duration = DateTime.now().difference(_startTime!);
      timeTaken = _formatTime(duration.inSeconds);
    }

    selectedOptions.forEach((qIndex, optionIndex) {
      if (qIndex < questions.length && optionIndex < questions[qIndex].options.length) {
        final q = questions[qIndex];
        final selected = q.options[optionIndex];
        String normalizedSelected = _normalizeAnswer(selected);
        String normalizedCorrect = _normalizeAnswer(q.correctAnswer);
        if (normalizedSelected == normalizedCorrect) {
          correctAnswers++;
          correctIds.add(qIndex);
        } else {
          incorrectAnswers++;
          incorrectIds.add(qIndex);
        }
      }
    });
    return {
      'totalQuestions': totalQuestions,
      'answered': answeredQuestions,
      'correct': correctAnswers,
      'incorrect': incorrectAnswers,
      'unanswered': totalQuestions - answeredQuestions,
      'percentage': totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0,
      'flagged': List<int>.from(flaggedQuestions),
      'correctQuestionIds': correctIds,
      'incorrectQuestionIds': incorrectIds,
      'selectedOptions': Map<int, int>.from(selectedOptions),
      'timeTaken': timeTaken,
    };
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}