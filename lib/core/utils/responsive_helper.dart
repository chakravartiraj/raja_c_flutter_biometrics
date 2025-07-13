import 'package:flutter/material.dart';

class ResponsiveHelper {
  static const double tabletBreakpoint = 768.0;
  static const double desktopBreakpoint = 1024.0;

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < tabletBreakpoint;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static EdgeInsets getPadding(BuildContext context) {
    if (isTablet(context)) {
      return const EdgeInsets.all(24.0);
    }
    return const EdgeInsets.all(16.0);
  }

  static double getFontSize(BuildContext context, double baseFontSize) {
    if (isTablet(context)) {
      return baseFontSize * 1.2;
    }
    return baseFontSize;
  }
}