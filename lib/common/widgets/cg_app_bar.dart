/// cg_app_bar.dart
/// Custom AppBar tái sử dụng cho Career Global
/// Hỗ trợ: back button, title, actions, logo bar (home)
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';

// ─── Standard AppBar với back button ─────────────────────────────────────────
class CGAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final VoidCallback? onBack;
  final Color backgroundColor;
  final Color titleColor;
  final Widget? leading;

  const CGAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
    this.onBack,
    this.backgroundColor = AppColors.white,
    this.titleColor = AppColors.textPrimary,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleSpacing: 0,
      systemOverlayStyle: backgroundColor == AppColors.white
          ? const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            )
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
      // Leading: back button hoặc custom
      leading: showBack
          ? (leading ??
              IconButton(
                onPressed: onBack ?? () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20.r,
                  color: titleColor,
                ),
              ))
          : const SizedBox.shrink(),
      title: Text(
        title,
        style: AppTextStyles.h4.copyWith(color: titleColor),
        overflow: TextOverflow.ellipsis,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppDimensions.appBarHeight);
}

// ─── Home AppBar (logo + icons) ───────────────────────────────────────────────
class CGHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int notificationCount;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAddTap;

  const CGHomeAppBar({
    super.key,
    this.notificationCount = 0,
    this.onSearchTap,
    this.onNotificationTap,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleSpacing: 16.w,
      // Logo "Career Global"
      title: Row(
        children: [
          Container(
            width: 34.r,
            height: 34.r,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.language_rounded,
              color: AppColors.white,
              size: 20.r,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Career Global',
              style: AppTextStyles.appTitle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      // Action icons: search, notification (với badge), add
      actions: [
        IconButton(
          onPressed: onSearchTap,
          icon: Icon(
            Icons.search_rounded,
            color: AppColors.textPrimary,
            size: AppDimensions.iconLG,
          ),
        ),
        // Notification với badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: onNotificationTap,
              icon: Icon(
                Icons.notifications_outlined,
                color: AppColors.textPrimary,
                size: AppDimensions.iconLG,
              ),
            ),
            if (notificationCount > 0)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  width: 18.r,
                  height: 18.r,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      notificationCount > 9 ? '9+' : '$notificationCount',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        IconButton(
          onPressed: onAddTap,
          icon: Icon(
            Icons.add_circle_outline_rounded,
            color: AppColors.textPrimary,
            size: AppDimensions.iconLG,
          ),
        ),
        SizedBox(width: 4.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppDimensions.appBarHeight);
}

// ─── Transparent AppBar (dùng cho profile, event detail) ─────────────────────
class CGTransparentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final Color iconColor;

  const CGTransparentAppBar({
    super.key,
    this.actions,
    this.onBack,
    this.iconColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: onBack ?? () => context.pop(),
        icon: Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.r,
            color: iconColor,
          ),
        ),
      ),
      leadingWidth: 56.w,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppDimensions.appBarHeight);
}
