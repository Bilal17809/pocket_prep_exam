import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/core/local_storage/storage_helper.dart';
import '/core/routes/routes.dart';
import '/core/routes/routes_name.dart';
import '/pages/edite_subjects/controller/edite_subject_controller.dart';
import 'core/dependency_inject/dependency_inject.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  DependencyInject.init();
  await StorageService.init();
  Get.put<EditeSubjectController>(EditeSubjectController(questionService: Get.find(),
    storageServices: Get.find(),
      examService: Get.find(),
    ),
    permanent: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RoutesName.splash,
      getPages: Routes.routes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
