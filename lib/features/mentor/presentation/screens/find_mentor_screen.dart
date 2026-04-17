/// find_mentor_screen.dart
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../common/widgets/cg_app_bar.dart';
import '../../../../common/widgets/cg_avatar.dart';
import '../../../../common/widgets/cg_text_field.dart';

class FindMentorScreen extends StatelessWidget {
  const FindMentorScreen({super.key});

  static final List<Map<String, dynamic>> _mentors = [
    {'name': 'Trần Minh Khoa', 'title': 'Principal Engineer @ Google', 'skills': ['Flutter', 'Dart', 'Architecture'], 'rating': 4.9, 'sessions': 120},
    {'name': 'Lê Thị Phương', 'title': 'Product Lead @ Facebook', 'skills': ['Product', 'UX', 'Strategy'], 'rating': 4.8, 'sessions': 89},
    {'name': 'Nguyễn Việt Anh', 'title': 'CTO @ Startup', 'skills': ['Leadership', 'Tech', 'Startup'], 'rating': 4.7, 'sessions': 56},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Tìm Mentor'),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          CGSearchField(hint: 'Tìm mentor theo kỹ năng, ngành nghề...'),
          SizedBox(height: 16.h),
          Text('Mentor nổi bật', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          ..._mentors.map((m) => _MentorCard(mentor: m, onTap: () => context.push(AppRoutePaths.mentorProfile))),
        ],
      ),
    );
  }
}

class _MentorCard extends StatelessWidget {
  final Map<String, dynamic> mentor;
  final VoidCallback? onTap;
  const _MentorCard({required this.mentor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppDimensions.radiusMD), border: Border.all(color: AppColors.border)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              CGAvatar(name: mentor['name'] as String, size: 52.r),
              SizedBox(width: 12.w),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(mentor['name'] as String, style: AppTextStyles.bodyMediumBold),
                Text(mentor['title'] as String, style: AppTextStyles.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 4.h),
                Row(children: [
                  Icon(Icons.star_rounded, color: AppColors.warning, size: 14.r),
                  SizedBox(width: 2.w),
                  Text('${mentor['rating']}', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(width: 6.w),
                  Text('${mentor['sessions']} buổi', style: AppTextStyles.caption),
                ]),
              ])),
            ]),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 6.w, runSpacing: 6.h,
              children: (mentor['skills'] as List<String>).map((s) => Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20.r)),
                child: Text(s, style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
