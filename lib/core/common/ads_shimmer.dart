import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class AdsShimmer extends StatelessWidget {
  const AdsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      left: false,
      right: false,
      child: Shimmer.fromColors(
        baseColor:kWhite,
        highlightColor:kWhiteEF,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
        ),
      ),
    );
  }
}


class NativeAdsShimmer extends StatelessWidget {
  const NativeAdsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final base = kWhiteEF;
    final highlight = kWhite;

    final screenWidth = MediaQuery.of(context).size.width;
    final outerPadding = 16.0 * 2;
    final avatarSize = 70.0;
    final spaceBetween = 16.0;
    final availableForText = screenWidth - outerPadding - avatarSize - spaceBetween;

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // left image
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: availableForText * 0.8,
                      decoration: BoxDecoration(
                        color: kWhiteEF,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 12,
                      width: availableForText * 0.6,
                      decoration: BoxDecoration(
                        color: kWhiteEF,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 10,
                      width: availableForText * 0.4,
                      decoration: BoxDecoration(
                        color: kWhiteEF,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 10,
                      width: availableForText * 0.3,
                      decoration: BoxDecoration(
                        color: kWhiteEF,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // right small button
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: kWhiteEF,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



