import 'package:get/get.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import '../../pages/login/controller/login_controller.dart';
import '../../pages/premium/controller/premium_controller.dart';
import '../../services/firebase_storage_services.dart';
import '/core/local_storage/storage_helper.dart';
import '/pages/Quiz_builder/controller/quiz_builder_controller.dart';
import '/pages/dashboard/control/dashboard_controller.dart';
import '/pages/edite_subjects/controller/edite_subject_controller.dart';
import '/pages/exam_settings/controller/exam_setting_controller.dart';
import '/pages/practice/controller/practice_controller.dart';
import '/pages/quiz_result/controller/quiz_result_controller.dart';
import '/pages/quiz_setup/controller/quiz_setup_controller.dart';
import '/pages/quiz_view_second/controller/quiz_controller.dart';
import '/pages/stats/controller/stats_controller.dart';
import '/pages/study/controller/study_controller.dart';
import '/pages/switch_exam/controller/switch_exam_cont.dart';
import '/services/services.dart';
import '/pages/questions/control/questions_controller.dart';
import '/pages/setting/control/setting_controller.dart';
import '/pages/splash/control/splash_controller.dart';

class DependencyInject{
  static void init(){

    // ads injections
    Get.lazyPut<AppOpenAdManager>(() => AppOpenAdManager(),fenix: true);
    Get.lazyPut<InterstitialAdManager>(() => InterstitialAdManager(), fenix: true);
    Get.lazyPut<NativeAdController>(() => NativeAdController(), fenix: true);
    Get.lazyPut<SplashInterstitialManager>(() => SplashInterstitialManager(), fenix: true);
    Get.lazyPut<RemoveAds>(() => RemoveAds(), fenix: true);

    // other injections
    Get.lazyPut<ExamService>(() => ExamService(), fenix: true);
    Get.lazyPut<FirebaseJsonCacheService>(() => FirebaseJsonCacheService(), fenix: true);
    Get.lazyPut<QuestionService>(() => QuestionService(),fenix: true );
    Get.lazyPut<StorageService>(() => StorageService(),fenix: true);
    Get.lazyPut<PremiumPlansController>(()=>PremiumPlansController(),fenix: true);
    Get.lazyPut<LoginController>(()=>LoginController(storageServices: Get.find()),fenix: true);
    Get.lazyPut<SwitchExamController>(() => SwitchExamController(examService: Get.find(), storageService:Get.find() ),fenix: true);
    Get.lazyPut<StatsController>(() => StatsController(questionService: Get.find(),storageServices: StorageService()),fenix: true);
    Get.lazyPut<StudyController>(() => StudyController(storageService: Get.find(),examServices: Get.find(),questionService: Get.find()),fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(storageService: Get.find()),fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(),fenix: true);
    Get.put<QuestionController>(QuestionController(q: Get.find<QuestionService>()), permanent: true,);
    Get.lazyPut<SettingController>(() => SettingController(storageService: Get.find(),examServices: Get.find()),fenix: true);
    Get.lazyPut<QuizResultController>(() =>  QuizResultController(),fenix: true);
    Get.lazyPut<ExamSettingController>(() =>  ExamSettingController(storageServices:Get.find(),examService: Get.find()),fenix: true);
    Get.lazyPut<EditeSubjectController>(() => EditeSubjectController(storageServices: Get.find(), examService: Get.find(),questionService: Get.find()),fenix: true);
    Get.lazyPut<PracticeController>(() => PracticeController(questionService: Get.find(),storageServices: Get.find()), fenix: true);
    Get.lazyPut<QuizSetupController>(() => QuizSetupController(questionService: Get.find()), fenix: true);
    Get.lazyPut<QuizController>(() =>QuizController(), fenix: true);
    Get.lazyPut<QuizBuilderController>(() => QuizBuilderController(examService: Get.find(), questionService: Get.find()), fenix: true);

  }
}