/// company_profile_screen.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_button.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.h,
            pinned: true,
            backgroundColor: AppColors.primaryDark,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle),
                child: Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white, size: 16.r),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark]),
                ),
                child: Center(
                    child: Icon(Icons.business_rounded,
                        size: 80.r,
                        color: Colors.white.withValues(alpha: 0.2))),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: Offset(0, -40.h),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.screenPaddingH),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 80.r,
                          height: 80.r,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border:
                                Border.all(color: AppColors.border, width: 2),
                            boxShadow: [
                              BoxShadow(color: AppColors.shadow, blurRadius: 10)
                            ],
                          ),
                          child: Center(
                              child: Text('VN',
                                  style: TextStyle(
                                      color: const Color(0xFF10B981),
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w800))),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('VNG Corporation', style: AppTextStyles.h1),
                              SizedBox(height: 4.h),
                              Text('124,532 người đang theo dõi',
                                  style: AppTextStyles.caption
                                      .copyWith(color: AppColors.textHint)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: CGButton(
                            label: _isFollowing ? 'Đang theo dõi' : 'Theo dõi',
                            onPressed: () =>
                                setState(() => _isFollowing = !_isFollowing),
                            type: _isFollowing
                                ? CGButtonType.outline
                                : CGButtonType.primary,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CGButton(
                            label: 'Xem trang web',
                            onPressed: () {},
                            type: CGButtonType.secondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    _buildInfoSection('Về chung tôi',
                        'Kiến tạo công nghệ và phát triển con người. Từ những sản phẩm nội dung phi vật thể đến công nghệ lõi như AI, Cloud, data...'),
                    SizedBox(height: 16.h),
                    _buildInfoSection('Ngành nghề', 'IT - Phần mềm / Game'),
                    SizedBox(height: 16.h),
                    _buildInfoSection('Quy mô', '1,000 - 4,999 nhân viên'),
                    SizedBox(height: 16.h),
                    _buildInfoSection('Trụ sở chính',
                        'Z06 Đường số 13, Tân Thuận Đông, Quận 7, TP.HCM'),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('Việc làm đang tuyển (24)',
                              style: AppTextStyles.h3),
                        ),
                        SizedBox(width: 8.w),
                        Text('Xem tất cả', style: AppTextStyles.linkSmall),
                      ],
                    ),
                    SizedBox(height: 400.h), // Placeholder for jobs
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style:
                AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
        SizedBox(height: 4.h),
        Text(content, style: AppTextStyles.bodyMedium),
      ],
    );
  }
}
