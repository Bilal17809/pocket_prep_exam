import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/local_storage/storage_helper.dart';
import '/pages/splash/view/splash_view.dart';
import 'core/dependency_inject/dependency_inject.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  DependencyInject.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home:SplashView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
