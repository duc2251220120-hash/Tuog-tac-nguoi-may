/// login_screen.dart
/// Màn hình Đăng nhập - Pixel-perfect theo "Đăng Nhập.pdf"
/// Logo + "Chào mừng trở lại 👋" + Email/Phone + Password + Google/Facebook
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    // Giả lập network call
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _isLoading = false);
      context.go(AppRoutePaths.home);
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
                SizedBox(height: 24.h),

                // ─── Logo ────────────────────────────────────────────────
                Row(
                  children: [
                    Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.language_rounded,
                        color: AppColors.white,
                        size: 24.r,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text('Career Global', style: AppTextStyles.appTitle),
                  ],
                ),

                SizedBox(height: 36.h),

                // ─── Greeting ────────────────────────────────────────────
                Text(
                  'Chào mừng trở lại 👋',
                  style: AppTextStyles.h1,
                ),
                SizedBox(height: 6.h),
                Text(
                  'Đăng nhập để tiếp tục hành trình sự nghiệp',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(height: 32.h),

                // ─── Email/Phone Field ────────────────────────────────────
                CGTextField(
                  label: 'Email hoặc số điện thoại',
                  hint: 'nguyenvanbao@email.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Vui lòng nhập email hoặc số điện thoại';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                // ─── Password Field ───────────────────────────────────────
                CGTextField(
                  label: 'Mật khẩu',
                  hint: '••••••••',
                  controller: _passwordController,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleLogin(),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10.h),

                // ─── Quên mật khẩu ───────────────────────────────────────
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(AppRoutePaths.forgotPassword),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text('Quên mật khẩu?', style: AppTextStyles.link),
                  ),
                ),

                SizedBox(height: 26.h),

                // ─── Nút Đăng nhập ───────────────────────────────────────
                CGButton(
                  label: 'Đăng nhập',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),

                SizedBox(height: 24.h),

                // ─── OR Divider ───────────────────────────────────────────
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        'hoặc đăng nhập với',
                        style: AppTextStyles.caption,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                SizedBox(height: 20.h),

                // ─── Social Login ─────────────────────────────────────────
                Row(
                  children: [
                    // Google
                    Expanded(
                      child: CGSocialButton(
                        label: 'Google',
                        icon: Text('G', style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4285F4),
                        )),
                        onPressed: () {},
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // Facebook
                    Expanded(
                      child: CGSocialButton(
                        label: 'Facebook',
                        icon: Icon(
                          Icons.facebook_rounded,
                          color: const Color(0xFF1877F2),
                          size: 22.r,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // ─── Đăng ký ─────────────────────────────────────────────
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Chưa có tài khoản? ',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push(AppRoutePaths.register),
                        child: Text(
                          'Đăng ký ngay',
                          style: AppTextStyles.link.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
