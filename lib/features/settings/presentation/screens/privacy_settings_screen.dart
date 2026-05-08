import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/route_paths.dart';
import 'package:go_router/go_router.dart';
import '../widgets/settings_tile.dart';
import '../widgets/settings_card.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _showEmail = false;
  bool _showPhone = false;
  bool _allowStrangersLine = true;
  bool _personalizeAds = true;
  String _profileVisibility = 'Tất cả mọi người';
  String _connectionsVisibility = 'Kết nối';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Quyền riêng tư'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          SettingsCard(
            title: 'Hiển thị hồ sơ',
            children: [
              SettingsTile(
                icon: Icons.visibility_outlined,
                title: 'Ai có thể xem hồ sơ của bạn',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_profileVisibility, style: AppTextStyles.linkSmall),
                    Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary, size: 20.r),
                  ],
                ),
                onTap: () => _showVisibilitySelection(
                  context: context,
                  title: 'Ai có thể xem hồ sơ của bạn',
                  currentValue: _profileVisibility,
                  options: ['Tất cả mọi người', 'Chỉ kết nối', 'Chỉ mình tôi'],
                  onSelected: (value) => setState(() => _profileVisibility = value),
                ),
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.people_outline_rounded,
                title: 'Ai có thể xem danh sách kết nối',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_connectionsVisibility, style: AppTextStyles.linkSmall),
                    Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary, size: 20.r),
                  ],
                ),
                onTap: () => _showVisibilitySelection(
                  context: context,
                  title: 'Ai có thể xem danh sách kết nối',
                  currentValue: _connectionsVisibility,
                  options: ['Tất cả mọi người', 'Kết nối', 'Chỉ mình tôi'],
                  onSelected: (value) => setState(() => _connectionsVisibility = value),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            title: 'Thông tin liên hệ',
            children: [
              _buildSwitchTile(
                title: 'Hiển thị email với kết nối',
                value: _showEmail,
                onChanged: (v) => setState(() => _showEmail = v),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                title: 'Hiển thị số điện thoại',
                value: _showPhone,
                onChanged: (v) => setState(() => _showPhone = v),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                title: 'Cho phép nhắn tin từ người lạ',
                value: _allowStrangersLine,
                onChanged: (v) => setState(() => _allowStrangersLine = v),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            title: 'Dữ liệu và Quảng cáo',
            children: [
              _buildSwitchTile(
                title: 'Cá nhân hóa quảng cáo',
                subtitle: 'Sử dụng dữ liệu để cải thiện trải nghiệm',
                value: _personalizeAds,
                onChanged: (v) => setState(() => _personalizeAds = v),
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.security_rounded,
                title: 'Dữ liệu & Bảo mật',
                subtitle: 'Quản lý kho lưu trữ dữ liệu cá nhân',
                onTap: () {
                  context.push(AppRoutePaths.settingsData);
                },
              ),
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: subtitle != null ? 8.h : 0),
      title: Text(title, style: AppTextStyles.bodyMedium),
      subtitle: subtitle != null
          ? Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary))
          : null,
    );
  }

  void _showVisibilitySelection({
    required BuildContext context,
    required String title,
    required String currentValue,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Text(title, style: AppTextStyles.h4),
              ),
              const Divider(height: 1),
              ...options.map((option) {
                return ListTile(
                  title: Text(
                    option,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: option == currentValue ? AppColors.primary : AppColors.textPrimary,
                      fontWeight: option == currentValue ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  trailing: option == currentValue
                      ? Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 24.r)
                      : null,
                  onTap: () {
                    onSelected(option);
                    Navigator.pop(context);
                  },
                );
              }),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }
}
