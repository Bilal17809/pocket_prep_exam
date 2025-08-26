
import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/pages/home/control/home_control.dart';
import '../../main_appbar/main_appbar.dart';
import '../../questions/view/questions_view.dart';
import '/pages/home/widgets/widgets.dart';
import '/core/theme/theme.dart';


// class HomeView extends StatelessWidget {
//
//   const HomeView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kWhiteF7,
//       appBar: const MainAppBar(
//         isBackButton: false,
//         title: 'Car Scanner',
//         subtitle: 'Scan your all Car Sensors',
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal:20,vertical: 20),
//           child: CustomScrollView(
//             slivers: [
//               SliverGrid(
//                 delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                     final item = homeItems[index];
//                     return HomeFeatureItem(
//                       image: item["image"]!,
//                       label: item["name"]!,
//                       onTap: () {},
//                     );
//                   },
//                   childCount: homeItems.length,
//                 ),
//                 gridDelegate:
//                 const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 16,
//                   crossAxisSpacing: 16,
//                   childAspectRatio: 1,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:get/get.dart';

class ExamAndSubjectScreen extends StatelessWidget {
  const ExamAndSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExamAndSubjectController());

    return Scaffold(
      appBar: AppBar(title: const Text('Exams & Subjects')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.exams.isEmpty) {
          return const Center(child: Text('No exams available'));
        }

        return ListView.builder(
          itemCount: controller.exams.length,
          itemBuilder: (context, examIndex) {
            final exam = controller.exams[examIndex];
            return Card(
              margin: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.examName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('Subjects: ${exam.totalSubjects}'),
                    Text('Questions: ${exam.totalQuestions}'),
                    const SizedBox(height: 10),
                    const Text('Subjects:', style: TextStyle(fontWeight: FontWeight.bold)),
                    ListView.builder(
                      itemCount: exam.subjects.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, subjectIndex) {
                        final subject = exam.subjects[subjectIndex];
                        return ListTile(
                          dense: true,
                          leading: CircleAvatar(radius: 12, child: Text('${subject.subjectId}')),
                          title: Text(subject.subjectName),
                          onTap: () {
                            Get.to(() => QuestionScreen(subject: subject));
                          },

                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}



