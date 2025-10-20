import 'package:get/get.dart';
import '/core/Utility/utils.dart';
import '/services/questions_services.dart';
import '/core/local_storage/storage_helper.dart';
import '/data/models/exams_and_subject.dart';
import '/data/models/question_model.dart';
import '/services/exam_and_subjects_services.dart';

class EditeSubjectController extends GetxController {

  final ExamService _examService;
  final StorageService _storageService;
  final QuestionService _service;
  RxBool hasSelectionChanged = false.obs;

  Rxn<Exam> selectedExam = Rxn<Exam>();
  RxList<Question> examQuestions = <Question>[].obs;
  RxList<int> selectedSubjectIds = <int>[].obs;
  RxList<Question> questionPool = <Question>[].obs;
  RxList<Exam> allExams = <Exam>[].obs;
  static const int maxAllSubjectsPool = 30;
   int maxQuizSize = 10;
  int maxQuizSizeForTime  = 20;

  EditeSubjectController({
    required QuestionService questionService,
    required StorageService storageServices,
    required ExamService examService,
  })  : _storageService = storageServices,
  _service = questionService,
        _examService = examService;


  @override
  void onInit() {
    super.onInit();
    loadExamFromStorage();
    startQuizForTime();
    startQuiz();
    _loadAllExams();
  }

  Future<void> loadExamFromStorage() async {
    final examId = await _storageService.getExam();
    if (examId != null) {
      final exams = await _examService.fetchExams();
      final newExam = exams.firstWhere((e) => e.examId == examId);
      selectedExam.value = null;
      selectedSubjectIds.clear();
      questionPool.clear();
      examQuestions.clear();
      selectedExam.value = newExam;
      examQuestions.value = await _service.fetchAllQuestions();
      final savedSubjects = await _storageService.loadSelectedSubjects(newExam.examId);
      if (savedSubjects.isNotEmpty) {
        selectedSubjectIds.assignAll(savedSubjects);
      } else if (newExam.subjects.isNotEmpty) {
        selectedSubjectIds.add(newExam.subjects.first.subjectId);
      }
      _buildPool();
    }
  }


  void toggleSubject(int subjectId) {
    final exam = selectedExam.value;
    if (exam == null) {
      return;
    }
    final subject = exam.subjects.firstWhereOrNull((s) => s.subjectId == subjectId);
    if (subject == null) {
      return;
    }
    if (selectedSubjectIds.contains(subjectId)) {
      selectedSubjectIds.remove(subjectId);
    } else {
      selectedSubjectIds.add(subjectId);
    }
    _buildPool();
    _checkSelectionChanged();
  }


  void toggleAllSubjects() {
    final exam = selectedExam.value;
    if (exam == null) {
      return;
    }
    final allIds = exam.subjects.map((s) => s.subjectId).toList();
    if (selectedSubjectIds.length == allIds.length) {
      selectedSubjectIds.clear();
    } else {
      selectedSubjectIds.assignAll(allIds);
    }
    _buildPool();
    _checkSelectionChanged();
  }

  Future<void> saveSelectedSubjectsForExam() async {
    final exam = selectedExam.value;
    if (exam == null) return;
    await _storageService.saveSelectedSubjects(exam.examId, selectedSubjectIds.toList());
  }

  void _buildPool() {
    questionPool.clear();
    if (selectedSubjectIds.isEmpty) return;
    if (_isAllSubjectsSelected()) {
      final all = [...examQuestions];
      all.shuffle();
      questionPool.addAll(all.take(maxAllSubjectsPool));
    } else {
      for (var id in selectedSubjectIds) {
        final subjectQs = examQuestions.where((q) => q.subjectId == id).toList();
        subjectQs.shuffle();
        questionPool.addAll(subjectQs.take(5).toList());
      }
    }
  }

  void _checkSelectionChanged() async {
    final exam = selectedExam.value;
    if (exam == null) return;
    if (selectedSubjectIds.isEmpty) {
      hasSelectionChanged.value = false;
      return;
    }
    final saved = await _storageService.loadSelectedSubjects(exam.examId);
    final current = selectedSubjectIds.toList();
    hasSelectionChanged.value = !(saved.length == current.length &&
        saved.every((id) => current.contains(id)));
  }

  Future<List<Question>> startQuizForTime()async {
    final pool = [...questionPool];
    pool.shuffle();
    // print("Your pool QuizForTime is ${pool.length}");
    return pool.take(maxQuizSizeForTime).toList();
  }

  List<Question> startQuiz() {
    final pool = [...questionPool];
    pool.shuffle();
    // print("Your pool is start Quiz pool is:  ${pool.length}");
    return pool;
  }

  bool _isAllSubjectsSelected() {
    if (examQuestions.isEmpty) return false;
    final totalSubjects = examQuestions.map((q) => q.subjectId).toSet().length;
    return selectedSubjectIds.length == totalSubjects;
  }


  Future<void> _loadAllExams() async {
    try {
      allExams.value = await _examService.fetchExams();
    } catch (e) {
      Utils.showError("$e: ", "Error");
    }
  }
  String getSubjectNameById(int subjectId) {
    for (final exam in allExams) {
      final subject = exam.subjects.firstWhereOrNull((s) => s.subjectId == subjectId);
      if (subject != null) {
        return subject.subjectName;
      }
    }
    return "Unknown";
  }

  @override
  void onClose() {
    selectedExam.close();
    examQuestions.close();
    selectedSubjectIds.close();
    questionPool.close();
    super.onClose();
  }
}
