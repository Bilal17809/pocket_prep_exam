

import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/routes/routes_name.dart';
import 'package:pocket_prep_exam/pages/switch_exam/view/examp_switch_view.dart';

class Routes{


  static List<GetPage>  routes () => [
    GetPage(name: RoutesName.examSwitchView, page: () => ExamSwitchView()),
  ];
}