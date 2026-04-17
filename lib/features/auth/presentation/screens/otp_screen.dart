/// otp_screen.dart
/// Màn hình Xác thực OTP - "Xác Thực Otp.pdf"
/// 6 ô nhập mã OTP + đếm ngược thời gian gửi lại
library;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../common/widgets/cg_button.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;
  int _countdown = 59; // đếm ngược giây
  Timer? _timer;
  String _otp = '';

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _countdown = 59);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_countdown == 0) {
        t.cancel();
      } else {
        setState(() => _countdown--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _handleVerify() async {
    if (_otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đủ 6 chữ số')),
      );
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _isLoading = false);
      context.go(AppRoutePaths.completeProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPaddingH,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // Back button
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 22.r,
                    color: AppColors.textPrimary,
                  ),
                ),

                SizedBox(height: 48.h),

                // ─── Phone icon (circle) ──────────────────────────────
                Center(
                  child: Container(
                    width: 80.r,
                    height: 80.r,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.smartphone_outlined,
                      color: AppColors.primary,
                      size: 38.r,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Tiêu đề
                Center(child: Text('Xác thực OTP', style: AppTextStyles.h2)),

                SizedBox(height: 10.h),

                // Mô tả
                Center(
                  child: Text(
                    'Mã 6 chữ số đã được gửi đến',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    widget.phoneNumber.isEmpty
                        ? '+84 900 123 456'
                        : widget.phoneNumber,
                    style: AppTextStyles.bodyMediumBold,
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 36.h),

                // ─── OTP Pin Input (6 ô) ──────────────────────────────
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: _otpController,
                  onChanged: (v) => _otp = v,
                  onCompleted: (_) => _handleVerify(),
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  animationDuration: const Duration(milliseconds: 200),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(AppDimensions.otpBoxRadius),
                    fieldHeight: AppDimensions.otpBoxSize,
                    fieldWidth: AppDimensions.otpBoxSize,
                    activeFillColor: AppColors.primaryLight,
                    inactiveFillColor: AppColors.surfaceLight,
                    selectedFillColor: AppColors.primaryLight,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.border,
                    selectedColor: AppColors.primary,
                    borderWidth: 1.5,
                  ),
                  enableActiveFill: true,
                  textStyle: AppTextStyles.h3.copyWith(
                    color: AppColors.primary,
                  ),
                  cursorColor: AppColors.primary,
                ),

                SizedBox(height: 28.h),

                // ─── Nút Xác nhận ────────────────────────────────────
                CGButton(
                  label: 'Xác nhận',
                  onPressed: _handleVerify,
                  isLoading: _isLoading,
                ),

                SizedBox(height: 20.h),

                // ─── Gửi lại OTP ─────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Không nhận được mã?',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      _countdown > 0
                          ? Text(
                              'Gửi lại sau ${_countdown}s',
                              style: AppTextStyles.link,
                            )
                          : GestureDetector(
                              onTap: _startCountdown,
                              child: Text(
                                'Gửi lại mã',
                                style: AppTextStyles.link,
                              ),
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
