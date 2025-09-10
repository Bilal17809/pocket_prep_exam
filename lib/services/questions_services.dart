import 'dart:convert';
import 'package:flutter/services.dart';
import '../core/global_keys/global_keys.dart';
import '/data/models/models.dart';

class QuestionService {

  Future<List<Question>> fetchQuestionsBySubject(int subjectId) async {
    final String response = await rootBundle.loadString(subjectQuestionsJson);
    final List<dynamic> data = json.decode(response);
    final List<Question> allQuestions = data.map((q) => Question.fromJson(q)).toList();

    return allQuestions.where((q) => q.subjectId == subjectId).toList();
  }


}
