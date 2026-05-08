import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../widgets/settings_card.dart';

class LanguageRegionScreen extends StatefulWidget {
  const LanguageRegionScreen({super.key});

  @override
  State<LanguageRegionScreen> createState() => _LanguageRegionScreenState();
}

class _LanguageRegionScreenState extends State<LanguageRegionScreen> {
  String _selectedLanguage = 'Tiếng Việt';
  String _selectedTimezone = 'Giờ Việt Nam (ICT) UTC+7';

  final List<String> _timezones = [
    'Giờ Việt Nam (ICT) UTC+7',
    'Giờ London (GMT) UTC+0',
    'Giờ New York (EST) UTC-5',
    'Giờ Tokyo (JST) UTC+9',
    'Giờ Singapore (SGT) UTC+8',
  ];

  void _showTimezonePicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
      builder: (context) => Container(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chọn Múi giờ', style: AppTextStyles.bodyMediumBold),
            SizedBox(height: 16.h),
            ..._timezones.map((tz) => ListTile(
              title: Text(tz, style: AppTextStyles.bodySmall),
              trailing: _selectedTimezone == tz ? Icon(Icons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() => _selectedTimezone = tz);
                Navigator.pop(context);
              },
            )),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Ngôn ngữ & Vùng'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(AppDimensions.screenPaddingH),
              children: [
                SettingsCard(
                  title: 'CHỌN NGÔN NGỮ',
                  children: [
                    _buildLanguageItem('Tiếng Việt', 'Tiếng Việt - Việt Nam'),
                    const Divider(height: 1),
                    _buildLanguageItem('English', 'English - United States'),
                    const Divider(height: 1),
                    _buildLanguageItem('Tiếng Nhật', '日本語 - Japan'),
                    const Divider(height: 1),
                    _buildLanguageItem('Tiếng Hàn', '한국어 - Korea'),
                    const Divider(height: 1),
                    _buildLanguageItem('Tiếng Trung', '中文 - China'),
                    const Divider(height: 1),
                    _buildLanguageItem('Tiếng Pháp', 'Français - France'),
                    const Divider(height: 1),
                    _buildLanguageItem('Tiếng Đức', 'Deutsch - Germany'),
                  ],
                ),
                SizedBox(height: 24.h),
                SettingsCard(
                  title: 'MÚI GIỜ',
                  children: [
                    InkWell(
                      onTap: _showTimezonePicker,
                      borderRadius: BorderRadius.circular(16.r),
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_selectedTimezone, style: AppTextStyles.bodyMediumBold),
                                  Text('Tự động theo thiết bị', style: AppTextStyles.caption),
                                ],
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textHint, size: 24.r),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppDimensions.screenPaddingH),
            child: SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã cập nhật cài đặt ngôn ngữ & vùng!')),
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
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10.h),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(String name, String sub) {
    bool isSelected = _selectedLanguage == name;
    return ListTile(
      title: Text(name, style: AppTextStyles.bodyMediumBold),
      subtitle: Text(sub, style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
      trailing: isSelected 
        ? Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 24.r) 
        : null,
      onTap: () {
        setState(() {
          _selectedLanguage = name;
        });
      },
    );
  }
}
