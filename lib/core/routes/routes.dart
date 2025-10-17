

import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/routes/routes_name.dart';
import 'package:pocket_prep_exam/pages/dashboard/view/dashboard_view.dart';
import 'package:pocket_prep_exam/pages/exam_settings/view/exam_setting_view.dart';
import 'package:pocket_prep_exam/pages/login/view/login_view.dart';
import 'package:pocket_prep_exam/pages/practice/view/practice_view.dart';
import 'package:pocket_prep_exam/pages/premium/view/premium_screen.dart';
import 'package:pocket_prep_exam/pages/quiz_setup/view/quiz_setup_view.dart';
import 'package:pocket_prep_exam/pages/quiz_view_second/view/quiz_view.dart';
import 'package:pocket_prep_exam/pages/splash/view/splash_view.dart';
import 'package:pocket_prep_exam/pages/switch_exam/view/examp_switch_view.dart';

class Routes{


  static List<GetPage>  routes () => [
    GetPage(name: RoutesName.examSwitchView, page: () => ExamSwitchView()),
    GetPage(name: RoutesName.dashBoard, page: () => DashboardView()),
    GetPage(name: RoutesName.splash, page: () => SplashView()),
    GetPage(name: RoutesName.practice, page:() =>  PracticeView()),
    GetPage(name: RoutesName.quizSetup, page:() =>  QuizSetupView()),
    GetPage(name: RoutesName.secondQuizView, page:() =>  SecondQuizView()),
    GetPage(name: RoutesName.examSetting, page:() =>  ExamSettingView()),
    GetPage(name: RoutesName.premium, page:() =>  PremiumScreen()),
    GetPage(name: RoutesName.login, page:() =>  LoginView())
  ];
}