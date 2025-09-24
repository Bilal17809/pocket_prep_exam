
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/services/exam_and_subjects_services.dart';




class SplashController extends GetxController{

final StorageService _storageService;

RxBool isExam = false.obs;

SplashController({required StorageService storageService}) : _storageService = storageService;

  @override
  void onInit() async{
    super.onInit();
  final exam = await  _storageService.loadSelectedExam();
    print("your exam name is $exam");
    Future.delayed(Duration(seconds: 3),(){
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