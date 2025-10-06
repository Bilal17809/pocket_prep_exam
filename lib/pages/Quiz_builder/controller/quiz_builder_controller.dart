import 'package:get/get.dart';
import '../../../services/exam_and_subjects_services.dart';
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
  Rx<Duration> selectedTime = Duration(minutes: 1).obs;
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
    isLoading.value = true;
    exams.value = await _examService.fetchExams();
    isLoading.value = false;
  }
  Future<void> fetchAllQuestions() async {
    final questions = await _questionService.fetchAllQuestions();
    allQuestions.assignAll(questions);
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

  void setQuizDuration(Duration duration) {
    selectedTime.value = duration;
  }

  Future<void> startQuiz() async {
    if (selectedSubjects.isEmpty || questionCountPerSubject.isEmpty) {
      Get.snackbar("Incomplete", "Please select subjects and question counts");
      return;
    }

    final allQuestionsForQuiz = <Question>[];
    for (var subject in selectedSubjects) {
      final filtered = allQuestions
          .where((q) => q.subjectId == subject.subjectId)
          .take(questionCountPerSubject[subject.subjectId] ?? 0)
          .toList();
      allQuestionsForQuiz.addAll(filtered);
    }

    if (allQuestionsForQuiz.isEmpty) {
      Get.snackbar("No Questions", "No questions available for selected subjects");
      return;
    }

    Get.toNamed('/quiz', arguments: {
      'questions': allQuestionsForQuiz,
      'duration': selectedTime.value,
    });
  }
}
