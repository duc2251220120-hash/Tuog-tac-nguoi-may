/// explore_screen.dart - Khám phá & Kết nối tab
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../common/widgets/cg_avatar.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  static final List<Map<String, dynamic>> _suggestions = [
    {'name': 'Lê Văn Thành', 'title': 'Software Engineer @ Google', 'mutual': 5},
    {'name': 'Nguyễn Thị Mai', 'title': 'Product Designer @ Grab', 'mutual': 3},
    {'name': 'Trần Quốc Hùng', 'title': 'Data Scientist @ Shopee', 'mutual': 8},
    {'name': 'Phạm Thị Lan', 'title': 'Marketing Manager @ Tiki', 'mutual': 2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              padding: EdgeInsets.all(AppDimensions.screenPaddingH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Kết nối', style: AppTextStyles.h2),
                      const Spacer(),
                      TextButton(
                        onPressed: () => context.push(AppRoutePaths.friends),
                        child: Text('Lời mời (3)', style: AppTextStyles.link),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.push(AppRoutePaths.search),
                          child: Container(
                            height: 44.h,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(AppDimensions.radiusFullPill),
                              border: Border.all(color: AppColors.border),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(Icons.search_rounded, color: AppColors.textHint, size: 20.r),
                                SizedBox(width: 8.w),
                                Text('Tìm người, công ty...', style: AppTextStyles.hint),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(AppDimensions.screenPaddingH),
                children: [
                  Text('Gợi ý kết nối', style: AppTextStyles.h4),
                  SizedBox(height: 12.h),
                  ..._suggestions.map((p) => _PersonCard(person: p)),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () => context.push(AppRoutePaths.connectFriends),
                    child: Text('Xem thêm gợi ý', style: AppTextStyles.link),
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

class _PersonCard extends StatefulWidget {
  final Map<String, dynamic> person;
  const _PersonCard({required this.person});

  @override
  State<_PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<_PersonCard> {
  bool _connected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CGAvatar(name: widget.person['name'] as String, size: 48.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.person['name'] as String, style: AppTextStyles.bodyMediumBold),
                Text(widget.person['title'] as String, style: AppTextStyles.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('${widget.person['mutual']} kết nối chung', style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          SizedBox(
            width: 90.w,
            height: 34.h,
            child: _connected
                ? OutlinedButton(
                    onPressed: () => setState(() => _connected = false),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                    ),
                    child: Text('Đã gửi', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                  )
                : ElevatedButton(
                    onPressed: () => setState(() => _connected = true),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.primaryLight,
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                    ),
                    child: Text('Kết nối', style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ),
          ),
        ],
      ),
    );
  }
}
