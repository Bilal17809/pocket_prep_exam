import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import 'package:pocket_prep_exam/core/routes/routes.dart';
import 'package:pocket_prep_exam/core/routes/routes_name.dart';
import 'package:pocket_prep_exam/pages/edite_subjects/controller/edite_subject_controller.dart';
import 'package:pocket_prep_exam/pages/questions/control/questions_controller.dart';
import 'package:pocket_prep_exam/services/questions_services.dart';
import '/pages/splash/view/splash_view.dart';
import 'core/dependency_inject/dependency_inject.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInject.init();
  await StorageService.init();
  Get.put<EditeSubjectController>(
    EditeSubjectController(
      questionService: Get.find(),
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
