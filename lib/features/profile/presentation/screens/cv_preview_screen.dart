/// cv_preview_screen.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';

class CvPreviewScreen extends StatelessWidget {
  const CvPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      appBar: CGAppBar(
        title: 'Xem trước CV',
        actions: [
          IconButton(
            icon: Icon(Icons.download_rounded, color: AppColors.primary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share_rounded, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80.r,
                      height: 80.r,
                      decoration: BoxDecoration(
                          color: AppColors.primary, shape: BoxShape.circle),
                      child: Center(
                          child: Text('HD',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 32.sp))),
                    ),
                    SizedBox(height: 16.h),
                    Text('NGUYỄN HUY ĐỨC',
                        style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark)),
                    SizedBox(height: 4.h),
                    Text('Senior Mobile Developer',
                        style: TextStyle(
                            fontSize: 16.sp, color: AppColors.textSecondary)),
                    SizedBox(height: 12.h),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12.w,
                      runSpacing: 4.h,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.email_outlined,
                                size: 14.r, color: AppColors.textHint),
                            SizedBox(width: 4.w),
                            Text('duy@gmail.com', style: AppTextStyles.caption),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.phone_outlined,
                                size: 14.r, color: AppColors.textHint),
                            SizedBox(width: 4.w),
                            Text('0901234567', style: AppTextStyles.caption),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // Summary
              _buildSectionTitle('Mục tiêu nghề nghiệp'),
              Text(
                  'Lập trình viên Mobile với 5 năm kinh nghiệm phát triển ứng dụng Flutter và React Native. Định hướng trở thành Technical Lead trong 2 năm tới.',
                  style: AppTextStyles.bodyMedium),
              SizedBox(height: 24.h),

              // Experience
              _buildSectionTitle('Kinh nghiệm làm việc'),
              _buildExpericenceItem(
                  'Senior Flutter Developer',
                  'FPT Software',
                  '01/2022 - Hiện tại',
                  'Phát triển ứng dụng e-commerce với 2 triệu MAU. Tối ưu code giảm 30% bộ nhớ.'),
              SizedBox(height: 16.h),
              _buildExpericenceItem(
                  'Mobile Developer',
                  'VNG',
                  '06/2019 - 12/2021',
                  'Tham gia phát triển app Zalo. Tích hợp thanh toán ZaloPay.'),
              SizedBox(height: 24.h),

              // Education
              _buildSectionTitle('Học vấn'),
              _buildExpericenceItem(
                  'Cử nhân Công nghệ Thông tin',
                  'Trường ĐH Khoa học Tự nhiên',
                  '09/2015 - 06/2019',
                  'GPA: 3.8/4.0. Đồ án tốt nghiệp đạt loại xuất sắc.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.h4.copyWith(color: AppColors.primary)),
        Divider(color: AppColors.primaryLight, thickness: 1.5, height: 16.h),
      ],
    );
  }

  Widget _buildExpericenceItem(
      String title, String company, String time, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(title, style: AppTextStyles.bodyMediumBold),
            ),
            SizedBox(width: 8.w),
            Text(time,
                style:
                    AppTextStyles.caption.copyWith(color: AppColors.textHint)),
          ],
        ),
        Text(company,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
        SizedBox(height: 4.h),
        Text(desc, style: AppTextStyles.bodyMedium),
      ],
    );
  }
}
