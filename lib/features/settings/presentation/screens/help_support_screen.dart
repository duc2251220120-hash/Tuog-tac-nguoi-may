import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import 'data_security_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
              padding: EdgeInsets.zero,
              children: [
                _buildBlueSearchHeader(),
                SizedBox(height: 24.h),
                _buildQuickLinks(context),
                SizedBox(height: 24.h),
                _buildFaqSection(),
                SizedBox(height: 24.h),
                _buildContactSection(),
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
              'Trung tâm trợ giúp',
              style: AppTextStyles.h1.copyWith(fontSize: 28.sp),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildBlueSearchHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chúng tôi có thể giúp gì?',
            style: AppTextStyles.h3.copyWith(color: AppColors.white),
          ),
          SizedBox(height: 16.h),
          Container(
            height: 52.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Icon(Icons.search, color: AppColors.textHint, size: 22.r),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm câu hỏi...',
                      hintStyle: AppTextStyles.hint,
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          _buildQuickLinkCard('🔐', 'Bảo mật', onTap: () {}),
          SizedBox(width: 16.w),
          _buildQuickLinkCard(
            '🛡️',
            'Dự liệu & Bảo mật',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DataSecurityScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLinkCard(String emoji, String title, {VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(emoji, style: TextStyle(fontSize: 24.sp)),
              SizedBox(height: 12.h),
              Text(
                title,
                style: AppTextStyles.bodyMediumBold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        ),
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Câu hỏi thường gặp', style: AppTextStyles.h4),
            SizedBox(height: 12.h),
            _buildFaqItem('Làm thế nào để xóa tài khoản?'),
            _buildFaqItem('Làm thế nào để hủy gói Premium?'),
            _buildFaqItem('Tại sao tôi không nhận được thông báo?'),
            _buildFaqItem('Làm thế nào để báo cáo người dùng?'),
            _buildFaqItem('Dữ liệu của tôi có được bảo mật không?', isLast: true),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  question,
                  style: AppTextStyles.bodyMedium,
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.textHint.withValues(alpha: 0.7), size: 20.r),
            ],
          ),
        ),
        if (!isLast) Divider(color: AppColors.divider, height: 1),
      ],
    );
  }

  Widget _buildContactSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        ),
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Liên hệ hỗ trợ', style: AppTextStyles.h4),
            SizedBox(height: 16.h),
            _buildContactItem(
              icon: Icons.email_outlined,
              iconColor: const Color(0xFF1B6FD8),
              bgColor: const Color(0xFFEBF2FF),
              title: 'Gửi email',
              subtitle: 'support@careerglobal.vn',
            ),
            SizedBox(height: 16.h),
            _buildContactItem(
              icon: Icons.language_outlined,
              iconColor: const Color(0xFF10B981),
              bgColor: const Color(0xFFD1FAE5),
              title: 'Cổng trợ giúp',
              subtitle: 'help.careerglobal.vn',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
  }) {
    return Row(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.bodyMediumBold),
            Text(
              subtitle,
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }
}

