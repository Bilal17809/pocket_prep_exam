import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/dashboard/control/dashboard_controller.dart';
import '../../pages/questions/control/questions_controller.dart';
import '../../pages/setting/control/setting_controller.dart';
import '../../pages/splash/control/splash_controller.dart';
import '/pages/home/control/home_control.dart';

class DependencyInject{
  static void init(){
    Get.lazyPut<SplashController>(() => SplashController(),fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(),fenix: true);
    Get.lazyPut<ExamAndSubjectController>(() => ExamAndSubjectController(),fenix: true);
    Get.lazyPut<QuestionController>(() => QuestionController(),fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(),fenix: true);
  }
}