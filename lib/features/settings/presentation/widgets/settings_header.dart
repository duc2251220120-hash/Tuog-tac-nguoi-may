import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../common/widgets/cg_avatar.dart';

class SettingsHeader extends StatelessWidget {
  final String name;
  final String role;
  final VoidCallback onViewProfile;

  const SettingsHeader({
    super.key,
    required this.name,
    required this.role,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          CGAvatar(
            name: name,
            size: 64.r,
            backgroundColor: AppColors.primary,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.h3,
                ),
                SizedBox(height: 4.h),
                Text(
                  role,
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: onViewProfile,
                  child: Text(
                    'Xem hồ sơ',
                    style: AppTextStyles.linkSmall,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textHint,
            size: 24.r,
          ),
        ],
      ),
    );
  }
}
