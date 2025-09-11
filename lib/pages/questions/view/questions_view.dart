// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '/data/models/exams_and_subject.dart';
// import '../control/questions_controller.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/data/models/exams_and_subject.dart';
import 'package:pocket_prep_exam/pages/questions/widgets/page_indicator.dart';
import 'package:pocket_prep_exam/pages/questions/widgets/quize_card.dart';

import '../control/questions_controller.dart';


class QuizzesView extends StatelessWidget {
  final Subject subject;
 const  QuizzesView({super.key,required this.subject});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionController());
    controller.loadQuestions(subject.subjectId);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF1E90FF),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            PageIndicator(),
            SizedBox(height: 16),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return
                Expanded(
                  child: PageView.builder(
                    controller: PageController(),
                    itemCount: controller.questions.length,
                    itemBuilder: (context, index) {
                      return QuizCard(
                        question: controller.questions[index],
                        index: index,
                      );
                    },
                  ),
                );
            }),
            // QuizCard(),
            // Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ForAndBackButton(icons: Icons.arrow_back_ios,),
                  _ForAndBackButton(icons: Icons.outlined_flag_rounded,),
                  _ForAndBackButton(icons:  Icons.arrow_forward_ios)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ForAndBackButton extends StatelessWidget {
  final IconData? icons;
  final VoidCallback? onTp;
  const _ForAndBackButton({super.key,this.icons,this.onTp});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36,vertical: 10),
      child: GestureDetector(
        onTap: onTp,
          child: Icon(icons,size: 34,color: kWhite,)),
    );
  }
}






//
// class QuestionScreen extends StatelessWidget {
//   final Subject subject;
//
//   const QuestionScreen({super.key, required this.subject});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(QuestionController());
//     controller.loadQuestions(subject.subjectId);
//
//     return Scaffold(
//       appBar: AppBar(title: Text(subject.subjectName)),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (controller.questions.isEmpty) {
//           return const Center(child: Text('No questions found'));
//         }
//         return ListView.builder(
//           itemCount: controller.questions.length,
//           itemBuilder: (context, index) {
//             final q = controller.questions[index];
//             return Card(
//               margin: const EdgeInsets.all(10),
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Q${index + 1}: ${q.questionText}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 10),
//                     ...q.options.map((opt) => ListTile(
//                       title: Text(opt),
//                       leading: Radio<String>(
//                         groupValue: q.correctAnswer,
//                         value: opt.substring(0, 1),
//                         onChanged: null, // static preview
//                       ),
//                     )),
//                     const SizedBox(height: 5),
//                     Text('Explanation: ${q.explanation}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
//                     const SizedBox(height: 5),
//                     Text('Reference: ${q.reference}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
