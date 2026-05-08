import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';

class InterviewGuideScreen extends StatelessWidget {
  const InterviewGuideScreen({super.key});

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
                _buildBlueBanner(),
                SizedBox(height: 24.h),
                _buildMenuItem('📋', 'Chuẩn bị trước phỏng vấn', onTap: () {}),
                SizedBox(height: 16.h),
                _buildMenuItem('💻', 'Kỹ năng kỹ thuật', onTap: () {}),
                SizedBox(height: 16.h),
                _buildMenuItem('🎯', 'Trong buổi phỏng vấn', onTap: () {}),
                SizedBox(height: 16.h),
                _buildMenuItem('📬', 'Sau phỏng vấn', onTap: () {}),
                SizedBox(height: 24.h),
                _buildFaqSection(),
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
              'Cẩm nang phỏng vấn',
              style: AppTextStyles.h1.copyWith(fontSize: 28.sp),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildBlueBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1B6FD8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🚀', style: TextStyle(fontSize: 32.sp)),
          SizedBox(height: 12.h),
          Text(
            'Chuẩn bị phỏng vấn thành công',
            style: AppTextStyles.h3.copyWith(color: AppColors.white),
          ),
          SizedBox(height: 6.h),
          Text(
            'Hướng dẫn từng bước để tự tin trong mọi buổi phỏng vấn',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.white.withValues(alpha: 0.9),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String emoji, String title, {required VoidCallback onTap}) {
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
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: Text(emoji, style: TextStyle(fontSize: 20.sp)),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyMediumBold,
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textHint.withValues(alpha: 0.7), size: 18.r),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqSection() {
    final questions = [
      'Hãy kể về bản thân bạn',
      'Điểm mạnh và điểm yếu của bạn là gì?',
      'Tại sao bạn muốn làm ở đây?',
      'Bạn kỳ vọng mức lương bao nhiêu?',
      'Bạn thấy mình ở đâu sau 5 năm?'
    ];

    return Container(
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
          SizedBox(height: 16.h),
          ...List.generate(questions.length, (index) {
            return _buildFaqItem(index + 1, questions[index], isLast: index == questions.length - 1);
          }),
        ],
      ),
    );
  }

  Widget _buildFaqItem(int number, String question, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            children: [
              Container(
                width: 28.r,
                height: 28.r,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBF2FF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  number.toString(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  question,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.textHint.withValues(alpha: 0.5), size: 16.r),
            ],
          ),
        ),
        if (!isLast) Divider(color: AppColors.divider, height: 1),
      ],
    );
  }
}

