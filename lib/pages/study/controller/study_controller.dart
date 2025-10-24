import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/controller/edite_subject_controller.dart';
import '../../../ad_manager/interstitial_ads.dart';
import '/core/local_storage/storage_helper.dart';
import '/data/models/exams_and_subject.dart';
import '/services/exam_and_subjects_services.dart';
import '/services/questions_services.dart';
import '/data/models/question_model.dart';

class StudyController extends GetxController {
  final ExamService _examService;
  final StorageService _storageService;
  final QuestionService _questionService;

  final RxInt selectedIndex = (-1).obs;
  final RxString selectedExamName = "".obs;
  Rxn<Exam> selectedExam = Rxn<Exam>();
  RxString questionOfDayDate = ''.obs;
  RxBool isQuestionOfDayVisible =true.obs;
  RxBool isQuestionOfDayCorrect = false.obs;
  final isSubscribed = Get.find<RemoveAds>().isSubscribedGet.value;

  RxList<CalendarDateModel> calendarDates = <CalendarDateModel>[].obs;


  StudyController({
    required StorageService storageService,
    required ExamService examServices,
    required QuestionService questionService,
  })  : _storageService = storageService,
        _examService = examServices,
        _questionService = questionService;

  @override
  void onInit() {
    super.onInit();
    Get.find<InterstitialAdManager>().checkAndDisplayAd();
    loadExamFromStorage();
    generateCalendarDates();
    checkQuestionOfDayStatus();
  }


  void selectItem(int index) => selectedIndex.value = index;


  void generateCalendarDates() {
    final today = DateTime.now();
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    calendarDates.clear();
    for (int i = 0; i < 7; i++) {
      final date = startOfWeek.add(Duration(days: i));
      calendarDates.add(CalendarDateModel(
        date: date,
        dayName: DateFormat('EEE').format(date).toUpperCase(),
        dayNumber: date.day,
        isToday: DateUtils.isSameDay(date, today),
      ));
    }
  }


  Future<void> loadExamFromStorage() async {
    try {
      final examId = await _storageService.getExam();
      final exams = await _examService.fetchExams();
      if (examId != null && exams.isNotEmpty) {
        selectedExam.value = exams.firstWhere(
              (e) => e.examId == examId,
          orElse: () => exams.first,
        );
        final examName = selectedExam.value?.examName ?? '';
        if (examName.isNotEmpty) selectedExamName.value = examName;
        await checkQuestionOfDayStatus();
      }
    } catch (e) {
      print('Error loading exam: $e');
    }
  }


  Future<void> checkQuestionOfDayStatus() async {
    final exam = selectedExam.value;
    if (exam == null) return;
    final attempted = await _storageService.isQuestionOfDayAttempted(exam.examId);
    final savedDate = await _storageService.getLastQuestionOfDayDate(exam.examId);
    final isCorrect = await _storageService.getQuestionOfDayCorrectness(exam.examId);
    if (savedDate != null) {
      questionOfDayDate.value = savedDate;
    }
    isQuestionOfDayVisible.value = !attempted;
    isQuestionOfDayCorrect.value = isCorrect ?? false;
  }

  Future<void> markQuestionOfDayAttempted() async {
    final exam = selectedExam.value;
    if (exam == null) return;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await _storageService.saveQuestionOfDayAttempt(exam.examId);
    isQuestionOfDayVisible.value = false;
    questionOfDayDate.value = today;
  }

  Future<void> updateQuestionOfDayProgress(bool isCorrect) async {
    final exam = selectedExam.value;
    if (exam == null) return;
    await _storageService.saveQuestionOfDayCorrectness(exam.examId, isCorrect);
    await _storageService.saveQuestionOfDayAttempt(exam.examId);
    isQuestionOfDayVisible.value = false;
    isQuestionOfDayCorrect.value = isCorrect;
    questionOfDayDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (isCorrect) {
      print("✅ Question of the Day completed successfully!");
    } else {
      print("❌ Wrong answer, progress saved.");
    }
  }

  Future<Question?> getQuestionOfTheDay() async {
    final exam = selectedExam.value;
    if (exam == null) return null;
    final subjects = exam.subjects;
    if (subjects.isEmpty) return null;
    final daysSinceEpoch = DateTime.now().difference(DateTime(2020, 1, 1)).inDays;
    final subjectIndex = daysSinceEpoch % subjects.length;
    final selectedSubject = subjects[subjectIndex];
    final allQuestions = await _questionService.fetchAllQuestions();
    final candidate = allQuestions.where((q) => q.subjectId == selectedSubject.subjectId).toList();
    if (candidate.isEmpty) return null;
    final rnd = Random();
    final chosen = candidate[rnd.nextInt(candidate.length)];
    print("QOTD -> Exam: ${exam.examName}, Subject: ${selectedSubject.subjectName}, QuestionId: ${chosen.questionId}");
    return chosen;
  }

  Future<void> clearQuestionOfDayAttempt() async {
    final exam = selectedExam.value;
    if (exam == null) return;
    await _storageService.clearQuestionOfDayAttempt(exam.examId);
    isQuestionOfDayVisible.value = true;
    isQuestionOfDayCorrect.value = false;
    questionOfDayDate.value = '';
    print("Question of the Day cleared for Exam ID: ${exam.examId}");
  }


  List<QuizModeModel> buildQuizModeList() {
    final modes = <QuizModeModel>[];
    if (isQuestionOfDayVisible.value) {
      final today = DateTime.now();
      final formatted = DateFormat('d-MMM').format(today);
      modes.add(QuizModeModel(
        "images/cards.png",
        formatted,
        "Question of the Day",
        null,
      ));
    }
    else {
      final formatted = questionOfDayDate.value.isNotEmpty ? DateFormat('d-MMM').format(DateTime.parse(questionOfDayDate.value))
          : "";
      modes.add(QuizModeModel(
        "images/greycard.png",
        formatted,
        "Hidden until tomorrow",
        null,
      ));
    }
    modes.addAll([
      QuizModeModel("images/quiz icon.png", "", "Quick ${isSubscribed ? Get.find<EditeSubjectController>().questionPool.length:"10"} Quiz", null),
      QuizModeModel("images/stopwatch.png", "", "Timed Quiz", null),
      QuizModeModel("images/set-up.png", "", "Quiz Builder", null),
    ]);
    return modes;
  }

}

class CalendarDateModel {
  final DateTime date;
  final String dayName;
  final int dayNumber;
  final bool isToday;
  CalendarDateModel({
    required this.date,
    required this.dayName,
    required this.dayNumber,
    this.isToday = false,
  });
}

class QuizModeModel {
  final String? icon;
  final String? title;
  final String? date;
  final VoidCallback? onTap;
  QuizModeModel(this.icon, this.date, this.title, this.onTap);
}
