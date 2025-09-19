import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';


/*
Use This themes for button for card as well as field
if need something extra, define here just you need to call
in Ui Screen
*/

abstract class AppTheme {
  static const fontFamily = 'Montserrat';

  // BUTTON STYLES
  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: kWhite,
    textStyle: buttonTextStyle,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 08),
    minimumSize: const Size(double.maxFinite, 50),
    shadowColor: Colors.grey.withValues(alpha: 0.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  );

  static BoxDecoration card = BoxDecoration(
    color: kWhite,
    borderRadius: BorderRadius.circular(6),
    border: Border.all(color: greyColor.withAlpha(60)),
  );

  static BoxDecoration gradientHeader = const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF1E90FF), Color(0xFF87CEFA)], // blue shades
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter),
    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(30),
      bottomLeft: Radius.circular(30),
    ),
  );



  static BoxDecoration topRounded(double height) {
    return BoxDecoration(
      color: kWhiteF7,
      borderRadius: BorderRadius.vertical(
        top: Radius.elliptical(height, 200.0),
      ),
    );
  }

  static BoxDecoration buttonDecoration =  BoxDecoration(
      gradient: LinearGradient(
          colors: [Color(0xFF1E90FF), Color(0xFF87CEFA)], // blue shades
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
  // color: gradientHeader,
  borderRadius: BorderRadius.circular(30)
  );

  static BoxDecoration statViewStateDecoration = BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(12),
    );

  static BoxDecoration resultViewStateDecoration = BoxDecoration(
    gradient: LinearGradient(
        colors: [Color(0xFF1E90FF), Color(0xFF87CEFA)], // blue shades
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
    borderRadius: BorderRadius.circular(12),
  );



  static BoxDecoration borderedBlue = BoxDecoration(
    color: kWhite,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color:kBlue.withAlpha(200),
      width: 0.5,
    ),
  );

  static List<BoxShadow> defaultShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      offset: const Offset(0, 2),
      blurRadius: 2,
      spreadRadius: 2,
    ),
  ];


  static final ButtonStyle textButtonStyle = TextButton.styleFrom(
    backgroundColor: kWhite,
    textStyle: buttonTextStyle,
    foregroundColor: kBlack,
    elevation: 4,
    shadowColor: Colors.grey.withValues(alpha: 0.5),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    minimumSize: const Size(double.maxFinite, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    backgroundColor: Colors.transparent,
    textStyle: buttonTextStyle,
    foregroundColor: kBlack,
    padding: EdgeInsets.zero,
    side: BorderSide.none,
  );




  static final confirmButtonStyle = TextButton.styleFrom(
    foregroundColor: kRed,
    backgroundColor: Colors.transparent,
    textStyle: labelMediumStyle,
    minimumSize: Size(10, 10),
    padding: EdgeInsets.only(bottom: 20),
  );

  static const UnderlineInputBorder greyUnderLineBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: greyBorderColor,
    ),
  );

  // FINAL THEME DATA
  static final ThemeData themeData = ThemeData(
    fontFamily: fontFamily,
    scaffoldBackgroundColor: bgColor,
    textTheme: const TextTheme(
      headlineSmall: headlineSmallStyle,
      headlineMedium: headlineMediumStyle,
      titleLarge: titleLargeStyle,
      titleMedium: titleMediumStyle,
      titleSmall: titleSmallStyle,
      bodyLarge: bodyLargeStyle,
      bodyMedium: bodyMediumStyle,
      bodySmall: bodySmallStyle,
      labelMedium: labelMediumStyle,
      labelSmall: labelSmallStyle,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.zero,
      border: greyUnderLineBorder,
      enabledBorder: greyUnderLineBorder,
      focusedBorder: greyUnderLineBorder,
      errorBorder: greyUnderLineBorder.copyWith(
        borderSide: BorderSide(color: kRed),
      ),
      focusedErrorBorder: greyUnderLineBorder,
      hintStyle: bodyMediumStyle.copyWith(
        color: textGreyColor,
      ),
      fillColor: Colors.white,
      filled: true,
      suffixIconColor: suffixIconColor,
      prefixIconColor: suffixIconColor,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kBlack,
      selectionColor: greyColor.withValues(alpha: 0.2),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: appBarBgColor,
      titleTextStyle: titleLargeStyle,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: elevatedButtonStyle,
    ),
    textButtonTheme: TextButtonThemeData(
      style: textButtonStyle,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: outlinedButtonStyle,
    ),
  );
}
