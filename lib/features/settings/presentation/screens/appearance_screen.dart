import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../widgets/settings_card.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  String _selectedTheme = 'Sáng';
  String _selectedFontSize = 'Vừa';
  String _selectedLanguage = 'Tiếng Việt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Giao diện'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          SettingsCard(
            title: 'Chủ đề',
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    _buildThemeOption(Icons.light_mode_outlined, 'Sáng'),
                    SizedBox(width: 12.w),
                    _buildThemeOption(Icons.dark_mode_outlined, 'Tối'),
                    SizedBox(width: 12.w),
                    _buildThemeOption(Icons.settings_outlined, 'Tự động'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            title: 'Cỡ chữ',
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    _buildTextSizeOption('Nhỏ'),
                    SizedBox(width: 12.w),
                    _buildTextSizeOption('Vừa'),
                    SizedBox(width: 12.w),
                    _buildTextSizeOption('Lớn'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã cập nhật cài đặt giao diện!')),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
              ),
              child: Text('Lưu thay đổi', style: AppTextStyles.bodyMediumBold),
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildThemeOption(IconData icon, String label) {
    bool isSelected = _selectedTheme == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTheme = label),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ] : null,
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 24.r),
              SizedBox(height: 8.h),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextSizeOption(String label) {
    bool isSelected = _selectedFontSize == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedFontSize = label),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageTile(String name, String flag) {
    bool isSelected = _selectedLanguage == name;
    return ListTile(
      leading: Text(flag, style: TextStyle(fontSize: 20.sp)),
      title: Text(name, style: AppTextStyles.bodyMedium),
      trailing: isSelected
          ? Icon(Icons.check_rounded, color: AppColors.primary, size: 20.r)
          : null,
      onTap: () => setState(() => _selectedLanguage = name),
    );
  }
}
