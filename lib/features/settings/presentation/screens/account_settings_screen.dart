import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_paths.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_tile.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cài đặt tài khoản'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          SettingsCard(
            title: 'Thông tin cá nhân',
            children: [
              _buildInfoTile(
                icon: Icons.person_outline_rounded,
                label: 'Tên đầy đủ',
                value: 'Nguyễn Văn Bảo',
                onTap: () => context.push(AppRoutePaths.settingsEditProfile),
              ),
              const Divider(height: 1),
              _buildInfoTile(
                icon: Icons.email_outlined,
                label: 'Email',
                value: 'nvbao@email.com',
                onTap: () => context.push(AppRoutePaths.settingsEditProfile),
              ),
              const Divider(height: 1),
              _buildInfoTile(
                icon: Icons.phone_outlined,
                label: 'Số điện thoại',
                value: '+84 912 345 678',
                onTap: () => context.push(AppRoutePaths.settingsEditProfile),
              ),
              const Divider(height: 1),
              _buildInfoTile(
                icon: Icons.location_on_outlined,
                label: 'Địa chỉ',
                value: 'TP. Hồ Chí Minh',
                onTap: () => context.push(AppRoutePaths.settingsEditProfile),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            title: 'Bảo mật',
            children: [
              SettingsTile(
                icon: Icons.lock_outline_rounded,
                title: 'Đổi mật khẩu',
                subtitle: 'Cập nhật lần cuối: 3 tháng trước',
                onTap: () => context.push(AppRoutePaths.settingsSecurity),
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.shield_outlined,
                title: 'Xác thực 2 bước',
                subtitle: 'Chưa bật',
                onTap: () => context.push(AppRoutePaths.settingsSecurity),
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.devices_rounded,
                title: 'Phiên đăng nhập',
                subtitle: '2 thiết bị đang hoạt động',
                onTap: () => context.push(AppRoutePaths.settingsSecurity),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            title: 'Vùng nguy hiểm',
            children: [
              SettingsTile(
                icon: Icons.pause_circle_outline_rounded,
                title: 'Tạm dừng tài khoản',
                subtitle: 'Tạm thời ẩn hồ sơ của bạn',
                iconColor: AppColors.warning,
                iconBgColor: AppColors.warningLight,
                onTap: () {},
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.delete_outline_rounded,
                title: 'Xóa tài khoản',
                subtitle: 'Xóa vĩnh viễn tài khoản của bạn',
                isDestructive: true,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: Icon(icon, color: AppColors.textSecondary, size: 22.r),
      title: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Text(
          value,
          style: AppTextStyles.bodyMediumBold,
        ),
      ),
      trailing: Icon(
        Icons.edit_outlined,
        color: AppColors.textHint,
        size: 18.r,
      ),
      onTap: onTap ?? () {},
    );
  }
}
