/// forgot_password_screen.dart
/// Màn hình Quên mật khẩu - nhập email để nhận link reset
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();
  bool _isLoading = false;
  bool _sent = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    if (_emailCtrl.text.isEmpty) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _isLoading = false;
        _sent = true;
      });
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
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(Icons.arrow_back_ios_new_rounded, size: 22.r),
                ),

                SizedBox(height: 48.h),

                // Icon
                Center(
                  child: Container(
                    width: 80.r,
                    height: 80.r,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _sent ? Icons.mark_email_read_outlined : Icons.lock_reset_rounded,
                      color: AppColors.primary,
                      size: 38.r,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                Center(
                  child: Text(
                    _sent ? 'Kiểm tra email!' : 'Quên mật khẩu?',
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 10.h),

                Center(
                  child: Text(
                    _sent
                        ? 'Chúng tôi đã gửi link đặt lại mật khẩu đến\n${_emailCtrl.text}'
                        : 'Nhập email của bạn và chúng tôi sẽ gửi\nlink để đặt lại mật khẩu',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 36.h),

                if (!_sent) ...[
                  CGTextField(
                    label: 'Email',
                    hint: 'email@example.com',
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 28.h),
                  CGButton(
                    label: 'Gửi link đặt lại',
                    onPressed: _handleSend,
                    isLoading: _isLoading,
                  ),
                ] else ...[
                  CGButton(
                    label: 'Về trang đăng nhập',
                    onPressed: () => context.go(AppRoutePaths.login),
                  ),
                ],

                SizedBox(height: 16.h),

                Center(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    child: Text('← Quay lại đăng nhập', style: AppTextStyles.link),
                  ),
                ),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
