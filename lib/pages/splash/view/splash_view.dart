import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/routes/routes_name.dart';
import '../control/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();
    Future.microtask(()async{
      await Future.delayed(Duration(seconds: 3));
      if(controller.isExam.value == true){
        Get.offNamed(RoutesName.dashBoard);
      }else{
        Get.offNamed(RoutesName.examSwitchView);
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 20),
            Text(
              "Welcome to My App",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
