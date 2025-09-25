import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/pages/dashboard/control/dashboard_controller.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/controller/edite_subject_controller.dart';
import 'package:pocket_prep_exam/pages/exam_settings/controller/exam_setting_controller.dart';
import 'package:pocket_prep_exam/pages/practice/controller/practice_controller.dart';
import 'package:pocket_prep_exam/pages/quiz_result/controller/quiz_result_controller.dart';
import 'package:pocket_prep_exam/pages/quiz_setup/controller/quiz_setup_controller.dart';
import 'package:pocket_prep_exam/pages/quiz_view_second/controller/quiz_controller.dart';
import 'package:pocket_prep_exam/pages/stats/controller/stats_controller.dart';
import 'package:pocket_prep_exam/pages/study/controller/study_controller.dart';
import 'package:pocket_prep_exam/pages/switch_exam/controller/switch_exam_cont.dart';
import 'package:pocket_prep_exam/services/services.dart';
import '/pages/questions/control/questions_controller.dart';
import '/pages/setting/control/setting_controller.dart';
import '/pages/splash/control/splash_controller.dart';
import '/services/exam_and_subjects_services.dart';
import '/pages/home/control/home_control.dart';

class DependencyInject{
  static void init(){
    Get.lazyPut<ExamService>(() => ExamService(), fenix: true);
    Get.lazyPut<QuestionService>(() => QuestionService(),fenix: true );
    Get.lazyPut<StorageService>(() => StorageService(),fenix: true);

    Get.lazyPut<SwitchExamController>(() => SwitchExamController(examService: Get.find(), storageService:Get.find() ),fenix: true);
    Get.lazyPut<StatsController>(() => StatsController(),fenix: true);
    Get.lazyPut<StudyController>(() => StudyController(storageService: Get.find(),examServices: Get.find()),fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(storageService: Get.find()),fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(),fenix: true);
    Get.lazyPut<ExamAndSubjectController>(() => ExamAndSubjectController(examServices:Get.find()),fenix: true);
    Get.lazyPut<QuestionController>(() => QuestionController(q: Get.find()),fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(storageService: Get.find(),examServices: Get.find()),fenix: true);
    Get.lazyPut<QuizResultController>(() =>  QuizResultController(),fenix: true);
    Get.lazyPut<ExamSettingController>(() =>  ExamSettingController(storageServices:Get.find(),examService: Get.find()),fenix: true);
    Get.lazyPut<EditeSubjectController>(() => EditeSubjectController(storageServices: Get.find(), examService: Get.find(),questionService: Get.find()),fenix: true);
    Get.lazyPut<PracticeController>(() => PracticeController(questionService: Get.find()), fenix: true);
    Get.lazyPut<QuizSetupController>(() => QuizSetupController(questionService: Get.find()), fenix: true);
    Get.lazyPut<QuizController>(() =>QuizController(), fenix: true);
  }
}