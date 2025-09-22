
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/pages/switch_exam/controller/switch_exam_cont.dart';



class SplashController extends GetxController{

final StorageService _storageService;

RxBool isExam = false.obs;

SplashController({required StorageService storageService}) : _storageService = storageService;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3),(){
     loadExams();
    });
  }

Future<void> loadExams()async{
  final exam = await _storageService.getExam();
  if(exam != null){
     isExam.value = true;
  }
}

}