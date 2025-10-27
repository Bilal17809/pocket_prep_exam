import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/constant/constant.dart';
import '/core/common/common_button.dart';
import '/core/theme/app_colors.dart';
import '../widgets/custom_header.dart';

class TermServicesView extends StatelessWidget {
  const TermServicesView({super.key});

  final String AppFullName = "${AppFirstName} ${AppLastName}";

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteF7,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(
                title: AppFullName,
                subtitle: "Terms Of Services",
                onBack: () => Get.back(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "We offer our users two types of subscriptions that unlock full access to all $AppFullName Exam features, "
                          "providing a complete premium experience with pro tools and uninterrupted practice sessions.",
                      style: textTheme.bodyMedium?.copyWith(height: 1.5, color: Colors.black87),
                    ),
                    const SizedBox(height: 18),

                    _SectionTitle(title: "Features:", style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    const _FeatureItem(text: "100% Ads-free premium experience"),
                    const _FeatureItem(text: "Access to all quiz questions beyond the first 30 (first 30 free)"),
                    const _FeatureItem(text: "Timed quizzes for real exam-like practice"),
                    const _FeatureItem(text: "Custom Quiz Builder to create your own quizzes"),
                    const _FeatureItem(text: "Full access to all Practice Sets"),
                    const _FeatureItem(text: "Ability to switch freely between 3 Exams"),
                    const SizedBox(height: 16),
                    _SectionTitle(title: "One Year Subscription:", style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(
                      "This plan gives you 1 year of complete premium access to $AppFullName. "
                          "You’ll unlock all quizzes, the quiz builder, timed mode, and ad-free learning across all subjects. "
                          "Cancel anytime — access remains active until the end of your billing period.",
                      style: textTheme.bodyMedium?.copyWith(height: 1.6, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    const _BulletList(items: [
                      "Ad-free experience throughout the year",
                      "Access to all subjects and question sets",
                      "Priority updates and new quiz packs",
                      "Cancelable anytime",
                    ]),
                    const SizedBox(height: 22),

                    _SectionTitle(title: "Lifetime (Ads Removal):", style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(
                      "Enjoy lifetime premium access with a one-time payment. "
                          "This plan permanently removes ads, unlocks all features, "
                          "and gives you uninterrupted learning for life.",
                      style: textTheme.bodyMedium?.copyWith(height: 1.6, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    const _BulletList(items: [
                      "One-time payment — no renewals",
                      "Ad-free forever",
                      "Lifetime access to quizzes and updates",
                      "Perfect for long-term learners",
                    ]),

                    const SizedBox(height: 16),
                    CommonButton(
                      title: "Back",
                      onTap: () => Get.back(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final TextStyle? style;
  const _SectionTitle({super.key, required this.title, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style?.copyWith(fontWeight: FontWeight.w700, color: Colors.black),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;
  const _FeatureItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFFEAF7EE),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.done_all, color: Colors.green, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  const _BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      children: items.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Icon(Icons.circle, size: 6, color: Colors.black54),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  e,
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
