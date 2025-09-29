import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/quiz_view_second/controller/quiz_controller.dart';

class StorageService {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const String _saveExamName = "_exam_name";
  static const String _saveSelectedExam = "_selected_exam_index";
  static const String selectedExamKey = "selected_exam_id";
  static const String _quizResultKey = "_quiz_result";

  Future<void> saveName(List<String> examName) async {
    await _preferences.setStringList(_saveExamName, examName);
  }

  Future<void> saveExamId(int examId)async{
 await  _preferences.setInt(selectedExamKey, examId);
  }
  Future<int?> getExam()async{
    return _preferences.getInt(selectedExamKey);
  }
  Future<void> clearExam()async{
    await _preferences.remove(selectedExamKey);
  }


  Future<List<String>?> loadExamName() async {
    return _preferences.getStringList(_saveExamName);
  }


  Future<void> saveSelectedExam(int index) async {
    await _preferences.setInt(_saveSelectedExam, index);
  }

  Future<int?> loadSelectedExam() async {
    return _preferences.getInt(_saveSelectedExam);
  }



  //save exam result on stats view
  Future<void> saveExamResults(int examId, Map<int, List<QuizResult>> subjectResults) async {
    final data = subjectResults.map((key, value) {
      return MapEntry(key.toString(), value.map((r) => r.toJson()).toList());
    });
    await _preferences.setString("results_$examId", jsonEncode(data));
  }

  Future<Map<int, List<QuizResult>>> loadExamResults(int examId) async {
    final data = _preferences.getString("results_$examId");
    if (data == null) return {};
    final decoded = jsonDecode(data) as Map<String, dynamic>;
    return decoded.map((key, value) {
      return MapEntry(
        int.parse(key),
        (value as List).map((item) => QuizResult.fromJson(item)).toList(),
      );
    });
  }
  Future<void> clearExamResults(int examId) async {
    await _preferences.remove("results_$examId");
  }


  //Save Quiz result
  Future<void> saveQuizResult(QuizResult result) async {
    final jsonString = jsonEncode(result.toJson());
    await _preferences.setString(_quizResultKey, jsonString);
  }

  Future<QuizResult?> loadQuizResult() async {
    final jsonString = _preferences.getString(_quizResultKey);
    if (jsonString == null) return null;
    final map = jsonDecode(jsonString);
    return QuizResult.fromJson(map);
  }

  Future<void> clearQuizResult() async {
    await _preferences.remove(_quizResultKey);
  }
}