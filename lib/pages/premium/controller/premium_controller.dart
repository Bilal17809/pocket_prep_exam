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
    PlanModel(duration: "images/100-percent.png", type: "images/premium-quality.png", price: "", isPopular: false),
    PlanModel(duration: "images/special-tag.png", type: "images/crown.png", price: "", isPopular: false),
    PlanModel(duration: "images/100-percent.png", type: "images/quality-product.png", price: "", isPopular: false),
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
      for (int i = 0; i < plans.length && i < products.length; i++) {
        plans[i] = PlanModel(
          duration: plans[i].duration,
          type: plans[i].type,
          price: products[i].price,
          isPopular: plans[i].isPopular,
        );
      }
      if (products.isNotEmpty) {
        if (plans.length > 1 && products.length > 0) {
          plans[1] = PlanModel(
            duration: plans[1].duration,
            type: plans[1].type,
            price: products.first.price,
            isPopular: plans[1].isPopular,
          );
        }
        if (plans.isNotEmpty && products.length > 1) {
          plans[0] = PlanModel(
            duration: plans[0].duration,
            type: plans[0].type,
            price: products[1].price,
            isPopular: plans[0].isPopular,
          );
        }
      }

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
  final String price;
  final bool isPopular;

  PlanModel({
    required this.duration,
    required this.type,
    required this.price,
    this.isPopular = false,
  });
}
