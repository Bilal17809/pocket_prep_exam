import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/pages/dashboard/control/dashboard_controller.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/controller/edite_subject_controller.dart';
import 'package:pocket_prep_exam/pages/exam_settings/controller/exam_setting_controller.dart';
import 'package:pocket_prep_exam/pages/quiz_result/controller/quiz_result_controller.dart';
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
    Get.lazyPut<SwitchExamController>(() => SwitchExamController(examService: ExamService(),
        storageService: StorageService()),fenix: true);
    Get.lazyPut<StatsController>(() => StatsController(),fenix: true);
    Get.lazyPut<StudyController>(() => StudyController(storageService: StorageService(),examServices: ExamService()),fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(storageService: StorageService()),fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(),fenix: true);
    Get.lazyPut<ExamAndSubjectController>(() => ExamAndSubjectController(examServices:ExamService()),fenix: true);
    Get.lazyPut<QuestionController>(() => QuestionController(q: QuestionService()),fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(storageService: StorageService(),examServices: ExamService()),fenix: true);
    Get.lazyPut<QuizResultController>(() =>  QuizResultController(),fenix: true);
    Get.lazyPut<ExamSettingController>(() =>  ExamSettingController(storageServices: StorageService(),examService: ExamService()),fenix: true);
    Get.lazyPut<EditeSubjectController>(() => EditeSubjectController(storageServices: StorageService(), examService: ExamService(),questionService: QuestionService()),fenix: true);
  }
}