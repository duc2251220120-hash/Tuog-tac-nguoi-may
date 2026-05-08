import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';

class DataSecurityScreen extends StatelessWidget {
  const DataSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            left: false,
            right: false,
            child: _buildCustomAppBar(context),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              children: [
                _buildMenuItem(
                  icon: Icons.file_download_outlined,
                  iconColor: const Color(0xFF1B6FD8),
                  bgColor: const Color(0xFFEBF2FF),
                  title: 'Tải dữ liệu của bạn',
                  subtitle: 'Xuất toàn bộ dữ liệu tài khoản',
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                _buildMenuItem(
                  icon: Icons.visibility_outlined,
                  iconColor: const Color(0xFF8B5CF6),
                  bgColor: const Color(0xFFF3E8FF),
                  title: 'Xem dữ liệu đã chia sẻ',
                  subtitle: 'Xem những gì bạn đã chia sẻ',
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                _buildMenuItem(
                  icon: Icons.verified_user_outlined,
                  iconColor: const Color(0xFF10B981),
                  bgColor: const Color(0xFFD1FAE5),
                  title: 'Nhật ký bảo mật',
                  subtitle: 'Lịch sử đăng nhập và hoạt động',
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                _buildMenuItem(
                  icon: Icons.delete_outline_rounded,
                  iconColor: const Color(0xFFEF4444),
                  bgColor: const Color(0xFFFEE2E2),
                  title: 'Xóa tài khoản',
                  subtitle: 'Xóa vĩnh viễn tài khoản của bạn',
                  onTap: () {},
                ),
                SizedBox(height: 24.h),
                _buildCommitmentCard(),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(0, 8.h, 16.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 24.r),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              'Dữ liệu & Bảo mật',
              style: AppTextStyles.h1.copyWith(fontSize: 28.sp),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22.r),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodyMediumBold),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textHint.withValues(alpha: 0.7), size: 20.r),
          ],
        ),
      ),
    );
  }

  Widget _buildCommitmentCard() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F7FF),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline_rounded, color: AppColors.primary, size: 22.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cam kết bảo mật',
                  style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.primary),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Career Global cam kết bảo vệ dữ liệu cá nhân của bạn theo đúng quy định GDPR và Luật An toàn thông tin mạng của Việt Nam.',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

