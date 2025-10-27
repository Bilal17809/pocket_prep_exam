// import 'dart:convert';
// import 'package:flutter/services.dart';
// import '../core/global_keys/global_keys.dart';
// import '/data/models/models.dart';
//
// class ExamService {
//
//   Future<List<Exam>> fetchExams() async {
//     final String response = await rootBundle.loadString(examAndSubjectsJson);
//     final List<dynamic> dataList = json.decode(response);
//
//     return dataList.map((item) => Exam.fromJson(item)).toList();
//   }
// }


import '/data/models/models.dart';
import 'firebase_storage_services.dart';

class ExamService {
  final _cacheService = FirebaseJsonCacheService();

  Future<List<Exam>> fetchExams() async {
    const remoteFileName = "ems_exam_subjects.json"; // Your Firebase file name
    final dataList = await _cacheService.loadJsonList(remoteFileName);

    return dataList.map((item) => Exam.fromJson(item)).toList();
  }
}
