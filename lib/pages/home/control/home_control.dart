
import 'package:get/get.dart';

import '/data/models/exams_and_subject.dart';
import '/services/services.dart';


class ExamAndSubjectController extends GetxController {
  final ExamService _examService ;

  ExamAndSubjectController({
    required ExamService examServices})
      :_examService=examServices;

  RxList<Exam> exams = <Exam>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadExams();
  }

  void loadExams() async {
    try {
      final result = await _examService.fetchExams();
      exams.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load exams: $e');
      print("Error loading exams: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

