import 'package:flutter/material.dart';

/// Ekran genişliğine göre responsive değerler.
class Responsive {
  Responsive._();

  /// Mobil kabul edilen üst sınır (px).
  static const double mobileBreakpoint = 600;

  /// Geniş masaüstü (px) – bu genişlikten sonra landing daha ferah.
  static const double desktopBreakpoint = 1024;

  /// Tablet ve üzeri için içerik maksimum genişlik (px).
  static const double contentMaxWidth = 720;

  /// Landing sayfası için içerik maksimum genişlik (px).
  static const double landingMaxWidth = 960;

  /// Geniş ekranlarda landing için max genişlik (px).
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

  /// Sayfa yatay padding: mobilde daha dar, masaüstünde daha geniş.
  static EdgeInsets pagePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 20);
    }
    return const EdgeInsets.symmetric(horizontal: 32, vertical: 32);
  }

  /// Ana sayfa logo boyutu.
  static double homeLogoSize(BuildContext context) {
    return isMobile(context) ? 100 : 140;
  }

  /// AppBar logo boyutu.
  static double appBarLogoSize(BuildContext context) {
    return isMobile(context) ? 28 : 36;
  }

  /// AppBar başlık font boyutu.
  static double appBarTitleFontSize(BuildContext context) {
    return isMobile(context) ? 17 : 22;
  }

  /// Ana sayfa başlık (headline) font boyutu için scale.
  static double headlineScale(BuildContext context) {
    return isMobile(context) ? 1.0 : 1.25;
  }

  /// İçerik alanını masaüstünde ortala ve max genişlik ver.
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

  /// Landing sayfası için geniş içerik alanı (hero, features vb.).
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

  /// Masaüstü için section yatay padding (daha geniş).
  static double sectionHorizontalPadding(BuildContext context) {
    if (isMobile(context)) return 20;
    if (MediaQuery.sizeOf(context).width >= desktopBreakpoint) return 48;
    return 32;
  }
}
