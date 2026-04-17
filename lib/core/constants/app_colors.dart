/// app_colors.dart
/// Bảng màu sắc toàn cục của ứng dụng Career Global
/// Tất cả màu được trích xuất từ file thiết kế PDF
library;

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Primary Blue (màu chủ đạo) ───────────────────────────────────────────
  static const Color primary = Color(0xFF1B6FD8);
  static const Color primaryDark = Color(0xFF1557B0);
  static const Color primaryLight = Color(0xFFEBF2FF);
  static const Color primarySplash = Color(0xFF1565C0); // Splash screen bg

  // ─── Background ────────────────────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surfaceLight = Color(0xFFF8FAFC);

  // ─── Text ──────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textDisabled = Color(0xFFD1D5DB);
  static const Color textLink = Color(0xFF1B6FD8);

  // ─── Border / Divider ──────────────────────────────────────────────────────
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF3F4F6);

  // ─── Status Colors ─────────────────────────────────────────────────────────
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color info = Color(0xFF3B82F6);

  // ─── Profile / Avatar Gradient ─────────────────────────────────────────────
  static const Color purpleDark = Color(0xFF6D28D9);
  static const Color purpleLight = Color(0xFF8B5CF6);

  // ─── Story / Avatar Circle Colors ──────────────────────────────────────────
  static const Color avatarPurple = Color(0xFF9333EA);
  static const Color avatarGreen = Color(0xFF10B981);
  static const Color avatarPink = Color(0xFFEC4899);
  static const Color avatarYellow = Color(0xFFF59E0B);
  static const Color avatarBlue = Color(0xFF3B82F6);
  static const Color avatarRed = Color(0xFFEF4444);
  static const Color avatarOrange = Color(0xFFF97316);
  static const Color avatarTeal = Color(0xFF14B8A6);

  // ─── Job Tag Colors ────────────────────────────────────────────────────────
  static const Color tagFullTime = Color(0xFFEBF2FF);   // bg
  static const Color tagFullTimeText = Color(0xFF1B6FD8);
  static const Color tagRemote = Color(0xFFD1FAE5);
  static const Color tagRemoteText = Color(0xFF10B981);
  static const Color tagPartTime = Color(0xFFFEF3C7);
  static const Color tagPartTimeText = Color(0xFFF59E0B);
  static const Color tagUrgent = Color(0xFFFEE2E2);
  static const Color tagUrgentText = Color(0xFFEF4444);

  // ─── Shadow ────────────────────────────────────────────────────────────────
  static const Color shadow = Color(0x14000000); // 8% opacity
  static const Color shadowMedium = Color(0x1F000000); // 12% opacity

  // ─── Bottom Nav ────────────────────────────────────────────────────────────
  static const Color navActive = Color(0xFF1B6FD8);
  static const Color navInactive = Color(0xFF9CA3AF);
}
