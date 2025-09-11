import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/core/theme/app_colors.dart';

class PageIndicator extends StatelessWidget {
   PageIndicator({super.key});
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SmoothPageIndicator(
        controller: controller,
        count: 10,
        effect: JumpingDotEffect(
            dotWidth: 30,
            dotHeight: 02,
            dotColor: kWhite
        ),
      ),
    );
  }
}
