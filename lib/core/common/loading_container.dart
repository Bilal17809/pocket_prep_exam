import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Color? backgroundColor;
  final Color? indicatorColor;
  final String? message;
  final Color? messageTextColor;

  const LoadingContainer({
    super.key,
    this.backgroundColor,
    this.indicatorColor,
    this.message,
    this.messageTextColor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: indicatorColor ?? Theme.of(context).primaryColor,
            ),
            if (message != null) ...[
              const SizedBox(height: 12),
              Text(
                message!,
                style:  TextStyle(fontSize: 16,color: messageTextColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
