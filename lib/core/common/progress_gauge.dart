

import 'dart:math' as math;
import 'package:flutter/material.dart';


class ProgressGauge extends StatelessWidget {
  final double progress;
  final double size;
  final Color color;
  const ProgressGauge({
    Key? key,
    required this.progress,
    this.size = 200,
    this.color = Colors.white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(size, size / 2),
          painter: _SemiCirclePainter(
            progress: progress,
            progressColor: const Color(0xFFD58F00),
            backgroundColor: Color(0xFF1E90FF),
            strokeWidth: 12.0,
          ),
        ),
        // Center mein percentage text
        Positioned(
          top: size * 0.2,
          child: Text(
            '${(progress * 100).toInt()}%',
            style:  TextStyle(
              fontSize: 50,
              color:color,
              fontWeight: FontWeight.w600,
              fontFamily: 'Arial',
            ),
          ),
        ),
      ],
    );
  }
}

class _SemiCirclePainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  _SemiCirclePainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final thumbPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill;
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    const startAngle = -math.pi;
    const sweepAngle = math.pi;
    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);
    final progressSweepAngle = progress * sweepAngle;
    canvas.drawArc(rect, startAngle, progressSweepAngle, false, progressPaint);
    final thumbAngle = startAngle + progressSweepAngle;
    final thumbX = center.dx + radius * math.cos(thumbAngle);
    final thumbY = center.dy + radius * math.sin(thumbAngle);
    final thumbOffset = Offset(thumbX, thumbY);
    canvas.drawCircle(thumbOffset, strokeWidth * 0.9, thumbPaint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}