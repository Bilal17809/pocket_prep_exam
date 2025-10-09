
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/core/theme/app_colors.dart';

class PageIndicator extends StatelessWidget {
  final PageController pageController;
  final int itemCount;

  const PageIndicator({
    super.key,
    required this.pageController,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final availableWidth = itemCount <= 5
            ? (constraints.maxWidth - 80)
            : (constraints.maxWidth - 120);
        return Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: constraints.maxWidth,
            child: SmoothPageIndicator(
              controller: pageController,
              count: itemCount,
              effect: JumpingDotEffect(
                dotWidth: (availableWidth) / itemCount,
                dotHeight: 02,
                dotColor: kWhite,
                activeDotColor: Colors.orange,
              ),
            ),
          ),
        );
      },
    );
  }
}