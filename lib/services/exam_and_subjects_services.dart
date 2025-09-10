import 'dart:convert';
import 'package:flutter/services.dart';
import '../core/global_keys/global_keys.dart';
import '/data/models/models.dart';

class ExamService {

  Future<List<Exam>> fetchExams() async {
    final String response = await rootBundle.loadString(examAndSubjectsJson);
    final List<dynamic> dataList = json.decode(response);

    return dataList.map((item) => Exam.fromJson(item)).toList();
  }
}
