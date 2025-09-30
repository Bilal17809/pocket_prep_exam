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
  static const String _selectedSubjectsKey = "_selected_subjects";

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
  Future<void> saveQuizResult(int examId, QuizResult result) async {
    final jsonString = jsonEncode(result.toJson());
    await _preferences.setString("quiz_result_$examId", jsonString);
  }

  Future<QuizResult?> loadQuizResult(int examId) async {
    final jsonString = _preferences.getString("quiz_result_$examId");
    if (jsonString == null) return null;
    return QuizResult.fromJson(jsonDecode(jsonString));
  }

  Future<void> clearQuizResult() async {
    await _preferences.remove(_quizResultKey);
  }


 // save subjects
  Future<void> saveSelectedSubjects(int examId, List<int> subjectIds) async {
    await _preferences.setStringList(
      "${_selectedSubjectsKey}_$examId",
      subjectIds.map((id) => id.toString()).toList(),
    );
  }

  // Load saved subjects for a specific exam
  Future<List<int>> loadSelectedSubjects(int examId) async {
    final list = _preferences.getStringList("${_selectedSubjectsKey}_$examId");
    return list?.map((e) => int.tryParse(e) ?? 0).where((id) => id != 0).toList() ?? [];
  }

  Future<void> clearSelectedSubjects(int examId) async {
    await _preferences.remove("${_selectedSubjectsKey}_$examId");
  }
}