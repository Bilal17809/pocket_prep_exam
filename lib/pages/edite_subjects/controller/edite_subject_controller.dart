import 'dart:ui';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import 'package:pocket_prep_exam/core/common/exite_dialog.dart';
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
  static const int freePlanLimit = 30;
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

  void toggleSubject(int subjectId, {required VoidCallback onUpgrade}) {
    final exam = selectedExam.value;
    if (exam == null) return;

    final subject = exam.subjects.firstWhereOrNull((s) => s.subjectId == subjectId);
    final isSubscribed = Get.find<RemoveAds>().isSubscribedGet.value;

    if (subject == null) return;
    if (!isSubscribed) {
      int totalQuestions = 0;
      for (var id in selectedSubjectIds) {
        final subjectQs = examQuestions.where((q) => q.subjectId == id).toList();
        totalQuestions += subjectQs.length > 5 ? 5 : subjectQs.length;
      }
      if (!selectedSubjectIds.contains(subjectId) && totalQuestions >= freePlanLimit) {
        showDialog(onUpgrade: onUpgrade);
        return;
      }
    }
    if (selectedSubjectIds.contains(subjectId)) {
      selectedSubjectIds.remove(subjectId);
    } else {
      selectedSubjectIds.add(subjectId);
    }
    if (isSubscribed) {
      _buildPool();
    } else {
      _buildPoolForFreeUser();
    }
    _checkSelectionChanged();
  }



  // void toggleSubject(int subjectId) {
  //   final exam = selectedExam.value;
  //   if (exam == null) {
  //     return;
  //   }
  //   final subject = exam.subjects.firstWhereOrNull((s) => s.subjectId == subjectId);
  //   if (subject == null) {
  //     return;
  //   }
  //   if (selectedSubjectIds.contains(subjectId)) {
  //     selectedSubjectIds.remove(subjectId);
  //   } else {
  //     selectedSubjectIds.add(subjectId);
  //   }
  //   if(Get.find<RemoveAds>().isSubscribedGet.value){
  //     _buildPool();
  //   }else{
  //     _buildPoolForFreeUser();
  //   }
  //   _checkSelectionChanged();
  // }


  void toggleAllSubjects({required VoidCallback onUpgrade}) {
    final exam = selectedExam.value;
    if (exam == null) return;

    final allIds = exam.subjects.map((s) => s.subjectId).toList();
    final isSubscribed = Get.find<RemoveAds>().isSubscribedGet.value;

    if (selectedSubjectIds.length == allIds.length) {
      selectedSubjectIds.clear();
    } else {
      if (!isSubscribed) {
        int totalQuestions = 0;
        for (var id in allIds) {
          final subjectQs = examQuestions.where((q) => q.subjectId == id).toList();
          totalQuestions += subjectQs.length > 5 ? 5 : subjectQs.length;
        }
        if (totalQuestions > freePlanLimit) {
        showDialog(onUpgrade: onUpgrade);
          return;
        }
      }
      selectedSubjectIds.assignAll(allIds);
    }
    if (isSubscribed) {
      _buildPool();
    } else {
      _buildPoolForFreeUser();
    }
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
        print("Your BuildPool length is ${questionPool.length}");
      }
    }
  }

  void _buildPoolForFreeUser() {
    questionPool.clear();
    if (selectedSubjectIds.isEmpty) return;
    int totalCount = 0;
    for (var id in selectedSubjectIds) {
      final subjectQs = examQuestions.where((q) => q.subjectId == id).toList();
      final countToAdd = subjectQs.length > 5 ? 5 : subjectQs.length;
      questionPool.addAll(subjectQs.take(countToAdd));
      totalCount += countToAdd;
      print("Your buildPoolForFreeUser length is ${questionPool.length}");
    }
    questionPool.shuffle();
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
    return pool.take(Get.find<RemoveAds>().isSubscribedGet.value ? 50 : 20).toList();
  }

  List<Question> startQuiz() {
    final pool = [...questionPool];
    pool.shuffle();
    return pool;
  }

  List<Question> startQuizForFreeUser() {
    final pool = [...questionPool];
    pool.shuffle();
    print("Your pool is start Quiz pool is:  ${pool.length}");
    return pool.take(maxQuizSize).toList();
  }

  Future<void> showDialog({required VoidCallback onUpgrade}) async {
    CustomDialogForExitAndWarning.show(
      title: "Limit Reached ⚠️",
      message:
      "You can only use up to 30 questions on the free plan. Upgrade to Premium to unlock unlimited access!",
      isWarning: false,
      positiveButtonText: "Upgrade Now",
      negativeButtonText: "Cancel",
      onPositiveTap: onUpgrade,
    );
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
