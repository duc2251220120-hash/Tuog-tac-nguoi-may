/// app_text_styles.dart
/// Hệ thống typography toàn cục - sử dụng font Inter
/// Dựa trên thiết kế: Bold 700 (heading), SemiBold 600 (button/sub), Regular 400 (body)
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ─── App Logo / Brand ──────────────────────────────────────────────────────
  static TextStyle get appTitle => GoogleFonts.inter(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: -0.3,
      );

  // ─── Heading ───────────────────────────────────────────────────────────────
  static TextStyle get h1 => GoogleFonts.inter(
        fontSize: 26.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.3,
        letterSpacing: -0.5,
      );

  static TextStyle get h2 => GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
        letterSpacing: -0.3,
      );

  static TextStyle get h3 => GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get h4 => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // ─── Body ──────────────────────────────────────────────────────────────────
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  // ─── Body Medium Weight ────────────────────────────────────────────────────
  static TextStyle get bodyMediumBold => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  // ─── Caption / Label ───────────────────────────────────────────────────────
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get captionBold => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get label => GoogleFonts.inter(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // ─── Button ────────────────────────────────────────────────────────────────
  static TextStyle get buttonPrimary => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        letterSpacing: 0.2,
      );

  static TextStyle get buttonSecondary => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
        letterSpacing: 0.2,
      );

  static TextStyle get buttonSmall => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      );

  // ─── Link ──────────────────────────────────────────────────────────────────
  static TextStyle get link => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      );

  static TextStyle get linkSmall => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      );

  // ─── Placeholder / Hint ────────────────────────────────────────────────────
  static TextStyle get hint => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
      );

  // ─── Job / Company ─────────────────────────────────────────────────────────
  static TextStyle get jobTitle => GoogleFonts.inter(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get companyName => GoogleFonts.inter(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get salary => GoogleFonts.inter(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  // ─── Splash / Onboarding ───────────────────────────────────────────────────
  static TextStyle get splashTitle => GoogleFonts.inter(
        fontSize: 34.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        letterSpacing: -0.5,
      );

  static TextStyle get splashSubtitle => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white.withValues(alpha: 0.85),
        height: 1.5,
      );

  static TextStyle get onboardingTitle => GoogleFonts.inter(
        fontSize: 26.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.3,
        letterSpacing: -0.5,
      );

  static TextStyle get onboardingSubtitle => GoogleFonts.inter(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.6,
      );
}
