
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Function(String)? onFieldSubmitted;
  final TextAlignVertical? textAlignVertical;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.textAlignVertical,
    this.hintStyle,
    this.textDirection,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.obscureText = false,
    this.style,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      readOnly: readOnly,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: style,
      textAlign: textAlign,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      cursorColor: kBlack,
      onFieldSubmitted: onFieldSubmitted,
      // textAlignVertical: textAlignVertical ?? TextAlignVertical.center,

      // 👇 important changes
      maxLines: 1,
      scrollPhysics: const BouncingScrollPhysics(),
      textInputAction: TextInputAction.done,

      decoration: InputDecoration(
        // isDense: true,
        hintText: hintText,
        hintStyle: hintStyle,
        maintainHintHeight: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: border ?? InputBorder.none,
        focusedBorder: focusedBorder ?? InputBorder.none,
        enabledBorder: enabledBorder ?? InputBorder.none,
        contentPadding:
        contentPadding ??
            const EdgeInsets.symmetric(horizontal: 02, vertical: 12),
      ),
    );
  }
}
