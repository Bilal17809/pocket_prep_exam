import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/services/questions_services.dart';
import '../../quiz_setup/controller/quiz_setup_controller.dart';
import '../../study/controller/study_controller.dart';
import '/data/models/question_model.dart';
import '../../study/controller/study_controller.dart';
import '/data/models/exams_and_subject.dart';
import '../../quiz_view_second/controller/quiz_controller.dart';

class StatsController extends GetxController {

  final QuestionService _questionService;
  final StorageService _storageService;
  Rxn<Exam> selectExam = Rxn<Exam>();
  RxList<Question> allQuestions = <Question>[].obs;
  final isLoading = false.obs;
  var subjectResults = <int, List<QuizResult>>{}.obs;

  StatsController({required QuestionService questionService, required storageServices})
      : _questionService = questionService,_storageService =storageServices;

  @override
  void onInit() {
    super.onInit();
    loadExam();
  }


  Future<void> loadExam() async {
    isLoading.value = true;
    try {
      final exam = Get.find<StudyController>().selectedExam.value;
      if (exam != null) {
        selectExam.value = exam;
        subjectResults.value = await _storageService.loadExamResults(exam.examId);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveResultAndStore(Subject subject, QuizResult result) async {
    saveResult(subject, result);
    final examId = selectExam.value!.examId;
      await _storageService.saveQuizResult(examId, result);

  }


  void saveResult(Subject subject, QuizResult result) async {
    if (!subjectResults.containsKey(subject.subjectId)) {
      subjectResults[subject.subjectId] = [];
    }
    subjectResults[subject.subjectId]!.add(result);
    final examId = selectExam.value?.examId;
    if (examId != null) {
      await _storageService.saveExamResults(examId, subjectResults);
    }
  }


  QuizResult? latestResultForSubject(int subjectId) {
    final results = subjectResults[subjectId];
    if (results == null || results.isEmpty) return null;
    return results.last;
  }

  int quizTimesForSubject(int subjectId) {
    return subjectResults[subjectId]?.length ?? 0;
  }

  // Calculate average time across all quiz attempts
  String get averageTime {
    if (subjectResults.isEmpty) return "00:00";
    int totalTime = 0;
    int totalAttempts = 0;
    for (var results in subjectResults.values) {
      for (var result in results) {
        totalTime += result.totalTime;
        totalAttempts++;
      }
    }
    if (totalAttempts == 0) return "00:00";
    final avgTimeInSeconds = totalTime ~/ totalAttempts;
    return _formatTime(avgTimeInSeconds);
  }

  // Calculate average questions across all quiz attempts
  String get averageQuestions {
    if (subjectResults.isEmpty) return "0.0";
    int totalQuestions = 0;
    int totalAttempts = 0;
    for (var results in subjectResults.values) {
      for (var result in results) {
        totalQuestions += result.totalQuestions;
        totalAttempts++;
      }
    }
    if (totalAttempts == 0) return "0.0";
    final avgQuestions = totalQuestions / totalAttempts;
    return avgQuestions.toStringAsFixed(1);
  }

  // Calculate overall progress percentage
  String get overallProgressPercentage {
    if (selectExam.value == null || selectExam.value!.subjects.isEmpty) return "0%";
    final totalSubjects = selectExam.value!.subjects.length;
    int completedSubjects = 0;
    // Count subjects that have at least one quiz attempt
    for (var subject in selectExam.value!.subjects) {
      if (subjectResults.containsKey(subject.subjectId) &&
          subjectResults[subject.subjectId]!.isNotEmpty) {
        completedSubjects++;
      }
    }
    final percentage = (completedSubjects / totalSubjects) * 100;
    return "${percentage.toInt()}%";
  }

  // Get progress value for CircularProgressIndicator (0.0 to 1.0)
  double get progressValue {
    if (selectExam.value == null || selectExam.value!.subjects.isEmpty) return 0.0;
    final totalSubjects = selectExam.value!.subjects.length;
    int completedSubjects = 0;
    for (var subject in selectExam.value!.subjects) {
      if (subjectResults.containsKey(subject.subjectId) &&
          subjectResults[subject.subjectId]!.isNotEmpty) {
        completedSubjects++;
      }
    }
    return completedSubjects / totalSubjects;
  }

  int get totalQuizAttempts {
    int total = 0;
    for (var results in subjectResults.values) {
      total += results.length;
    }
    return total;
  }
  int get subjectsAttempted {
    return subjectResults.keys.where((subjectId) =>
    subjectResults[subjectId]!.isNotEmpty).length;
  }
  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(
        2, '0')}";
  }


  @override
  void onClose() {
    subjectResults.clear();
    selectExam.value = null;
    allQuestions.clear();
    super.onClose();
  }
}