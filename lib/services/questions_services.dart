// import 'dart:convert';
// import 'package:flutter/services.dart';
// import '../core/global_keys/global_keys.dart';
// import '/data/models/models.dart';
//
// class QuestionService {
//   Future<List<Question>> fetchAllQuestions() async {
//     final String response = await rootBundle.loadString(subjectQuestionsJson);
//     final List<dynamic> data = json.decode(response);
//     return data.map((q) => Question.fromJson(q)).toList();
//   }
// }

import '/data/models/models.dart';
import '../core/global_keys/global_keys.dart';
import 'firebase_storage_services.dart';

class QuestionService {
  final _cacheService = FirebaseJsonCacheService();

  Future<List<Question>> fetchAllQuestions() async {
    const remoteFileName = "exam_ems_questions.json";
    final dataList = await _cacheService.loadJsonList(remoteFileName);
    return dataList.map((q) => Question.fromJson(q)).toList();
  }
}

