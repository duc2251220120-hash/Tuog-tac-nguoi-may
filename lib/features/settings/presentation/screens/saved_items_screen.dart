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
        backgroundColor: const Color(0xFFF8F9FA),
        body: Column(
          children: [
            SafeArea(
              bottom: false,
              left: false,
              right: false,
              child: _buildCustomAppBar(context),
            ),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  _buildAllTab(),
                  const Center(child: Text('Chưa có bài viết nào')),
                  const Center(child: Text('Chưa có việc làm nào')),
                  const Center(child: Text('Chưa có công ty nào')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(0, 12.h, 16.w, 12.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 24.r),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          SizedBox(width: 12.w),
          Text(
            'Đã lưu',
            style: AppTextStyles.h2.copyWith(fontSize: 22.sp),
          ),
          const Spacer(),
          Container(
            width: 28.r,
            height: 28.r,
            decoration: const BoxDecoration(
              color: Color(0xFFEBF2FF),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '3',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColors.white,
      width: double.infinity,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: AppColors.primary,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 16.w),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTextStyles.bodyMediumBold,
        unselectedLabelStyle: AppTextStyles.bodyMedium,
        dividerColor: AppColors.border.withValues(alpha: 0.5),
        tabs: const [
          Tab(text: 'Tất cả'),
          Tab(text: 'Bài viết'),
          Tab(text: 'Việc đã ứng tuyển'),
          Tab(text: 'Công ty'),
        ],
      ),
    );
  }

  Widget _buildAllTab() {
    return ListView(
      padding: EdgeInsets.all(20.w),
      children: [
        _buildSavedItem(
          name: 'Trần Thị Nhật',
          role: 'PM @ VNG',
          time: '3 ngày trước',
          content: 'Vừa hoàn thành dự án lớn nhất trong sự nghiệp! 🚀 Cảm ơn team tuyệt vời...',
          type: 'Bài viết',
          avatarColor: const Color(0xFFA855F7),
        ),
        SizedBox(height: 16.h),
        _buildSavedItem(
          name: 'Lê Văn Lâm',
          role: 'DS @ Momo',
          time: '1 tuần trước',
          content: 'Chia sẻ một số xu hướng AI/ML nổi bật trong năm 202...',
          type: 'Bài viết',
          avatarColor: const Color(0xFF10B981),
        ),
        SizedBox(height: 16.h),
        _buildSavedItem(
          name: 'FPT Software',
          role: 'Công ty',
          time: '2 tuần trước',
          content: 'Senior Frontend Developer - \$3,000 - \$5,000/tháng',
          type: 'Việc làm',
          avatarColor: const Color(0xFFF97316),
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
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CGAvatar(name: name, size: 48.r, backgroundColor: avatarColor),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: AppTextStyles.bodyMediumBold),
                              SizedBox(height: 2.h),
                              Text(role, style: AppTextStyles.caption),
                              Text(
                                time,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textHint,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEBF2FF),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                type,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Icon(Icons.bookmark_rounded, color: AppColors.primary, size: 22.r),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            content,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary, height: 1.4),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}


