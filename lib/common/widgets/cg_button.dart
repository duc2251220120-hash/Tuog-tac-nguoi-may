/// cg_button.dart
/// Widget nút bấm tái sử dụng cho toàn ứng dụng Career Global
/// Hỗ trợ: Primary (xanh đậm), Secondary (trắng viền xanh), Outline, Social, Icon
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';

/// Enum phân loại kiểu nút
enum CGButtonType { primary, secondary, outline, ghost, danger }

class CGButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final CGButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final double? width;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CGButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = CGButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height ?? AppDimensions.buttonHeight,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (type) {
      case CGButtonType.primary:
        return _PrimaryButton(
          label: label,
          onPressed: isLoading ? null : onPressed,
          isLoading: isLoading,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        );
      case CGButtonType.secondary:
        return _SecondaryButton(
          label: label,
          onPressed: isLoading ? null : onPressed,
          isLoading: isLoading,
        );
      case CGButtonType.outline:
        return _OutlineButton(
          label: label,
          onPressed: isLoading ? null : onPressed,
          prefixIcon: prefixIcon,
        );
      case CGButtonType.ghost:
        return _GhostButton(
          label: label,
          onPressed: onPressed,
        );
      case CGButtonType.danger:
        return _DangerButton(
          label: label,
          onPressed: onPressed,
        );
    }
  }
}

// ─── Primary Button (Xanh đậm - dùng cho CTA chính) ────────────────────────
class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const _PrimaryButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusFullPill),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 22.r,
              height: 22.r,
              child: const CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2.5,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  SizedBox(width: 8.w),
                ],
                Text(label, style: AppTextStyles.buttonPrimary),
                if (suffixIcon != null) ...[
                  SizedBox(width: 8.w),
                  suffixIcon!,
                ],
              ],
            ),
    );
  }
}

// ─── Secondary Button (Trắng nền, viền xanh) ────────────────────────────────
class _SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const _SecondaryButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusFullPill),
        ),
        backgroundColor: AppColors.white,
      ),
      child: isLoading
          ? SizedBox(
              width: 22.r,
              height: 22.r,
              child: const CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2.5,
              ),
            )
          : Text(label, style: AppTextStyles.buttonSecondary),
    );
  }
}

// ─── Outline Button (dùng cho nút phụ) ──────────────────────────────────────
class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? prefixIcon;

  const _OutlineButton({
    required this.label,
    this.onPressed,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.border, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusFullPill),
        ),
        foregroundColor: AppColors.textPrimary,
        backgroundColor: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefixIcon != null) ...[
            prefixIcon!,
            SizedBox(width: 8.w),
          ],
          Text(
            label,
            style: AppTextStyles.buttonSecondary.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Ghost Button (không có border, text xanh) ──────────────────────────────
class _GhostButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _GhostButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label, style: AppTextStyles.link),
    );
  }
}

// ─── Danger Button (nút đỏ - xóa, hủy) ─────────────────────────────────────
class _DangerButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _DangerButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusFullPill),
        ),
      ),
      child: Text(label, style: AppTextStyles.buttonPrimary),
    );
  }
}

// ─── Social Button (Google / Facebook) ──────────────────────────────────────
class CGSocialButton extends StatelessWidget {
  final String label;
  final String? iconPath;
  final Widget? icon;
  final VoidCallback? onPressed;

  const CGSocialButton({
    super.key,
    required this.label,
    this.iconPath,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusFullPill),
          ),
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.textPrimary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 8.w),
            ],
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Small Tag Button (Filter chips) ─────────────────────────────────────────
class CGTagButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const CGTagButton({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusFullPill),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.label.copyWith(
            color: isSelected ? AppColors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
