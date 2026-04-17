/// mentor_profile_screen.dart
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
import '../../../../common/widgets/cg_button.dart';

class MentorProfileScreen extends StatelessWidget {
  const MentorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Hồ sơ Mentor'),
      body: ListView(
        children: [
          Container(
            color: AppColors.white,
            padding: EdgeInsets.all(AppDimensions.screenPaddingH),
            child: Column(
              children: [
                CGAvatar(name: 'Trần Minh Khoa', size: 80.r, backgroundColor: AppColors.avatarTeal),
                SizedBox(height: 12.h),
                Text('Trần Minh Khoa', style: AppTextStyles.h3),
                Text('Principal Engineer @ Google', style: AppTextStyles.bodySmall),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_rounded, color: AppColors.warning, size: 18.r),
                    Text(' 4.9  ·  120 buổi mentoring', style: AppTextStyles.bodySmall),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(children: [
                  Expanded(child: CGButton(label: 'Đặt lịch ngay', onPressed: () => context.push(AppRoutePaths.bookMentor))),
                  SizedBox(width: 10.w),
                  Expanded(child: CGButton(label: 'Nhắn tin', type: CGButtonType.outline, onPressed: () {})),
                ]),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          _Section('Về tôi', 'Principal Engineer với 10+ năm kinh nghiệm tại Google, chuyên về mobile dev và system architecture.'),
          _Section('Chuyên môn', null, chips: ['Flutter', 'Dart', 'Android', 'iOS', 'System Design', 'Architecture']),
          _Section('Lịch trình', '- Thứ 2, 4, 6: 19:00 - 21:00\n- Cuối tuần: 9:00 - 12:00\n- Thời gian mỗi buổi: 60 phút'),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String? content;
  final List<String>? chips;
  const _Section(this.title, this.content, {this.chips});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(AppDimensions.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h4),
          SizedBox(height: 10.h),
          if (content != null) Text(content!, style: AppTextStyles.bodyMedium.copyWith(height: 1.6)),
          if (chips != null) Wrap(
            spacing: 8, runSpacing: 8,
            children: chips!.map((c) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20.r)),
              child: Text(c, style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w500)),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
