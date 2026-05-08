import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;

  const SettingsTile({
    super.key,
    required this.icon,
    this.iconColor = AppColors.primary,
    this.iconBgColor = AppColors.primaryLight,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: Container(
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(
          color: isDestructive ? AppColors.errorLight : iconBgColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          color: isDestructive ? AppColors.error : iconColor,
          size: 22.r,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMediumBold.copyWith(
          color: isDestructive ? AppColors.error : AppColors.textPrimary,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            )
          : null,
      trailing: trailing ??
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textHint,
            size: 20.r,
          ),
    );
  }
}
