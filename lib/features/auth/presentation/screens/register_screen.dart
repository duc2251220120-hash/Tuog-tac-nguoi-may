/// register_screen.dart
/// Màn hình Tạo tài khoản - Pixel-perfect theo "Đăng Kí.pdf"
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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lastNameCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  bool _agreedToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _lastNameCtrl.dispose();
    _firstNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng đồng ý với điều khoản dịch vụ'),
        ),
      );
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _isLoading = false);
      context.go(AppRoutePaths.otp, extra: _phoneCtrl.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPaddingH,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // ─── Back button ──────────────────────────────────────────
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 22.r,
                    color: AppColors.textPrimary,
                  ),
                ),

                SizedBox(height: 24.h),

                // ─── Title ────────────────────────────────────────────────
                Text('Tạo tài khoản', style: AppTextStyles.h1),
                SizedBox(height: 6.h),
                Text(
                  'Hãy bắt đầu hành trình sự nghiệp của bạn',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(height: 28.h),

                // ─── Họ + Tên (2 cột) ─────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: CGTextField(
                        label: 'Họ',
                        hint: 'Nguyễn',
                        controller: _lastNameCtrl,
                        textInputAction: TextInputAction.next,
                        validator: (v) =>
                            v?.isEmpty == true ? 'Nhập họ' : null,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CGTextField(
                        label: 'Tên',
                        hint: 'Văn Bảo',
                        controller: _firstNameCtrl,
                        textInputAction: TextInputAction.next,
                        validator: (v) =>
                            v?.isEmpty == true ? 'Nhập tên' : null,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Email
                CGTextField(
                  label: 'Email',
                  hint: 'email@example.com',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v?.isEmpty == true) return 'Nhập email';
                    if (!v!.contains('@')) return 'Email không hợp lệ';
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                // Số điện thoại
                CGTextField(
                  label: 'Số điện thoại',
                  hint: '+84 900 000 000',
                  controller: _phoneCtrl,
                  isPhone: true,
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                      v?.isEmpty == true ? 'Nhập số điện thoại' : null,
                ),

                SizedBox(height: 16.h),

                // Mật khẩu
                CGTextField(
                  label: 'Mật khẩu',
                  hint: 'Tối thiểu 8 ký tự',
                  controller: _passwordCtrl,
                  isPassword: true,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v?.isEmpty == true) return 'Nhập mật khẩu';
                    if (v!.length < 8) return 'Mật khẩu tối thiểu 8 ký tự';
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                // Xác nhận mật khẩu
                CGTextField(
                  label: 'Xác nhận mật khẩu',
                  hint: 'Nhập lại mật khẩu',
                  controller: _confirmPasswordCtrl,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleRegister(),
                  validator: (v) {
                    if (v != _passwordCtrl.text) {
                      return 'Mật khẩu không khớp';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.h),

                // ─── Terms & Conditions checkbox ──────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 22.r,
                      height: 22.r,
                      child: Checkbox(
                        value: _agreedToTerms,
                        onChanged: (v) =>
                            setState(() => _agreedToTerms = v ?? false),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        activeColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.border, width: 1.5),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            const TextSpan(text: 'Tôi đồng ý với '),
                            TextSpan(
                              text: 'Điều khoản dịch vụ',
                              style: AppTextStyles.linkSmall,
                            ),
                            const TextSpan(text: ' và '),
                            TextSpan(
                              text: 'Chính sách quyền riêng tư',
                              style: AppTextStyles.linkSmall,
                            ),
                            const TextSpan(text: ' của Career Global'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28.h),

                // ─── Nút Đăng ký ─────────────────────────────────────────
                CGButton(
                  label: 'Đăng ký',
                  onPressed: _handleRegister,
                  isLoading: _isLoading,
                ),

                SizedBox(height: 20.h),

                // ─── Đã có tài khoản? ─────────────────────────────────────
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Đã có tài khoản? ',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.go(AppRoutePaths.login),
                        child: Text('Đăng nhập', style: AppTextStyles.link),
                      ),
                    ],
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
