/// app_dimensions.dart
/// Hằng số kích thước, khoảng cách, bo góc trích xuất từ thiết kế
/// Tất cả giá trị sẽ được nhân với hệ số responsive qua flutter_screenutil
library;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimensions {
  AppDimensions._();

  // ─── Screen Padding ────────────────────────────────────────────────────────
  static double get screenPaddingH => 20.w;   // Padding ngang toàn màn hình
  static double get screenPaddingV => 24.h;   // Padding dọc toàn màn hình
  static double get sectionSpacing => 24.h;   // Khoảng cách giữa các section

  // ─── Border Radius ─────────────────────────────────────────────────────────
  static double get radiusXS => 6.r;
  static double get radiusSM => 8.r;
  static double get radiusMD => 12.r;     // Card, TextField
  static double get radiusLG => 16.r;     // Bottom Sheet, Dialog
  static double get radiusXL => 20.r;     // Large card
  static double get radiusFullPill => 28.r; // Button pill shape (full rounded)
  static double get radiusCircle => 100.r; // Avatar, circular

  // ─── Button ────────────────────────────────────────────────────────────────
  static double get buttonHeight => 52.h;        // Chiều cao nút chính
  static double get buttonHeightSM => 40.h;      // Nút nhỏ (filter, tag)
  static double get buttonHeightXS => 32.h;      // Nút nhỏ nhất

  // ─── TextField ─────────────────────────────────────────────────────────────
  static double get textFieldHeight => 52.h;
  static double get textFieldPaddingH => 16.w;
  static double get textFieldPaddingV => 14.h;

  // ─── AppBar ────────────────────────────────────────────────────────────────
  static double get appBarHeight => 60.h;
  static double get appBarIconSize => 24.r;

  // ─── Bottom Navigation ─────────────────────────────────────────────────────
  static double get bottomNavHeight => 64.h;
  static double get bottomNavIconSize => 24.r;

  // ─── Avatar ────────────────────────────────────────────────────────────────
  static double get avatarXS => 32.r;    // Notification, comment
  static double get avatarSM => 40.r;    // Story, post list
  static double get avatarMD => 48.r;    // Post header
  static double get avatarLG => 72.r;    // Profile page
  static double get avatarXL => 96.r;    // Profile banner

  // ─── Card ──────────────────────────────────────────────────────────────────
  static double get cardPaddingH => 16.w;
  static double get cardPaddingV => 16.h;
  static double get cardSpacing => 12.h;  // Khoảng cách giữa cards

  // ─── Icon ──────────────────────────────────────────────────────────────────
  static double get iconSM => 16.r;
  static double get iconMD => 20.r;
  static double get iconLG => 24.r;
  static double get iconXL => 32.r;

  // ─── Spacing helpers ───────────────────────────────────────────────────────
  static double get space4 => 4.h;
  static double get space6 => 6.h;
  static double get space8 => 8.h;
  static double get space10 => 10.h;
  static double get space12 => 12.h;
  static double get space16 => 16.h;
  static double get space20 => 20.h;
  static double get space24 => 24.h;
  static double get space32 => 32.h;
  static double get space40 => 40.h;
  static double get space48 => 48.h;

  // ─── Story / Circle ────────────────────────────────────────────────────────
  static double get storySize => 56.r;
  static double get storyBorderWidth => 2.5.r;

  // ─── OTP Input ─────────────────────────────────────────────────────────────
  static double get otpBoxSize => 52.r;
  static double get otpBoxRadius => 12.r;

  // ─── Profile Banner ────────────────────────────────────────────────────────
  static double get profileBannerHeight => 140.h;
}
