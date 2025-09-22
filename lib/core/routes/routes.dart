

import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/routes/routes_name.dart';
import 'package:pocket_prep_exam/pages/dashboard/view/dashboard_view.dart';
import 'package:pocket_prep_exam/pages/splash/view/splash_view.dart';
import 'package:pocket_prep_exam/pages/switch_exam/view/examp_switch_view.dart';

class Routes{


  static List<GetPage>  routes () => [
    GetPage(name: RoutesName.examSwitchView, page: () => ExamSwitchView()),
    GetPage(name: RoutesName.dashBoard, page: () => DashboardView()),
    GetPage(name: RoutesName.splash, page: () => SplashView()),
  ];
}