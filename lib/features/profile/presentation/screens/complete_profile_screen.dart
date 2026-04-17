/// complete_profile_screen.dart
/// Màn hình Hoàn thành hồ sơ sau khi đăng ký - "Hoàn Thành Hồ Sơ.pdf"
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../common/widgets/cg_button.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content above buttons
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenPaddingH),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 48.h),

                    // Illustration
                    Center(
                      child: Container(
                        width: 160.r,
                        height: 160.r,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                        ),
                        child: Icon(Icons.person_add_rounded,
                            color: AppColors.primary, size: 70.r),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    Text('Hồ sơ của bạn\nđã được tạo! 🎉', style: AppTextStyles.h1),
                    SizedBox(height: 12.h),
                    Text(
                      'Hoàn thiện hồ sơ để tăng cơ hội được tuyển dụng lên đến 5 lần',
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),

                    SizedBox(height: 28.h),

                    // Steps checklist
                    _StepItem(
                      icon: Icons.person_outline_rounded,
                      title: 'Thông tin cá nhân',
                      subtitle: 'Họ tên, ảnh đại diện, giới thiệu',
                      isCompleted: true,
                    ),
                    _StepItem(
                      icon: Icons.work_outline_rounded,
                      title: 'Kinh nghiệm làm việc',
                      subtitle: 'Thêm vị trí và công ty bạn đã làm',
                    ),
                    _StepItem(
                      icon: Icons.school_outlined,
                      title: 'Học vấn',
                      subtitle: 'Trường, chuyên ngành, năm tốt nghiệp',
                    ),
                    _StepItem(
                      icon: Icons.star_outline_rounded,
                      title: 'Kỹ năng',
                      subtitle: 'Liệt kê các kỹ năng nổi bật của bạn',
                    ),

                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),

            // Fixed buttons at bottom
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimensions.screenPaddingH,
                8.h,
                AppDimensions.screenPaddingH,
                24.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CGButton(
                    label: 'Hoàn thiện hồ sơ',
                    onPressed: () => context.push(AppRoutePaths.editProfile),
                  ),
                  SizedBox(height: 12.h),
                  CGButton(
                    label: 'Để sau',
                    type: CGButtonType.ghost,
                    onPressed: () => context.go(AppRoutePaths.home),
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

class _StepItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isCompleted;

  const _StepItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: isCompleted ? AppColors.successLight : AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
            ),
            child: Icon(
              isCompleted ? Icons.check_rounded : icon,
              color: isCompleted ? AppColors.success : AppColors.primary,
              size: 22.r,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMediumBold),
                Text(subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
          Icon(
            isCompleted ? Icons.check_circle_rounded : Icons.chevron_right_rounded,
            color: isCompleted ? AppColors.success : AppColors.textHint,
            size: 22.r,
          ),
        ],
      ),
    );
  }
}
