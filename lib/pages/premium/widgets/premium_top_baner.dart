import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/ad_manager/ad_manager.dart';
import 'package:pocket_prep_exam/core/constant/constant.dart';
import 'package:pocket_prep_exam/core/theme/app_styles.dart';
import '../controller/premium_controller.dart';
import '/core/theme/app_colors.dart';

// class PremiumTopBanner extends StatelessWidget {
//   const PremiumTopBanner({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     return SizedBox(
//       height: height * 0.36,
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           const DecoratedBox(decoration: BoxDecoration(color: lightSkyBlue)),
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [kWhiteF7.withAlpha(0), kWhiteF7],
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Image.asset(
//               "images/premiumpic.png",
//               height: 248,
//               fit: BoxFit.contain,
//             ),
//           ),
//
//           Positioned(
//             top: 36,
//             right: 16,
//             child: CircleAvatar(
//               maxRadius: 18,
//               backgroundColor: kWhite.withAlpha(50),
//               child: IconButton(
//                 icon: const Icon(Icons.close, color: kWhite,size: 20,),
//                 onPressed: () => Get.back(),
//               ),
//             ),
//           ),
//
//           Positioned(
//             top: 36,
//             left: 16,
//             child: Container(
//               padding: EdgeInsets.zero,
//               decoration:roundedDecoration.copyWith(
//                 borderRadius: BorderRadius.circular(22)
//               ),
//               child: TextButton(onPressed:(){
//               }, child:Text("Restore")),
//             ),
//           ),
//
//           Positioned(
//             top: height * 0.29,
//             left: 0,
//             right: 0,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "${AppFirstName} ${AppLastName}",
//                       style: context.textTheme.headlineSmall!.copyWith(
//                         color: kBlack,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   "Unlock all premium features and functions. No Ads",
//                   style:
//                   context.textTheme.titleSmall!.copyWith(color: kBlack,fontSize: 11),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 12),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class PremiumTopBanner extends StatelessWidget {
  const PremiumTopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final controller = Get.find<PremiumPlansController>();
    final remove = Get.find<RemoveAds>();

    return SizedBox(
      height: height * 0.36,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(decoration: BoxDecoration(color: lightSkyBlue)),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [kWhiteF7.withAlpha(0), kWhiteF7],
              ),
            ),
          ),

          // 🔹 Main premium image
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "images/premiumpic.png",
              height: 248,
              fit: BoxFit.contain,
            ),
          ),

          // 🔹 Close Button (Top-Right)
          Positioned(
            top: 36,
            right: 16,
            child: CircleAvatar(
              maxRadius: 18,
              backgroundColor: kWhite.withAlpha(50),
              child: IconButton(
                icon: const Icon(Icons.close, color: kWhite, size: 20),
                onPressed: () => Get.back(),
              ),
            ),
          ),

          // 🔹 Restore Button (Top-Left)
          Positioned(
            top: 36,
            left: 16,
            child: Container(
              padding: EdgeInsets.zero,
              decoration: roundedDecoration.copyWith(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white.withOpacity(0.25),
              ),
              child: TextButton(
                onPressed: () async {
                  await controller.purchaseService.restorePurchases(
                    context,
                        (fn) => fn(),
                  );
                },
                child: const Text(
                  "Restore",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // 🔹 Text section under image
          Positioned(
            top: height * 0.29,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "${AppFirstName} ${AppLastName}",
                  style: context.textTheme.headlineSmall!.copyWith(
                    color: kBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
               Obx((){
                 return  Text(
                   !remove.isSubscribedGet.value?
                   "Unlock all premium features and functions. No Ads"
                       :"You have unlocked all premium features. 🎉",
                   style: context.textTheme.titleSmall!.copyWith(
                     color: kBlack,
                     fontSize: 11,
                   ),
                   textAlign: TextAlign.center,
                 );
               }),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
