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
      await Future.delayed(Duration(seconds: 2));
      if(controller.isExam.value == true){
        Get.offNamed(RoutesName.dashBoard);
      }else{
        Get.offNamed(RoutesName.login);
      }
    });
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("images/spla.png",fit: BoxFit.cover,),
          )
        ],
      )
   
    );
  }
}
