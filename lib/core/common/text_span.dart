import 'package:flutter/material.dart';

class CommonLabelValueText extends StatelessWidget {
  final String label;
  final String value;
  final Color labelColor;
  final Color valueColor;
  final double labelFontSize;
  final double valueFontSize;
  final FontWeight labelWeight;
  final FontStyle valueStyle;

  const CommonLabelValueText({
    super.key,
    required this.label,
    required this.value,
    this.labelColor = Colors.black,
    this.valueColor = Colors.black87,
    this.labelFontSize = 14,
    this.valueFontSize = 14,
    this.labelWeight = FontWeight.bold,
    this.valueStyle = FontStyle.normal,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: TextStyle(
              color: labelColor,
              fontWeight: labelWeight,
              fontSize: labelFontSize,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: valueColor,
              fontSize: valueFontSize,
              fontStyle: valueStyle,
            ),
          ),
        ],
      ),
    );
  }
}
