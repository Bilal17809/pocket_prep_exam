import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/pages/study/controller/study_controller.dart';


class HomeBanner extends StatelessWidget {
  // final StudyControlleroller controller;
  final double height;

  const HomeBanner({
    super.key,
    required this.height,
    // required this.controller
  });

  @override
  Widget build(BuildContext context) {
    final studyController= Get.find<StudyController>();
    return Obx((){
      return Column(
        children: [
          Container(
            height: height * 0.30,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("images/_3x/girl.png"),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 40),
                      Text(
                        studyController.selectedExamName.value,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          height: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    // Text(
                    //   "MORNING",
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 32,
                    //     height: 1.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    Text(
                      "It,s an excellent day to study.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
                // Image.asset(
                //   "images/girl.png",
                //   height: height * 0.18,
                //   fit: BoxFit.contain,
                // ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
