
import '/data/models/models.dart';
import 'firebase_storage_services.dart';

class ExamService {
  final _cacheService = FirebaseJsonCacheService();

  Future<List<Exam>> fetchExams() async {
    const remoteFileName = "ems_exam_subjects.json";
    final dataList = await _cacheService.loadJsonList(remoteFileName);
    return dataList.map((item) => Exam.fromJson(item)).toList();
  }
}
