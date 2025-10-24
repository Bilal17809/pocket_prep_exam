import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/services/subscription_services.dart';

class PremiumPlansController extends GetxController {
  final purchaseService = Get.put(PurchaseService());
  final PageController pageController = PageController(viewportFraction: 0.55);

  final currentPage = 0.obs;
  final selectedIndex = 0.obs;
  final plan = <PlanModelForFree>[].obs;
  RxBool isLoading = false.obs;

  Timer? _autoScrollTimer;

  @override
  void onInit() {
    super.onInit();
    startAutoScroll();
    _loadProducts();
  }
  final List<PlanModel> plans = [
    PlanModel(
      duration: "images/100-percent.png",
      type: "images/exams.png",
      features: [
        "Unlimited Exams",
      ],
      isPopular: false,
    ),
    PlanModel(
      duration: "images/special-tag.png",
      type: "images/premium-quality.png",
      features: [
        "Unlimited Subjects",
      ],
      isPopular: true,
    ),
    PlanModel(
      duration: "images/100-percent.png",
      type: "images/quiz.png",
      features: [
        "Different Quiz",
      ],
      isPopular: false,
    ),
    PlanModel(
      duration: "images/100-percent.png",
      type: "images/quality-product.png",
      features: [
        "Ads free",
      ],
      isPopular: false,
    ),
  ];

  Future<void> _loadProducts() async {
    try {
      isLoading.value = true;
      await purchaseService.init((fn) => fn());
      final products = purchaseService.products;

      plan.value = products.map((p) {
        return PlanModelForFree(
          title: p.title,
          subtitle: '${p.description} / ${p.price}',
          discount: p.price,
          productId: p.id,
        );
      }).toList();
    } catch (e) {
      print("❌ Error loading products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void selectPlan(int index) {
    selectedIndex.value = index;
  }

  PlanModelForFree get selectedPlan => plan[selectedIndex.value];

  void startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (plans.isNotEmpty) {
        final nextPage = (currentPage.value + 1) % plans.length;
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
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
  final String productId;

  PlanModelForFree({
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.productId,
  });
}

class PlanModel {
  final String duration;
  final String type;
  final List<String> features;
  final bool isPopular;

  PlanModel({
    required this.duration,
    required this.type,
    required this.features,
    this.isPopular = false,
  });
}