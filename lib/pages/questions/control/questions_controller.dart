import 'dart:async';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import 'package:pocket_prep_exam/core/Utility/utils.dart';
import '../../../ad_manager/interstitial_ads.dart';
import '/pages/edite_subjects/controller/edite_subject_controller.dart';
import '/data/models/question_model.dart';
import '/services/questions_services.dart';

enum QuestionState { loading, success, error }

class QuestionController extends GetxController {
  final QuestionService _questionService;

  RxList<Question> questions = <Question>[].obs;
  RxList<Question> reviewQuestions = <Question>[].obs;
  List<Question>? originalAttemptQuestions;


  Map<int, String> subjectIdToName = {};

  Rx<QuestionState> state = QuestionState.loading.obs;
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

  RxBool isTimedQuiz = false.obs;
  RxInt remainingSeconds = 0.obs;
  int? timedQuizDuration;

  RxBool isMoveQuizView = false.obs;
  List<Question> quizQForTime = <Question>[];
  var selectedMinutes = 5.0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.find<InterstitialAdManager>().checkAndDisplayAd();
    fetchQuestions();
    // Get.find<EditeSubjectController>();
  }

  QuestionController({required QuestionService q}) : _questionService = q;

  // Reset Timer State
  void resetTimerState() {
    _startTime = null;
    _endTime = null;
    elapsedSeconds.value = 0;
    remainingSeconds.value = 0;
    selectedMinutes.value = 0;
    _timer?.cancel();
    _timer = null;
  }

  void resetController({bool isRetake = false}) {
    _resetQuizState(isRetake: isRetake);
  }

  void _resetQuizState({bool isRetake = false}) {
    if (isRetake) {
      currentPage.value = 0;
      isSubmitVisible.value = false;
      selectedOptions.clear();
      showExplanation.clear();
      flaggedQuestions.clear();
      reviewQuestions.clear();
      _startTime = null;
      _endTime = null;
      elapsedSeconds.value = 0;
      remainingSeconds.value = 0;
      _timer?.cancel();
      _timer = null;
      Utils.stopAll();
    } else {
      currentPage.value = 0;
      isSubmitVisible.value = false;
      selectedOptions.clear();
      showExplanation.clear();
      questions.clear();
      flaggedQuestions.clear();
      reviewQuestions.clear();
      resetTimerState();
      selectedMinutes.value = 5.0;
      isTimedQuiz.value = false;
      timedQuizDuration = null;
      Utils.stopAll();
    }
  }

  Future<void> fetchQuestions() async {
    final q = await _questionService.fetchAllQuestions();
    if (q.isNotEmpty) {
      questions.value = q;
    }
  }

  void updateMinutes(double value) {
    selectedMinutes.value = value;
  }

  void setReviewQuestions(List<int> questionIdsToReview,
      Map<int, int> userSelectedOptions,) {
    if (questions.isEmpty) {
      Get.snackbar('Error', 'Questions not loaded. Cannot set up review.');
      return;
    }
    reviewQuestions.assignAll(
      questionIdsToReview.map((id) => questions[id]).toList(),
    );
    selectedOptions.assignAll(userSelectedOptions);
    resetTimerState();
    currentPage.value = 0;
    state.value = QuestionState.success;
    isSubmitVisible.value = false;
  }

  void _startQuizTimer() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedSeconds.value = DateTime
          .now()
          .difference(_startTime!)
          .inSeconds;
    });
  }

  String getTimerDisplay() {
    if (isTimedQuiz.value) {
      return _formatTime(remainingSeconds.value);
    } else {
      return _formatTime(elapsedSeconds.value);
    }
  }

  Future<void> startQuizCommon({
    List<Question>? fixedQuestions,
    bool isFreeUser = false,
  }) async {
    try {
      state.value = QuestionState.loading;
      _resetQuizState();
      if (fixedQuestions != null && fixedQuestions.isNotEmpty) {
        questions.assignAll(fixedQuestions);
      } else {
        final controller = Get.find<EditeSubjectController>();
        final pool = isFreeUser
            ? controller.startQuizForFreeUser()
            : controller.startQuiz();
        questions.assignAll(pool);
      }
      if (questions.isEmpty) {
        state.value = QuestionState.error;
      } else {
        _startQuizTimer();
        state.value = QuestionState.success;
      }
    } catch (e) {
      state.value = QuestionState.error;
    }
  }


  Future<void> startQuiz({List<Question>? fixedQuestions}) async {
    await startQuizCommon(fixedQuestions: fixedQuestions, isFreeUser: false);
  }

  Future<void> startQuizForFreeUser({List<Question>? fixedQuestions}) async {
    await startQuizCommon(fixedQuestions: fixedQuestions, isFreeUser: true);
  }

  // Future<void> startQuiz({List<Question>? fixedQuestions}) async {
  //   try {
  //     state.value = QuestionState.loading;
  //     _resetQuizState();
  //     if (fixedQuestions != null && fixedQuestions.isNotEmpty) {
  //       questions.assignAll(fixedQuestions);
  //     } else {
  //       final pool = Get.find<EditeSubjectController>().startQuiz();
  //       questions.assignAll(pool);
  //     }
  //     if (questions.isEmpty) {
  //       state.value = QuestionState.error;
  //     } else {
  //       _startQuizTimer();
  //       state.value = QuestionState.success;
  //     }
  //   } catch (e) {
  //     state.value = QuestionState.error;
  //   }
  // }
  //
  // Future<void> startQuizForFreUser({List<Question>? fixedQuestions}) async {
  //   try {
  //     state.value = QuestionState.loading;
  //     _resetQuizState();
  //     if (fixedQuestions != null && fixedQuestions.isNotEmpty) {
  //       questions.assignAll(fixedQuestions);
  //     } else {
  //       final pool = Get.find<EditeSubjectController>().startQuizForFreeUser();
  //       questions.assignAll(pool);
  //     }
  //     if (questions.isEmpty) {
  //       state.value = QuestionState.error;
  //     } else {
  //       _startQuizTimer();
  //       state.value = QuestionState.success;
  //     }
  //   } catch (e) {
  //     state.value = QuestionState.error;
  //   }
  // }

  Future<void> initQuiz({
    required bool reviewMode,
    List<int>? questionIdsToReview,
    Map<int, int>? selectedOptions,
    List<Question>? allQuestions,
    bool isTimedQuiz = false,
    int? timedQuizMinutes,
    bool fromRetake = false,
  }) async {
    try {
      if (reviewMode && questionIdsToReview != null && selectedOptions != null) {
        setReviewQuestions(questionIdsToReview, selectedOptions);
        return;
      }
      if (!fromRetake && allQuestions != null) {
        originalAttemptQuestions = List.from(allQuestions);
      }
      final quizQuestions = fromRetake ? originalAttemptQuestions : allQuestions;
      if (quizQuestions == null || quizQuestions.isEmpty) {
        state.value = QuestionState.error;
        return;
      }
      if (isTimedQuiz && timedQuizMinutes != null) {
        await startQuizForTime(
          fixedQuestion: quizQuestions,
          timedSeconds: timedQuizMinutes,
        );
      } else {
        if(Get.find<RemoveAds>().isSubscribedGet.value){
          await startQuiz(fixedQuestions: quizQuestions);
        }else{
          await startQuizForFreeUser(fixedQuestions: quizQuestions);
        }

      }
    } catch (e) {
      state.value = QuestionState.error;
    }
  }


  Future<void> startQuizForTime({
    List<Question>? fixedQuestion,
    required int timedSeconds,
  }) async {
    try {
      state.value = QuestionState.loading;
      _resetQuizState();
      isTimedQuiz.value = true;
      if (timedSeconds <= 0) {
        state.value = QuestionState.error;
        return;
      }
      timedQuizDuration = timedSeconds;
      if (fixedQuestion != null && fixedQuestion.isNotEmpty) {
        await Future.delayed(const Duration(milliseconds: 300));
        questions.assignAll(fixedQuestion);
      } else {
        final pool = await Get.find<EditeSubjectController>().startQuizForTime();
        await Future.delayed(const Duration(milliseconds: 300));
        questions.assignAll(pool);
      }
      if (questions.isEmpty) {
        state.value = QuestionState.error;
        return;
      }
      _startTimedQuizCountdown();
      state.value = QuestionState.success;
      if (questions.length == 1) {
        Future.delayed(const Duration(milliseconds: 100), () {
          isSubmitVisible.value = true;
        });
      }
    } catch (e) {
      state.value = QuestionState.error;
    }
  }


  void _startTimedQuizCountdown() {
    _timer?.cancel();
    _startTime = DateTime.now();
    remainingSeconds.value = timedQuizDuration!;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        isSubmitVisible.value = true;
        _timer?.cancel();
      }
    });
  }
  void _stopQuizTimer() {
    _endTime = DateTime.now();
    _timer?.cancel();
  }
  void selectOption(
    int questionIndex,
    int optionIndex,
    String option,
    String correctAnswer,
  )async {
    if (selectedOptions[questionIndex] != null) return;
    selectedOptions[questionIndex] = optionIndex;
    String optionPrefix = option.trim().isNotEmpty
        ? option.trim().substring(0, 1).toUpperCase()
        : '';
    String correctPrefix = correctAnswer.trim().isNotEmpty
        ? correctAnswer.trim().substring(0, 1).toUpperCase()
        : '';
    bool isCorrect = optionPrefix == correctPrefix;
    await Utils.playSound(isCorrect);
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
    if (questions.length == 1|| index == questions.length - 1) {
      isSubmitVisible.value = true;
    }
  }

  String _normalizeAnswer(String text) {
    String clean = text.trim();
    if (clean.length > 1 &&
        ((clean.length > 2 &&
                (clean[1] == "." || clean[1] == ")" || clean[1] == ":")) ||
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
      if (qIndex < questions.length &&
          optionIndex < questions[qIndex].options.length) {
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
      'percentage':
          totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0,
      'flagged': List<int>.from(flaggedQuestions),
      'correctQuestionIds': correctIds,
      'incorrectQuestionIds': incorrectIds,
      'selectedOptions': Map<int, int>.from(selectedOptions),
      'timeTaken': timeTaken,
    };
  }

  @override
  void onClose() {
    _resetQuizState();
    _timer?.cancel();
    super.onClose();
  }
}
