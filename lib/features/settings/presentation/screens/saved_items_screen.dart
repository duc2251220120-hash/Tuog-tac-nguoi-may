import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_avatar.dart';

class SavedItemsScreen extends StatelessWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Đã lưu'),
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.textPrimary,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: AppTextStyles.bodyMediumBold,
            unselectedLabelStyle: AppTextStyles.bodyMedium,
            tabs: const [
              Tab(text: 'Tất cả'),
              Tab(text: 'Bài viết'),
              Tab(text: 'Việc đã ứng tuyển'),
              Tab(text: 'Công ty'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAllTab(),
            const Center(child: Text('Chưa có bài viết nào')),
            const Center(child: Text('Chưa có việc làm nào')),
            const Center(child: Text('Chưa có công ty nào')),
          ],
        ),
      ),
    );
  }

  Widget _buildAllTab() {
    return ListView(
      padding: EdgeInsets.all(AppDimensions.screenPaddingH),
      children: [
        _buildSavedItem(
          name: 'Trần Thị Nhật',
          role: 'PM @ VNG',
          time: '3 ngày trước',
          content: 'Vừa hoàn thành dự án lớn nhất trong sự nghiệp! Cảm ơn team tuyệt vời...',
          type: 'Bài viết',
          avatarColor: Colors.purple,
        ),
        SizedBox(height: 12.h),
        _buildSavedItem(
          name: 'Lê Văn Lâm',
          role: 'DS @ Momo',
          time: '1 tuần trước',
          content: 'Chia sẻ một số xu hướng AI/ML nổi bật trong năm 2024...',
          type: 'Bài viết',
          avatarColor: Colors.green,
        ),
        SizedBox(height: 12.h),
        _buildSavedItem(
          name: 'FPT Software',
          role: 'Công ty',
          time: '2 tuần trước',
          content: 'Senior Frontend Developer · \$3,000 - \$5,000/tháng',
          type: 'Việc làm',
          avatarColor: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildSavedItem({
    required String name,
    required String role,
    required String time,
    required String content,
    required String type,
    required Color avatarColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CGAvatar(name: name, size: 40.r, backgroundColor: avatarColor),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name, style: AppTextStyles.bodyMediumBold),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                          ),
                          child: Text(
                            type,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text('$role \u2022 $time', style: AppTextStyles.caption),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.bookmark_rounded, color: AppColors.primary, size: 24.r),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            content,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, height: 1.5),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
