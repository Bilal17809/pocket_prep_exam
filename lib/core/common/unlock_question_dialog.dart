import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// --- Custom Dialog Widget ---
class SimpleAdAccessDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onWatchAds; // The required action

  const SimpleAdAccessDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onWatchAds,
  }) : super(key: key);

  // Placeholder actions used directly in the dialog
  void _onGoPremium(BuildContext context) {
    Navigator.of(context).pop();
    print('Placeholder: Navigating to Premium Screen.');
  }

  void _onCancel(BuildContext context) {
    Navigator.of(context).pop();
    print('Dialog Cancelled.');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 10,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // --- Animation Section ---
          SizedBox(
            height:200,
            child:  Lottie.asset(
              'assets/watch_ads_lottie.json',
            ),
          ) ,

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 30),

            // --- Watch Ads + Cancel Buttons in One Row ---
            Row(
              children: [
                // Watch Ads Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onWatchAds,
                    icon: const Icon(Icons.slow_motion_video_rounded, color: Colors.white),
                    label: const Text(
                      'WATCH AD',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF4CAF50),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Cancel Button (in same row)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _onCancel(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- Premium Option ---
            Center(
              child: TextButton(
                onPressed: () => _onGoPremium(context),
                child: const Text(
                  'Or Go Ad-Free with Premium',
                  style: TextStyle(
                    color: Color(0xFF6C63FF),
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
