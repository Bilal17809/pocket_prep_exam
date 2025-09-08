import 'package:get/get.dart';

class  StatsController extends GetxController{

  List<Items> titleList = <Items>[
    Items(title: "Free Study  Progress. 0%"),
    Items(title: "7 Subjects Scores"),
    Items(title: "Quiz Scores"),
    Items(title: "Study Activity")
  ].obs;
}


class Items{
    final String title;
    Items({required this.title});
}