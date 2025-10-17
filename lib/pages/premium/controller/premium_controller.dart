import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PremiumPlansController extends GetxController {
  final PageController pageController = PageController(viewportFraction: 0.55);
  final currentPage = 0.obs;
  Timer? _autoScrollTimer;
  final selectedIndex = 0.obs;

  final List<PlanModel> plans = [
    PlanModel(duration: "images/tag.png", type: "images/crown.png", price: "\$6.25", isPopular: false),
    PlanModel(duration: "images/tag.png", type: "images/premium-quality.png", price: "\$12.50", isPopular: false),
    PlanModel(duration: "images/tag.png", type: "images/quality-product.png", price: "\$3.12", isPopular: false),
  ];

  final plan = <PlanModelForFree >[
    PlanModelForFree (title: "Free 3 Days", subtitle: "Weekly / \$2.99", discount: "58% OFF"),
    PlanModelForFree (title: "Free 7 Days", subtitle: "Monthly / \$4.99", discount: "64% OFF"),
  ].obs;


  @override
  void onInit() {
    super.onInit();
    _startAutoScroll();
  }




  void selectPlan(int index) {
    selectedIndex.value = index;
  }

  PlanModelForFree get selectedPlan => plan[selectedIndex.value];

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      final nextPage = (currentPage.value + 1) % plans.length;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void onPageChanged(int index) => currentPage.value = index;

  @override
  void onClose() {
    _autoScrollTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}



class PlanModelForFree {
  final String title;
  final String subtitle;
  final String discount;

  PlanModelForFree({
    required this.title,
    required this.subtitle,
    required this.discount,
  });
}


class PlanModel {
  final String duration;
  final String type;
  final String price;
  final bool isPopular;

  PlanModel({
    required this.duration,
    required this.type,
    required this.price,
    this.isPopular = false,
  });
}
