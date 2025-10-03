
import 'dart:ui';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import '/data/models/exams_and_subject.dart';
import '/services/exam_and_subjects_services.dart';

class StudyController extends GetxController{

  final ExamService _examService;

  final StorageService _storageService;

  final RxInt selectedIndex = (-1).obs;
  final RxString selectedExamName = "".obs;
  Rxn<Exam> selectedExam = Rxn<Exam>();

  StudyController({required StorageService storageService,required ExamService examServices})
: _storageService = storageService, _examService = examServices;

  @override
  void onInit() {
    super.onInit();
    // Get.find<EditeSubjectController>();
    loadExamFromStorage();
  }

  void selectItem(int index){
    selectedIndex.value = index;
  }

  Future<void> loadExamFromStorage() async {
    final examId = await _storageService.getExam();
    final exams = await _examService.fetchExams();
    if (examId != null) {
      selectedExam.value = exams.firstWhere((e) => e.examId == examId);
      final examName = selectedExam.value!.examName;
    if(examName.isNotEmpty){
     selectedExamName.value = examName;
    }
    }}

  RxList<CalenderModel> calenderList =  <CalenderModel>[
    CalenderModel(25, "Mon"),
    CalenderModel(26, "Tue"),
    CalenderModel(27, "Wed"),
    CalenderModel(28, "Thur"),
    CalenderModel(29, "Fri")
  ].obs;

  RxList<QuizModeModel> quizModeDataList =  <QuizModeModel>[
    QuizModeModel("images/cards.png", "", "Question of the Day",(){}),
    QuizModeModel("images/quiz icon.png", "", "Quick 10 Quiz",(){}),
    QuizModeModel("images/stopwatch.png", "", "Timed Quiz",(){}),
    QuizModeModel("images/set-up.png", "", "Quiz Builder",(){}),
  ].obs;
}


class CalenderModel{
  final int? date;
  final String? day;
  CalenderModel(this.date,this.day);
}

class QuizModeModel{
  final String? icon;
  final String? title;
  final String? date;
  final VoidCallback? onTap;
  QuizModeModel(this.icon,this.date,this.title,this.onTap);
}

Rxn<Exam> selectedExam = Rxn<Exam>();


