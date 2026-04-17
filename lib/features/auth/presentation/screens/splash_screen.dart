/// splash_screen.dart
/// Màn hình chào Career Global - nền xanh với logo và tagline
/// Pixel-perfect theo thiết kế "Màn Hình Chào.pdf"
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    // Fade-in animation cho logo
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Slide-up animation cho buttons
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Bắt đầu animations theo thứ tự
    _fadeController.forward().then((_) {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySplash,
      body: Stack(
        children: [
          // ─── Background decorative circles ──────────────────────────────
          Positioned(
            top: -60.h,
            right: -40.w,
            child: Container(
              width: 200.r,
              height: 200.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: 80.h,
            left: -60.w,
            child: Container(
              width: 180.r,
              height: 180.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.06),
              ),
            ),
          ),

          // ─── Main Content ────────────────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.screenPaddingH,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top spacing
                      SizedBox(height: 80.h),

                      // Logo + Brand Name + Tagline (fade in)
                      FadeTransition(
                        opacity: _fadeAnim,
                        child: Column(
                          children: [
                            // Logo icon (white rounded square)
                            Container(
                              width: 100.r,
                              height: 100.r,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(24.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.language_rounded,
                                color: AppColors.primary,
                                size: 54.r,
                              ),
                            ),

                            SizedBox(height: 28.h),

                            // Tên ứng dụng
                            Text(
                              'Career Global',
                              style: AppTextStyles.splashTitle,
                            ),

                            SizedBox(height: 10.h),

                            // Tagline
                            Text(
                              'Kết nối sự nghiệp · Vươn tầm thế giới',
                              style: AppTextStyles.splashSubtitle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      // Buttons (slide up)
                      SlideTransition(
                        position: _slideAnim,
                        child: FadeTransition(
                          opacity: _slideController,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Column(
                              children: [
                                // Nút "Bắt đầu ngay" (trắng nền)
                                SizedBox(
                                  width: double.infinity,
                                  height: AppDimensions.buttonHeight,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        context.go(AppRoutePaths.onboarding),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.white,
                                      foregroundColor: AppColors.primary,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusFullPill,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Bắt đầu ngay',
                                      style: AppTextStyles.buttonSecondary,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 14.h),

                                // Nút "Đã có tài khoản? Đăng nhập" (outline trắng)
                                SizedBox(
                                  width: double.infinity,
                                  height: AppDimensions.buttonHeight,
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        context.go(AppRoutePaths.login),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: AppColors.white,
                                        width: 1.5,
                                      ),
                                      foregroundColor: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusFullPill,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Đã có tài khoản? Đăng nhập',
                                      style: AppTextStyles.buttonPrimary.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20.h),

                                // Copyright
                                Text(
                                  '© 2026 Career Global Inc.',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.white.withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
