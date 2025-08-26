import 'dart:convert';
import 'package:flutter/services.dart';
import '/data/models/models.dart';

class QuestionService {
  Future<List<Question>> fetchQuestionsBySubject(int subjectId) async {
    final String response = await rootBundle.loadString('assets/exam_ems_questions.json');
    final List<dynamic> data = json.decode(response);
    final List<Question> allQuestions = data.map((q) => Question.fromJson(q)).toList();

    // Filter by subject ID
    return allQuestions.where((q) => q.subjectId == subjectId).toList();
  }
}
