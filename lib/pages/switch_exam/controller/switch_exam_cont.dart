import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/Utility/utils.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/data/models/exams_and_subject.dart';
import 'package:pocket_prep_exam/pages/dashboard/control/dashboard_controller.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/controller/edite_subject_controller.dart';
import 'package:pocket_prep_exam/pages/practice/controller/practice_controller.dart';
import 'package:pocket_prep_exam/pages/setting/control/setting_controller.dart';
import 'package:pocket_prep_exam/pages/stats/controller/stats_controller.dart';
import 'package:pocket_prep_exam/services/exam_and_subjects_services.dart';
import '../../../core/common/loading_container.dart';
import '../../study/controller/study_controller.dart';

class SwitchExamController extends GetxController {

  final ExamService _examService;
  final StorageService _storageService;

  final List<Exam> exam = <Exam>[];
   Rxn<Exam> selectExam = Rxn<Exam>();




  final RxBool isLoading = false.obs;
  final RxInt selectExamIndex = (-1).obs;
  final RxBool showButton = false.obs;
  int? savedIndex;

  SwitchExamController({
    required ExamService examService,
    required StorageService storageService,
  })  : _examService = examService,
        _storageService = storageService;

  @override
  void onInit() {
    super.onInit();
    // loadSelectedExamFromStorage();
    loadExams().then((_) {
      loadSelectExam();
    });
    // loadSelectExam();
  }
  void selectedExam(int index) {
    selectExamIndex.value = index;
    _updateButtonVisibility();
  }


  Future<void> loadSelectExam() async {
    final examId = await _storageService.getExam();
    if (examId != null && exam.isNotEmpty) {
      final foundIndex = exam.indexWhere((e) => e.examId == examId);
      if (foundIndex != -1) {
        selectExam.value = exam[foundIndex];
        selectExamIndex.value = foundIndex;
        savedIndex = foundIndex;
      }
    }
  }

  Future<void> loadExams() async {
    isLoading.value = true;
    try {
      final data = await _examService.fetchExams();
      exam.assignAll(data);
      if (savedIndex != null && savedIndex! < exam.length) {
        selectExamIndex.value = savedIndex!;
      }
      _updateButtonVisibility();
    } catch (e) {
      Utils.showError("Exam fetching Error $e","");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveSelectedExam() async {
    if (selectExamIndex.value == -1) {
      Utils.showError( "Please select an exam first!","");
      return;
    }
    final selected = exam[selectExamIndex.value];
    await _storageService.saveExamId(selected.examId);
    selectExam.value = selected;
    savedIndex = selectExamIndex.value;
    await Get.find<SettingController>().loadExamFromStorage();
    await Get.find<EditeSubjectController>().loadExamFromStorage();
    await Get.find<StudyController>().loadExamFromStorage();
    await Get.find<PracticeController>().loadExam();
    await Get.find<StatsController>().loadExam();
    _updateButtonVisibility();


  }
  void _updateButtonVisibility() {
    if (savedIndex == null) {
      showButton.value = selectExamIndex.value != -1;
    } else {
      showButton.value = (selectExamIndex.value != savedIndex);
    }
  }
}
