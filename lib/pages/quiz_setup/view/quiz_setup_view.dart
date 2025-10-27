import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common/back_button.dart';
import '/core/common/set_purchase_card.dart';
import '/ad_manager/banner_ads.dart';
import '../../edite_subjects/controller/edite_subject_controller.dart';
import '../../premium/view/premium_screen.dart';
import '/ad_manager/remove_ads.dart';
import '/core/common/common_button.dart';
import '/core/constant/constant.dart';
import '/core/routes/routes_name.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_styles.dart';
import '/pages/quiz_setup/controller/quiz_setup_controller.dart';
import '../widgets/options_chip.dart';

class QuizSetupView extends StatelessWidget {
  const QuizSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizSetupController>();
    return Scaffold(
      backgroundColor: kWhiteF7,
      appBar: AppBar(
        leading: CommonBackButton(),
        backgroundColor: kWhiteF7,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quiz", style: titleMediumStyle),
            Text(
              "Set up your quiz preferences",
              style: titleSmallStyle.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: roundedDecoration,
                  child: Center(
                    child:Obx(() => Text(
                      controller.selectedSubject.value?.subjectName ?? "",
                      style: titleMediumStyle.copyWith(
                        color: lightSkyBlue,
                        fontSize: 17
                      ),
                    )),
                  ),
                ),
              ),
              const SizedBox(height:16),
              SetPurchaseCard(),
              const SizedBox(height:16),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: lightSkyBlue, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "⏳ Each question has its own timer. Be quick and stay focused!",
                        style: context.textTheme.titleMedium!.copyWith(
                          color: Colors.blueGrey.shade700,
                          fontSize: 13.5,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const _SectionTitle(title: "Select Time Limit : sec"),
              const SizedBox(height: 10),
              const _TimeLimitSelector(),
              const SizedBox(height: 20),
              const _SectionTitle(title: "Select Number of Questions"),
              const SizedBox(height: 10),
              const QuestionCountSelector(),
              const SizedBox(height: 20),
              const Text(
                "Note: If the quiz fails to load repeatedly, consider "
                    "changing the question limit, difficulty, or category.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 20),
              CommonButton(
                title: "Start Quiz",
                onTap: () {
                  controller.clearQuiz();
                  Get.toNamed(RoutesName.secondQuizView);
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BannerAdWidget(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style:
    titleMediumStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.normal
    ));
  }
}

class _TimeLimitSelector extends StatelessWidget {
  const _TimeLimitSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizSetupController>();
    final subController = Get.find<RemoveAds>();
    return Obx(() {
      final options = controller.timeOptions;
      final isSubscribed = subController.isSubscribedGet.value;
      return Padding(
        padding: const EdgeInsets.only(right: 80),
        child: Row(
          children: options.map((time) {
            final isSelected = controller.selectedTimeLimit.value == time;
            final isLocked = !isSubscribed && time != 10;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: OptionChip(
                  label: "$time",
                  isLocked: isLocked,
                  isSelected: isSelected,
                  onTap:isLocked
                      ? () => Get.find<EditeSubjectController>().showDialog(onUpgrade: (){
                      Get.back();
                      Get.to(() => PremiumScreen());
                    }) : () => controller.setTimeLimit(time),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }}

