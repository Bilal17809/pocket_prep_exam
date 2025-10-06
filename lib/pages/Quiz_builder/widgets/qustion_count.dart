// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/quiz_builder_controller.dart';
//
// class QuestionCountWidget extends StatelessWidget {
//   const QuestionCountWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<QuizBuilderController>();
//
//     return Obx(() => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: controller.selectedSubjects.map((subject) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 6),
//           child: Row(
//             children: [
//               Expanded(flex: 2, child: Text(subject.subjectName)),
//               Expanded(
//                 flex: 1,
//                 child: TextField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: "Count",
//                     border: OutlineInputBorder(),
//                     contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   ),
//                   onChanged: (value) {
//                     if (value.isNotEmpty) {
//                       controller.setQuestionCount(subject.subjectId, int.parse(value));
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     ));
//   }
// }
