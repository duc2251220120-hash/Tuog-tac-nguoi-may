/// onboarding_screen.dart
/// Màn hình giới thiệu tính năng ứng dụng (3 slides)
/// Pixel-perfect theo thiết kế "Giới Thiệu 1-2-3.pdf"
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';

/// Dữ liệu của từng slide onboarding
class _OnboardingData {
  final String emoji;
  final String title;
  final String subtitle;
  final Color bgColor;
  final Color textColor;

  const _OnboardingData({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.textColor,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const List<_OnboardingData> _slides = [
    _OnboardingData(
      emoji: '🌍',
      title: 'Tìm việc làm toàn cầu',
      subtitle:
          'Khám phá hàng nghìn cơ hội việc làm từ các công ty hàng đầu trong và ngoài nước',
      bgColor: Color(0xFFEBF2FF),
      textColor: AppColors.primary,
    ),
    _OnboardingData(
      emoji: '🤝',
      title: 'Kết nối chuyên nghiệp',
      subtitle:
          'Xây dựng mạng lưới kết nối với các chuyên gia hàng đầu trong ngành của bạn',
      bgColor: Color(0xFFF0FFF4),
      textColor: AppColors.success,
    ),
    _OnboardingData(
      emoji: '🚀',
      title: 'Phát triển sự nghiệp',
      subtitle:
          'Học hỏi từ mentor, tham gia khóa học và sự kiện nghề nghiệp chuyên nghiệp',
      bgColor: Color(0xFFF5F3FF),
      textColor: AppColors.purpleLight,
    ),
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(AppRoutePaths.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Nút "Bỏ qua" ở góc trên phải
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => context.go(AppRoutePaths.login),
                child: Text(
                  'Bỏ qua',
                  style: AppTextStyles.bodySmall,
                ),
              ),
            ),

            // Nội dung slides (chiếm phần lớn không gian)
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _slides.length,
                itemBuilder: (_, index) =>
                    _OnboardingPage(data: _slides[index]),
              ),
            ),

            // Indicator dots + nút Tiếp theo
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.screenPaddingH,
                vertical: 24.h,
              ),
              child: Column(
                children: [
                  // Page indicator dots
                  SmoothPageIndicator(
                    controller: _controller,
                    count: _slides.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.border,
                      dotHeight: 8.h,
                      dotWidth: 8.w,
                      expansionFactor: 3,
                      spacing: 6,
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Nút Tiếp theo
                  SizedBox(
                    width: double.infinity,
                    height: AppDimensions.buttonHeight,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusFullPill,
                          ),
                        ),
                      ),
                      child: Text(
                        _currentPage < _slides.length - 1
                            ? 'Tiếp theo'
                            : 'Bắt đầu',
                        style: AppTextStyles.buttonPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget cho từng slide onboarding
class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive: kích thước illustration tùy chiều cao màn hình
        final illustrationSize = (constraints.maxHeight * 0.35).clamp(140.0, 240.0);
        final emojiSize = (illustrationSize * 0.35).clamp(40.0, 72.0);

        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenPaddingH),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),

                // Illustration box
                Container(
                  width: illustrationSize.r,
                  height: illustrationSize.r,
                  decoration: BoxDecoration(
                    color: data.bgColor,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data.emoji, style: TextStyle(fontSize: emojiSize.sp)),
                      SizedBox(height: 8.h),
                      Text(
                        _getEmojiLabel(data.emoji),
                        style: AppTextStyles.label.copyWith(color: data.textColor),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 36.h),

                // Tiêu đề
                Text(
                  data.title,
                  style: AppTextStyles.onboardingTitle,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 12.h),

                // Mô tả
                Text(
                  data.subtitle,
                  style: AppTextStyles.onboardingSubtitle,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getEmojiLabel(String emoji) {
    switch (emoji) {
      case '🌍':
        return 'Kết nối toàn cầu';
      case '🤝':
        return 'Mạng lưới chuyên nghiệp';
      case '🚀':
        return 'Phát triển sự nghiệp';
      default:
        return '';
    }
  }
}
