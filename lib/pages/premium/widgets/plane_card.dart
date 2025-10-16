import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';


class PremiumPlansCarousel extends StatefulWidget {
  const PremiumPlansCarousel({super.key});

  @override
  State<PremiumPlansCarousel> createState() => _PremiumPlansCarouselState();
}

class _PremiumPlansCarouselState extends State<PremiumPlansCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.55);
  int _currentPage = 1;
  Timer? _autoScrollTimer;

  final List<PlanModel> plans = [
    PlanModel(duration: "6", type: "images/crown.png", price: "\$6.25", isPopular: false),
    PlanModel(duration: "1", type: "images/premium-quality.png", price: "\$12.50", isPopular: false),
    PlanModel(duration: "3", type: "images/quality-product.png", price: "\$3.12", isPopular: false),
    // PlanModel(duration: "3", type: "Monthly", price: "\$3.12", isPopular: false),
  ];

  @override
  void initState() {
    super.initState();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      int nextPage = (_currentPage + 1) % plans.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 152,
      width: 280,
      child: PageView.builder(
        controller: _pageController,
        itemCount: plans.length,
        clipBehavior: Clip.none,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          final isActive = index == _currentPage;
          final plan = plans[index];
          return AnimatedScale(
            duration: const Duration(milliseconds: 400),
            scale: isActive ? 1.02 : 0.9,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: isActive ? 1.0 : 0.6,
              child: PlanCard(plan: plan, isActive: isActive),
            ),
          );
        },
      ),
    );
  }
}
class PlanCard extends StatelessWidget {
  final PlanModel plan;
  final bool isActive;

  const PlanCard({super.key, required this.plan, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(08),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: plan.isPopular
              ? [kWhite, kWhite]
              : [kWhite, kWhite],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: kBlack.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Stack(
        children: [
          if (plan.isPopular)
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Popular",
                    style: context.textTheme.labelSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 4),
                Text(plan.duration,
                    style: context.textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                Image.asset(plan.type,height: 60,),
                const SizedBox(height: 4),
                Text(plan.price,
                    style: context.textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
