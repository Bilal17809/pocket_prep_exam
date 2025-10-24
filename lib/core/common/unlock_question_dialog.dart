import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_prep_exam/core/common/set_purchase_card.dart';
import '../../pages/premium/view/premium_screen.dart';
import '../theme/app_styles.dart';

class SimpleAdAccessDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onWatchAds;

  const SimpleAdAccessDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onWatchAds,
  }) : super(key: key);

  void _onCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 10,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Lottie.asset(
                    'assets/watch_ads_lottie.json',
                    height: 180,
                    fit: BoxFit.cover,
                    repeat: true,
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => Get.to(() => const PremiumScreen()),
                icon: Image.asset("images/quality-product.png", height: 30),
                label: const Text(
                  'Go To Premium',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                style: elevatedPremiumDecoration,
              ),

              const SizedBox(height: 16),
              _DialogButtonsRow(
                onCancel: () => _onCancel(context),
                onWatchAds: onWatchAds,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogButtonsRow extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onWatchAds;

  const _DialogButtonsRow({
    super.key,
    required this.onCancel,
    required this.onWatchAds,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onCancel,
              style: outLineCancelDecoration,
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onWatchAds,
              icon: const Icon(Icons.slow_motion_video_rounded,
                  color: Colors.white),
              label: const Text(
                'WATCH AD',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              style: elevatedAdsDecoration,
            ),
          ),
        ],
      ),
    );
  }
}
