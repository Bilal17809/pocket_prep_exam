
import 'package:get/get.dart';
import '/core/local_storage/storage_helper.dart';


class SplashController extends GetxController{

final StorageService _storageService;
RxBool isExam = false.obs;

SplashController({required StorageService storageService})
    : _storageService = storageService;

  @override
  void onInit() async{
    super.onInit();
    Future.delayed(Duration(seconds: 1),(){
           loadExams();
    });
  }

Future<void> loadExams()async{
  final examId = await _storageService.getExam();
  if(examId != null){
     isExam.value = true;
  }
}

}