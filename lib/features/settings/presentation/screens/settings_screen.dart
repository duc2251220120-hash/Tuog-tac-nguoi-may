import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/route_paths.dart';
import '../widgets/settings_tile.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cài đặt'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          SettingsHeader(
            name: 'Nguyễn Văn Bảo',
            role: 'Senior Frontend Developer · FPT Software',
            onViewProfile: () => context.push(AppRoutePaths.profile),
          ),
          SizedBox(height: 20.h),
          SettingsCard(
            children: [
              SettingsTile(
                icon: Icons.person_outline_rounded,
                iconColor: Colors.blue,
                iconBgColor: Colors.blue.withValues(alpha: 0.1),
                title: 'Tài khoản',
                subtitle: 'Email, mật khẩu, số điện thoại',
                onTap: () => context.push(AppRoutePaths.settingsAccount),
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.shield_outlined,
                iconColor: AppColors.success,
                iconBgColor: AppColors.successLight,
                title: 'Quyền riêng tư',
                subtitle: 'Ai có thể xem hồ sơ của bạn',
                onTap: () => context.push(AppRoutePaths.settingsPrivacy),
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.star_outline_rounded,
                iconColor: Colors.orange,
                iconBgColor: Colors.orange.withValues(alpha: 0.1),
                title: 'Tính năng khác',
                subtitle: 'Các tính năng nâng cao',
                onTap: () => context.push(AppRoutePaths.settingsFeatures),
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.notifications_none_rounded,
                iconColor: AppColors.warning,
                iconBgColor: AppColors.warningLight,
                title: 'Thông báo',
                subtitle: 'Cài đặt thông báo đẩy & email',
                onTap: () => context.push(AppRoutePaths.settingsNotifications),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SettingsCard(
            children: [
              SettingsTile(
                icon: Icons.language_rounded,
                iconColor: Colors.purple,
                iconBgColor: Colors.purple.withValues(alpha: 0.1),
                title: 'Ngôn ngữ & Vùng',
                subtitle: 'Tiếng Việt · Việt Nam',
                onTap: () => context.push(AppRoutePaths.settingsLanguage),
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.help_outline_rounded,
                iconColor: Colors.orange,
                iconBgColor: Colors.orange.withValues(alpha: 0.1),
                title: 'Trợ giúp & Hỗ trợ',
                subtitle: 'FAQ, liên hệ & báo cáo lỗi',
                onTap: () => context.push(AppRoutePaths.settingsHelp),
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.color_lens_outlined,
                iconColor: AppColors.primary,
                iconBgColor: AppColors.primaryLight,
                title: 'Giao diện',
                subtitle: 'Sáng / Tối',
                onTap: () => context.push(AppRoutePaths.settingsAppearance),
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.info_outline_rounded,
                iconColor: AppColors.textSecondary,
                iconBgColor: AppColors.surfaceLight,
                title: 'Gửi phản hồi',
                subtitle: 'Phiên bản 2.5.1',
                onTap: () => context.push(AppRoutePaths.settingsFeedback),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            children: [
              SettingsTile(
                icon: Icons.logout_rounded,
                title: 'Đăng xuất',
                isDestructive: true,
                trailing: const SizedBox.shrink(),
                onTap: () {
                  // TODO: To be implemented logout logic
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Đăng xuất'),
                      content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Hủy'),
                        ),
                        TextButton(
                          onPressed: () => context.go(AppRoutePaths.login),
                          child: const Text('Đăng xuất', style: TextStyle(color: AppColors.error)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
