import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_tile.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _twoFactor = false;
  bool _biometric = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Bảo mật'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          // Security Level Indicator
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 64.r,
                      height: 64.r,
                      child: CircularProgressIndicator(
                        value: 0.75,
                        strokeWidth: 8,
                        backgroundColor: AppColors.success.withValues(alpha: 0.1),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Text(
                      '75%',
                      style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.success),
                    ),
                  ],
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mức bảo mật: Tốt', style: AppTextStyles.bodyMediumBold),
                      SizedBox(height: 4.h),
                      Text(
                        'Bật 2FA để tăng lên Xuất sắc',
                        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          SettingsCard(
            children: [
              SwitchListTile.adaptive(
                value: _twoFactor,
                onChanged: (v) => setState(() => _twoFactor = v),
                activeColor: AppColors.primary,
                title: Text('Xác thực 2 bước (2FA)', style: AppTextStyles.bodyMediumBold),
                subtitle: Text('Thêm lớp bảo vệ cho tài khoản', style: AppTextStyles.caption),
              ),
              const Divider(height: 1),
              SwitchListTile.adaptive(
                value: _biometric,
                onChanged: (v) => setState(() => _biometric = v),
                activeColor: AppColors.primary,
                title: Text('Đăng nhập sinh trắc học', style: AppTextStyles.bodyMediumBold),
                subtitle: Text('Dùng vân tay / Face ID', style: AppTextStyles.caption),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          SettingsCard(
            title: 'Đổi mật khẩu',
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    const _PasswordField(label: 'Mật khẩu hiện tại'),
                    SizedBox(height: 16.h),
                    const _PasswordField(label: 'Mật khẩu mới'),
                    SizedBox(height: 16.h),
                    const _PasswordField(label: 'Xác nhận mật khẩu mới'),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        ),
                        child: const Text('Cập nhật mật khẩu'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          SettingsCard(
            title: 'Phiên đăng nhập',
            children: [
              _buildDeviceTile(
                icon: Icons.phone_android_rounded,
                name: 'iPhone 15 Pro',
                location: 'TP. Hồ Chí Minh',
                time: 'Hiện tại',
                isCurrent: true,
              ),
              const Divider(height: 1),
              _buildDeviceTile(
                icon: Icons.laptop_mac_rounded,
                name: 'MacBook Pro',
                location: 'TP. Hồ Chí Minh',
                time: '2 giờ trước',
              ),
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }


  Widget _buildDeviceTile({
    required IconData icon,
    required String name,
    required String location,
    required String time,
    bool isCurrent = false,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10.r)),
        child: Icon(icon, color: AppColors.textPrimary, size: 24.r),
      ),
      title: Row(
        children: [
          Text(name, style: AppTextStyles.bodyMediumBold),
          if (isCurrent) ...[
            SizedBox(width: 8.w),
            Text(
              'Thiết bị này',
              style: AppTextStyles.caption.copyWith(color: AppColors.success, fontWeight: FontWeight.w600),
            ),
          ],
        ],
      ),
      subtitle: Text('$location \u2022 $time', style: AppTextStyles.caption),
      trailing: isCurrent 
        ? null 
        : Text('Đăng xuất', style: AppTextStyles.caption.copyWith(color: AppColors.error)),
      onTap: () {},
    );
  }
}

class _PasswordField extends StatefulWidget {
  final String label;
  const _PasswordField({required this.label});

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: AppTextStyles.caption,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.textHint,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }
}
