//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocket_prep_exam/core/common/app_divider.dart';
// import 'package:pocket_prep_exam/core/common/constant.dart';
// import 'package:pocket_prep_exam/core/theme/app_colors.dart';
// import '../control/setting_controller.dart';
//
// class ItemsList extends StatelessWidget {
//   const ItemsList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<SettingController>();
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: controller.settingsItems.length,
//       itemBuilder: (context, index) {
//         final item = controller.settingsItems[index];
//         // bool showDivider = index < 4 || index == 5;
//         // bool lastItem = index >= 6 ;
//         return InkWell(
//           onTap: () {
//           },
//           child: Padding(
//             padding:  EdgeInsets.symmetric(horizontal: bodyWH),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: Row(
//                     children: [
//                       Icon(
//                         item.icon,
//                         color:kBlue,
//                         size: 26,
//                       ),
//                       const SizedBox(width: 20),
//                       Text(
//                         item.title,
//                         style: const TextStyle(
//                           color: kBlue,
//                           fontSize: 17,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 AppDivider(height: 1,thickness: 1,color: greyColor.withAlpha(60),)
//                 // if (showDivider)
//                 // //    Divider(
//                 // //     height: 1,
//                 // //     thickness: 1,
//                 // //     color: greyColor.withAlpha(80),
//                 //   ),
//
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }