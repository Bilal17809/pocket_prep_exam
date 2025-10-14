// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocket_prep_exam/core/theme/app_colors.dart';
// import 'package:pocket_prep_exam/core/theme/app_styles.dart';
// import '../controller/quiz_builder_controller.dart';
//
// class ExamSelectionWidget extends StatelessWidget {
//   const ExamSelectionWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<QuizBuilderController>();
//
//     return Obx(() {
//       if (controller.exams.isEmpty) {
//         return const Center(child: Text("No exams available"));
//       }
//
//       return SizedBox(
//         height: 100,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           padding: EdgeInsets.only(left: 08,right: 08),
//           child: Row(
//             children: controller.exams.map((exam) {
//               final isSelected = controller.selectedExams.contains(exam);
//               return AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                 width: 160,
//                 decoration: roundedDecoration.copyWith(
//                   border: Border.all(
//                     color: isSelected ? lightSkyBlue : Colors.white,
//                     width: 1.6,
//                   ),
//                   color: Colors.white, // same background always
//                 ),
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(10),
//                   onTap: () => controller.toggleExamSelection(exam),
//                   child: Padding(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         AnimatedSwitcher(
//                           duration: const Duration(milliseconds: 250),
//                           child: isSelected
//                               ? const Icon(Icons.done_all,
//                               color: Colors.blue, size: 18)
//                               : const SizedBox(width: 18),
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 exam.examName,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                   color: Colors.black87, // fixed text color
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 "${exam.subjects.length} subjects • ${exam.totalQuestions} Qs",
//                                 style: TextStyle(
//                                   color: Colors.grey.shade700,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       );
//     });
//   }
// }
