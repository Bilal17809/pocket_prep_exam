
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';


class SettingController extends GetxController {

  final StorageService _storageService;
  final RxString selectedExamName = "".obs;

  SettingController({required StorageService storageService})
      : _storageService = storageService;

  Future<void> loadExamName() async {
    final examName = await _storageService.loadExamName();
    if (examName != null && examName.isNotEmpty) {
      selectedExamName.value = examName[0];
    }
  }
}