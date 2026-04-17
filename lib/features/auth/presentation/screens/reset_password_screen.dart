/// reset_password_screen.dart
/// Màn hình Đặt lại mật khẩu - "Đặt Lại Mật Khẩu.pdf"
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../common/widgets/cg_button.dart';
import '../../../../common/widgets/cg_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _newPasswordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    if (_newPasswordCtrl.text.isEmpty || _confirmCtrl.text.isEmpty) return;
    if (_newPasswordCtrl.text != _confirmCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu không khớp')),
      );
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _isLoading = false);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_rounded,
                  color: AppColors.success, size: 64.r),
              SizedBox(height: 16.h),
              Text('Thành công!', style: AppTextStyles.h3, textAlign: TextAlign.center),
              SizedBox(height: 8.h),
              Text(
                'Mật khẩu của bạn đã được đặt lại thành công',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            CGButton(
              label: 'Đăng nhập',
              onPressed: () {
                Navigator.pop(context);
                context.go(AppRoutePaths.login);
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenPaddingH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () => context.pop(),
                child: Icon(Icons.arrow_back_ios_new_rounded, size: 22.r),
              ),
              SizedBox(height: 32.h),
              Text('Đặt lại mật khẩu', style: AppTextStyles.h1),
              SizedBox(height: 8.h),
              Text(
                'Tạo mật khẩu mới cho tài khoản của bạn',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: 32.h),
              CGTextField(
                label: 'Mật khẩu mới',
                hint: 'Tối thiểu 8 ký tự',
                controller: _newPasswordCtrl,
                isPassword: true,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 16.h),
              CGTextField(
                label: 'Xác nhận mật khẩu mới',
                hint: 'Nhập lại mật khẩu',
                controller: _confirmCtrl,
                isPassword: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _handleReset(),
              ),
              SizedBox(height: 32.h),
              CGButton(
                label: 'Xác nhận',
                onPressed: _handleReset,
                isLoading: _isLoading,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
