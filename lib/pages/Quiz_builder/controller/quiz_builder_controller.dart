import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/controller/edite_subject_controller.dart';
import '/services/exam_and_subjects_services.dart';
import '/data/models/exams_and_subject.dart';
import '/data/models/question_model.dart';
import '/services/questions_services.dart';

class QuizBuilderController extends GetxController {
  final ExamService _examService;
  final QuestionService _questionService;

  Rxn<Exam> exams = Rxn<Exam>();
  RxList<Exam> selectedExams = <Exam>[].obs;
  RxList<Subject> allSubjects = <Subject>[].obs;
  RxList<Subject> selectedSubjects = <Subject>[].obs;
  RxMap<int, int> questionCountPerSubject = <int, int>{}.obs;
  Rx<Duration> selectedTime = const Duration(minutes: 0).obs;
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
      final selectedExam = Get.find<EditeSubjectController>().selectedExam.value;
      if (selectedExam != null) {
        exams.value = selectedExam;
        selectedExams.assignAll([selectedExam]);
        allSubjects.assignAll(selectedExam.subjects);
      } else {
        selectedExams.clear();
        allSubjects.clear();
      }
    } catch (e) {
      print('Error fetching exams: $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> fetchAllQuestions() async {
    try {
      final questions = await _questionService.fetchAllQuestions();
      final selectedExam = Get.find<EditeSubjectController>().selectedExam.value;

      if (selectedExam != null) {
        final subjectIds = selectedExam.subjects.map((s) => s.subjectId).toList();
        final filteredQuestions = questions
            .where((q) => subjectIds.contains(q.subjectId))
            .toList();
        allQuestions.assignAll(filteredQuestions);
      } else {
        allQuestions.assignAll(questions);
      }
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }


  int getQuestionCountBySubject(int subjectId) {
    return allQuestions.where((q) => q.subjectId == subjectId).length;
  }

  // void toggleExamSelection(Exam exam) {
  //   if (selectedExams.contains(exam)) {
  //     selectedExams.remove(exam);
  //   } else {
  //     selectedExams.add(exam);
  //   }

  //   final all = selectedExams.expand((e) => e.subjects).toList();
  //   allSubjects.value = all;
  //   selectedSubjects.clear();
  //   questionCountPerSubject.clear();
  // }
  //
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

  void setQuizDuration(Duration duration) {
    if (duration.inSeconds < 0) {
      return;
    }
    selectedTime.value = duration;
  }

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

    if (parts.isEmpty) {
      return "0s";
    }
    return parts.join(" ");
  }

  int get totalQuizSeconds => selectedTime.value.inSeconds;

  Future<List<Question>> prepareQuizQuestions() async {
    if (selectedSubjects.isEmpty) {
      Get.snackbar("Selection Required", "Please select at least one subject");
      return [];
    }
    final quizQuestions = <Question>[];
    for (var subject in selectedSubjects) {
      final count = questionCountPerSubject[subject.subjectId] ?? 0;
      if (count <= 0) continue;
      final filtered = allQuestions
          .where((q) => q.subjectId == subject.subjectId)
          .toList();
      quizQuestions.addAll(filtered.take(count));
    }
    if (quizQuestions.isEmpty) {
      Get.snackbar("No Questions", "No questions found for selected subjects");
    }
    return quizQuestions;
  }


  void resetQuizBuilder() {
    selectedExams.clear();
    selectedSubjects.clear();
    allSubjects.clear();
    questionCountPerSubject.clear();
    selectedTime.value = const Duration(minutes: 1);
  }
}