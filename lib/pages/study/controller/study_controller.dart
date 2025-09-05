

import 'package:get/get.dart';

class StudyController extends GetxController{

  final RxInt selectedIndex = (-1).obs;

  void selectItem(int index){
    selectedIndex.value = index;
  }

  RxList<CalenderModel> calenderList =  <CalenderModel>[
    CalenderModel(25, "Mon"),
    CalenderModel(26, "Tue"),
    CalenderModel(27, "Wed"),
    CalenderModel(28, "Thur"),
    CalenderModel(29, "Fri")
  ].obs;

  RxList<QuizModeModel> quizModeDataList =  <QuizModeModel>[
    QuizModeModel("images/who.png", "Aug 26", "Question of the Day"),
    QuizModeModel("images/brain.png", "", "Quick 10 Quiz"),
    QuizModeModel("images/track-of-time.png", "", "Timed Quiz"),
    QuizModeModel("images/start.png", "", "Level Up"),
  ].obs;
}


class CalenderModel{
  final int? date;
  final String? day;
  CalenderModel(this.date,this.day);
}

class QuizModeModel{
  final String? icon;
  final String? title;
  final String? date;
  QuizModeModel(this.icon,this.date,this.title);
}