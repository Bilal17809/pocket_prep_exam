import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const String _saveExamName = "_exam_name";
  static const String _saveSelectedExam = "_selected_exam_index";

  Future<void> saveName(List<String> examName) async {
    await _preferences.setStringList(_saveExamName, examName);
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
}