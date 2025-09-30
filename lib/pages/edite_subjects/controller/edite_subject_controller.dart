import 'package:get/get.dart';
import 'package:pocket_prep_exam/services/questions_services.dart';
import '/core/local_storage/storage_helper.dart';
import '/data/models/exams_and_subject.dart';
import '/data/models/question_model.dart';
import '/services/exam_and_subjects_services.dart';

class EditeSubjectController extends GetxController {

  final ExamService _examService;
  final StorageService _storageService;
  final QuestionService _service;

  Rxn<Exam> selectedExam = Rxn<Exam>();
  RxList<Question> examQuestions = <Question>[].obs;
  RxList<int> selectedSubjectIds = <int>[].obs;
  RxList<Question> questionPool = <Question>[].obs;
  static const int maxAllSubjectsPool = 30;
   int maxQuizSize = 10;

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

  List<Question> startQuiz() {
    final pool = [...questionPool];
    pool.shuffle();
    return pool.take(maxQuizSize).toList();
  }

  bool _isAllSubjectsSelected() {
    if (examQuestions.isEmpty) return false;
    final totalSubjects = examQuestions.map((q) => q.subjectId).toSet().length;
    return selectedSubjectIds.length == totalSubjects;
  }

  String getSubjectNameById(int subjectId) {
    final exam = selectedExam.value;
    if (exam == null) return "Unknown";
    final subject = exam.subjects.firstWhereOrNull((s) => s.subjectId == subjectId);
    return subject?.subjectName ?? "Unknown";
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
