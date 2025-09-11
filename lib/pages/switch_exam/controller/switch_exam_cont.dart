import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/Utility/utils.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/data/models/exams_and_subject.dart';
import 'package:pocket_prep_exam/services/exam_and_subjects_services.dart';
import '../../study/controller/study_controller.dart';

class SwitchExamController extends GetxController {
  final ExamService _examService;
  final StorageService _storageService;

  final List<Exam> exam = <Exam>[];
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
    loadSelectedExamFromStorage();
    loadExams();
  }
  void selectedExam(int index) {
    selectExamIndex.value = index;
    _updateButtonVisibility();
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
      Utils().snackBarMessage("Error", "Exam fetching Error $e", isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadSelectedExamFromStorage() async {
    savedIndex = await _storageService.loadSelectedExam();
    _updateButtonVisibility();
  }

  Future<void> saveSelectedExamAndName() async {
    if (selectExamIndex.value == -1) {
      Utils().snackBarMessage("Error", "Please select an exam first!", isSuccess: false);return;}
    final selected = exam[selectExamIndex.value];
    await _storageService.saveSelectedExam(selectExamIndex.value);
    await _storageService.saveName([selected.examName]);
    Get.find<StudyController>().loadExamName();
    savedIndex = selectExamIndex.value;
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
