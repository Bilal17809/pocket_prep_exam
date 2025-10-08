import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/questions/control/questions_controller.dart';
import '../../questions/view/questions_view.dart';
import '/services/exam_and_subjects_services.dart';
import '/data/models/exams_and_subject.dart';
import '/data/models/question_model.dart';
import '/services/questions_services.dart';

class QuizBuilderController extends GetxController {
  final ExamService _examService;
  final QuestionService _questionService;

  RxList<Exam> exams = <Exam>[].obs;
  RxList<Exam> selectedExams = <Exam>[].obs;
  RxList<Subject> allSubjects = <Subject>[].obs;
  RxList<Subject> selectedSubjects = <Subject>[].obs;
  RxMap<int, int> questionCountPerSubject = <int, int>{}.obs;

  // ✅ Store as Duration for consistency
  Rx<Duration> selectedTime = const Duration(minutes: 1).obs;
  RxBool isLoading = false.obs;
  RxList<Question> allQuestions = <Question>[].obs;

  QuizBuilderController({
    required ExamService examService,
    required QuestionService questionService,
  })  : _examService = examService,
        _questionService = questionService;

  @override
  void onInit() {
    super.onInit();
    fetchExams();
    fetchAllQuestions();
  }

  Future<void> fetchExams() async {
    try {
      isLoading.value = true;
      exams.value = await _examService.fetchExams();
    } catch (e) {
      print('Error fetching exams: $e');
      Get.snackbar('Error', 'Failed to load exams');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllQuestions() async {
    try {
      final questions = await _questionService.fetchAllQuestions();
      allQuestions.assignAll(questions);
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }

  int getQuestionCountBySubject(int subjectId) {
    return allQuestions.where((q) => q.subjectId == subjectId).length;
  }

  void toggleExamSelection(Exam exam) {
    if (selectedExams.contains(exam)) {
      selectedExams.remove(exam);
    } else {
      selectedExams.add(exam);
    }

    final all = selectedExams.expand((e) => e.subjects).toList();
    allSubjects.value = all;
    selectedSubjects.clear();
    questionCountPerSubject.clear();
  }

  void toggleSubjectSelection(Subject subject) {
    if (selectedSubjects.contains(subject)) {
      selectedSubjects.remove(subject);
      questionCountPerSubject.remove(subject.subjectId);
    } else {
      selectedSubjects.add(subject);
    }
  }

  void setQuestionCount(int subjectId, int count) {
    questionCountPerSubject[subjectId] = count;
  }

  /// ✅ PRODUCTION: Clean duration setter
  void setQuizDuration(Duration duration) {
    if (duration.inSeconds < 0) {
      print('Warning: Negative duration not allowed');
      return;
    }
    selectedTime.value = duration;
  }

  /// ✅ PRODUCTION: Smart formatted duration with proper grammar
  String get formattedDuration {
    final d = selectedTime.value;
    final totalSeconds = d.inSeconds;

    if (totalSeconds == 0) {
      return "Not set";
    }

    final hours = d.inHours;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;

    List<String> parts = [];

    if (hours > 0) {
      parts.add("${hours}h");
    }
    if (minutes > 0) {
      parts.add("${minutes}m");
    }
    if (seconds > 0) {
      parts.add("${seconds}s");
    }

    // If no parts (edge case), show seconds
    if (parts.isEmpty) {
      return "0s";
    }

    return parts.join(" ");
  }

  /// ✅ PRODUCTION: Get total seconds for quiz timer
  int get totalQuizSeconds => selectedTime.value.inSeconds;

  Future<List<Question>> prepareQuizQuestions() async {
    if (selectedSubjects.isEmpty) {
      Get.snackbar(
        "Selection Required",
        "Please select at least one subject",
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }

    if (questionCountPerSubject.isEmpty) {
      Get.snackbar(
        "Question Count Required",
        "Please set question count for selected subjects",
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }

    final allQuestionsForQuiz = <Question>[];
    for (var subject in selectedSubjects) {
      final requestedCount = questionCountPerSubject[subject.subjectId] ?? 0;
      if (requestedCount <= 0) {
        continue;
      }
      final filtered = allQuestions
          .where((q) => q.subjectId == subject.subjectId)
          .toList();

      if (filtered.isEmpty) {
        print('Warning: No questions found for subject ${subject.subjectId}');
        continue;
      }
      final questionsToAdd = filtered.take(requestedCount).toList();
      allQuestionsForQuiz.addAll(questionsToAdd);
    }
    if (allQuestionsForQuiz.isEmpty) {
      Get.snackbar(
        "No Questions Available",
        "No questions found for selected subjects",
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }

    // Optional: Shuffle questions for randomization
    // allQuestionsForQuiz.shuffle();

    return allQuestionsForQuiz;
  }

  /// ✅ PRODUCTION: Reset controller state
  void resetQuizBuilder() {
    selectedExams.clear();
    selectedSubjects.clear();
    allSubjects.clear();
    questionCountPerSubject.clear();
    selectedTime.value = const Duration(minutes: 1);
  }
}