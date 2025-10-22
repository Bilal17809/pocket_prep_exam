// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// class PremiumPlansController extends GetxController {
//   final PageController pageController = PageController(viewportFraction: 0.55);
//   final currentPage = 0.obs;
//   Timer? _autoScrollTimer;
//   final selectedIndex = 0.obs;
//
//   final List<PlanModel> plans = [
//     PlanModel(duration: "images/tag.png", type: "images/crown.png", price: "\$6.25", isPopular: false),
//     PlanModel(duration: "images/tag.png", type: "images/premium-quality.png", price: "\$12.50", isPopular: false),
//     PlanModel(duration: "images/tag.png", type: "images/quality-product.png", price: "\$3.12", isPopular: false),
//   ];
//
//   final plan = <PlanModelForFree >[
//     PlanModelForFree (title: "Free 3 Days", subtitle: "Weekly / \$2.99", discount: "58% OFF"),
//     PlanModelForFree (title: "Free 7 Days", subtitle: "Monthly / \$4.99", discount: "64% OFF"),
//   ].obs;
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     _startAutoScroll();
//   }
//
//
//
//
//   void selectPlan(int index) {
//     selectedIndex.value = index;
//   }
//
//   PlanModelForFree get selectedPlan => plan[selectedIndex.value];
//
//   void _startAutoScroll() {
//     _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
//       final nextPage = (currentPage.value + 1) % plans.length;
//       pageController.animateToPage(
//         nextPage,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }
//
//   void onPageChanged(int index) => currentPage.value = index;
//
//   @override
//   void onClose() {
//     _autoScrollTimer?.cancel();
//     pageController.dispose();
//     super.onClose();
//   }
// }
//
//
//
// class PlanModelForFree {
//   final String title;
//   final String subtitle;
//   final String discount;
//
//   PlanModelForFree({
//     required this.title,
//     required this.subtitle,
//     required this.discount,
//   });
// }
//
//
// class PlanModel {
//   final String duration;
//   final String type;
//   final String price;
//   final bool isPopular;
//
//   PlanModel({
//     required this.duration,
//     required this.type,
//     required this.price,
//     this.isPopular = false,
//   });
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../services/subscription_services.dart';

class PremiumPlansController extends GetxController {
  final purchaseService = Get.put(PurchaseService());
  final PageController pageController = PageController(viewportFraction: 0.55);

  final currentPage = 0.obs;
  final selectedIndex = 0.obs;
  final plan = <PlanModelForFree>[].obs;
  final plans = <PlanModel>[].obs;

  Timer? _autoScrollTimer;

  @override
  void onInit() {
    super.onInit();
    _loadProducts();
    _startAutoScroll();
  }

  Future<void> _loadProducts() async {
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
    plans.assignAll([
      PlanModel(duration: "images/tag.png", type: "images/crown.png", price: "\$6.25"),
      PlanModel(duration: "images/tag.png", type: "images/premium-quality.png", price: "\$12.50"),
      PlanModel(duration: "images/tag.png", type: "images/quality-product.png", price: "\$3.12"),
    ]);
  }

  void selectPlan(int index) {
    selectedIndex.value = index;
  }

  PlanModelForFree get selectedPlan => plan[selectedIndex.value];

  void _startAutoScroll() {
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

// --- MODEL UPDATE ---

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
  final String price;
  final bool isPopular;

  PlanModel({
    required this.duration,
    required this.type,
    required this.price,
    this.isPopular = false,
  });
}
