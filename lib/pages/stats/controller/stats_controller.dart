import 'package:get/get.dart';
import 'package:pocket_prep_exam/services/exam_and_subjects_services.dart';

import '../../../data/models/exams_and_subject.dart';
import '../../quiz_view_second/controller/quiz_controller.dart';

class  StatsController extends GetxController{


  var subjectResults = <int, List<QuizResult>>{}.obs;

  void saveResult(Subject subject, QuizResult result) {
    if (!subjectResults.containsKey(subject.subjectId)) {
      subjectResults[subject.subjectId] = [];
    }
    subjectResults[subject.subjectId]!.add(result);
  }

  QuizResult? latestResultForSubject(int subjectId) {
    final results = subjectResults[subjectId];
    if (results == null || results.isEmpty) return null;
    return results.last;
  }

  int quizTimesForSubject(int subjectId) {
    return subjectResults[subjectId]?.length ?? 0;
  }

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

