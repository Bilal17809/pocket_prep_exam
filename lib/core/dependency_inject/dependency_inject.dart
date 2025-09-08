import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/dashboard/control/dashboard_controller.dart';
import 'package:pocket_prep_exam/pages/stats/controller/stats_controller.dart';
import 'package:pocket_prep_exam/pages/study/controller/study_controller.dart';
import '/pages/questions/control/questions_controller.dart';
import '/pages/setting/control/setting_controller.dart';
import '/pages/splash/control/splash_controller.dart';
import '/services/exam_and_subjects_services.dart';
import '/pages/home/control/home_control.dart';

class DependencyInject{
  static void init(){

    // initialize this first
    Get.lazyPut<ExamService>(() => ExamService(), fenix: true);
    Get.lazyPut<StatsController>(() => StatsController(),fenix: true);
    Get.lazyPut<StudyController>(() => StudyController(),fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(),fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(),fenix: true);
    Get.lazyPut<ExamAndSubjectController>(() => ExamAndSubjectController(examServices:ExamService()),fenix: true);
    Get.lazyPut<QuestionController>(() => QuestionController(),fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(),fenix: true);
  }
}