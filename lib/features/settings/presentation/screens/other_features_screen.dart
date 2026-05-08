import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/route_paths.dart';

class OtherFeaturesScreen extends StatelessWidget {
  const OtherFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Tính năng khác'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          _buildFeatureItem(
            icon: Icons.account_circle_rounded,
            iconColor: Colors.purple,
            title: 'Mentorship',
            badge: 'Phổ biến',
            onTap: () => context.push(AppRoutePaths.findMentor),
          ),
          SizedBox(height: 12.h),
          _buildFeatureItem(
            icon: Icons.bookmark_rounded,
            iconColor: Colors.indigo,
            title: 'Đã Lưu',
            onTap: () => context.push(AppRoutePaths.savedJobs),
          ),
          SizedBox(height: 12.h),
          _buildFeatureItem(
            icon: Icons.description_rounded,
            iconColor: Colors.blue,
            title: 'CV Builder',
            badge: 'Mới',
            onTap: () => context.push(AppRoutePaths.cv),
          ),
          SizedBox(height: 12.h),
          _buildFeatureItem(
            icon: Icons.track_changes_rounded,
            iconColor: Colors.orange,
            title: 'Gợi ý việc làm',
            badge: 'AI',
            onTap: () => context.push(AppRoutePaths.jobSuggestions),
          ),
          SizedBox(height: 12.h),
          _buildFeatureItem(
            icon: Icons.auto_stories_rounded,
            iconColor: Colors.lightBlue,
            title: 'Cẩm nang phỏng vấn',
            onTap: () => context.push(AppRoutePaths.guide),
          ),
          SizedBox(height: 12.h),
          _buildFeatureItem(
            icon: Icons.analytics_rounded,
            iconColor: Colors.teal,
            title: 'Phân tích hồ sơ',
            onTap: () => context.push(AppRoutePaths.analytics),
          ),
          SizedBox(height: 12.h),
          _buildFeatureItem(
            icon: Icons.group_add_rounded,
            iconColor: Colors.deepPurple,
            title: 'Chia sẻ',
            onTap: () => context.push(AppRoutePaths.settingsReferral),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24.r),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Row(
                children: [
                  Text(title, style: AppTextStyles.bodyMediumBold),
                  if (badge != null) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        badge,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: AppColors.textHint, size: 24.r),
          ],
        ),
      ),
    );
  }
}
