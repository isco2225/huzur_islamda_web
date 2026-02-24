import 'package:flutter/material.dart';

/// Responsive layout helpers based on screen width.
class Responsive {
  Responsive._();

  /// Maximum width (px) considered as mobile.
  static const double mobileBreakpoint = 600;

  /// Desktop breakpoint (px) – landing layout gets roomier beyond this.
  static const double desktopBreakpoint = 1024;

  /// Max content width (px) for tablet and larger.
  static const double contentMaxWidth = 720;

  /// Max content width (px) for the landing page.
  static const double landingMaxWidth = 960;

  /// Max landing width (px) on wide screens.
  static const double landingWideMaxWidth = 1200;

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < mobileBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= mobileBreakpoint;
  }

  static bool isWideDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= desktopBreakpoint;
  }

  static double widthOf(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  /// Page horizontal padding: tighter on mobile, wider on desktop.
  static EdgeInsets pagePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 20);
    }
    return const EdgeInsets.symmetric(horizontal: 32, vertical: 32);
  }

  /// Home screen logo size.
  static double homeLogoSize(BuildContext context) {
    return isMobile(context) ? 100 : 140;
  }

  /// App bar logo size.
  static double appBarLogoSize(BuildContext context) {
    return isMobile(context) ? 28 : 36;
  }

  /// App bar title font size.
  static double appBarTitleFontSize(BuildContext context) {
    return isMobile(context) ? 17 : 22;
  }

  /// Scale factor for home screen headline font size.
  static double headlineScale(BuildContext context) {
    return isMobile(context) ? 1.0 : 1.25;
  }

  /// Center content on desktop and apply a max width.
  static Widget constrainContent(BuildContext context, {required Widget child}) {
    if (isMobile(context)) {
      return child;
    }
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: contentMaxWidth),
        child: child,
      ),
    );
  }

  /// Wide content container for landing sections (hero, features, etc.).
  static Widget constrainLandingContent(BuildContext context, {required Widget child}) {
    if (isMobile(context)) {
      return child;
    }
    final width = MediaQuery.sizeOf(context).width;
    final maxW = width >= desktopBreakpoint ? landingWideMaxWidth : landingMaxWidth;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxW),
        child: child,
      ),
    );
  }

  /// Section horizontal padding for desktop (wider gutters).
  static double sectionHorizontalPadding(BuildContext context) {
    if (isMobile(context)) return 20;
    if (MediaQuery.sizeOf(context).width >= desktopBreakpoint) return 48;
    return 32;
  }
}
