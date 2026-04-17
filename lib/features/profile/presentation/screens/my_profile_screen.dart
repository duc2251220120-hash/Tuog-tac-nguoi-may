/// my_profile_screen.dart - Tab Hồ sơ của chính mình (trong bottom nav)
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../common/widgets/cg_avatar.dart';
import '../../../../common/widgets/cg_button.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: AppDimensions.profileBannerHeight,
            pinned: true,
            backgroundColor: AppColors.purpleDark,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.purpleDark, AppColors.purpleLight],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => context.push(AppRoutePaths.settings),
                icon:
                    const Icon(Icons.settings_outlined, color: AppColors.white),
              ),
              IconButton(
                onPressed: () => context.push(AppRoutePaths.editProfile),
                icon: const Icon(Icons.edit_outlined, color: AppColors.white),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.screenPaddingH),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CGAvatar(
                            name: 'Huy Đức',
                            size: AppDimensions.avatarXL,
                            backgroundColor: AppColors.avatarBlue),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nguyễn Huy Đức', style: AppTextStyles.h3),
                              Text('Flutter Developer',
                                  style: AppTextStyles.bodySmall),
                              Text('TP.Đà Nẵng', style: AppTextStyles.caption),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        _StatItem(value: '128', label: 'Kết nối'),
                        _Divider(),
                        _StatItem(value: '12', label: 'Bài viết'),
                        _Divider(),
                        _StatItem(value: '56', label: 'Đã xem'),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    CGButton(
                      label: 'Chỉnh sửa hồ sơ',
                      type: CGButtonType.outline,
                      onPressed: () => context.push(AppRoutePaths.editProfile),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 8.h),
                _MenuSection(title: 'Nghề nghiệp', items: [
                  _MenuItem(
                      icon: Icons.work_outline_rounded,
                      label: 'Việc đã ứng tuyển',
                      onTap: () => context.push(AppRoutePaths.appliedJobs)),
                  _MenuItem(
                      icon: Icons.bookmark_outline_rounded,
                      label: 'Việc đã lưu',
                      onTap: () => context.push(AppRoutePaths.savedJobs)),
                  _MenuItem(
                      icon: Icons.analytics_outlined,
                      label: 'Phân tích hồ sơ',
                      onTap: () => context.push(AppRoutePaths.analytics)),
                  _MenuItem(
                      icon: Icons.description_outlined,
                      label: 'CV của tôi',
                      onTap: () => context.push(AppRoutePaths.cv)),
                ]),
                SizedBox(height: 8.h),
                _MenuSection(title: 'Cài đặt', items: [
                  _MenuItem(
                      icon: Icons.settings_outlined,
                      label: 'Cài đặt tài khoản',
                      onTap: () => context.push(AppRoutePaths.settings)),
                  _MenuItem(
                      icon: Icons.help_outline_rounded,
                      label: 'Trợ giúp',
                      onTap: () => context.push(AppRoutePaths.guide)),
                  _MenuItem(
                      icon: Icons.logout_rounded,
                      label: 'Đăng xuất',
                      onTap: () => context.go(AppRoutePaths.login),
                      isDestructive: true),
                ]),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: AppTextStyles.h3.copyWith(color: AppColors.primary)),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 30.h, color: AppColors.border);
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;
  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
            child: Text(title,
                style: AppTextStyles.label.copyWith(color: AppColors.textHint)),
          ),
          ...items,
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isDestructive;

  const _MenuItem(
      {required this.icon,
      required this.label,
      this.onTap,
      this.isDestructive = false});

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textPrimary;
    return ListTile(
      onTap: onTap,
      leading: Icon(icon,
          color: isDestructive ? AppColors.error : AppColors.textSecondary,
          size: 22.r),
      title:
          Text(label, style: AppTextStyles.bodyMedium.copyWith(color: color)),
      trailing: Icon(Icons.chevron_right_rounded,
          color: AppColors.textHint, size: 20.r),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
    );
  }
}
