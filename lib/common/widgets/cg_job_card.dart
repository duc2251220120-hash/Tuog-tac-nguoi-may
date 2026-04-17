/// cg_job_card.dart
/// Widget card hiển thị thông tin việc làm
/// Pixel-perfect theo thiết kế "TÌM VIỆC LÀM.pdf"
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';
import 'cg_avatar.dart';

/// Enum phân loại dạng hợp đồng
enum JobType { fullTime, partTime, remote, internship, contract }

extension JobTypeExtension on JobType {
  String get label {
    switch (this) {
      case JobType.fullTime:
        return 'Toàn thời gian';
      case JobType.partTime:
        return 'Bán thời gian';
      case JobType.remote:
        return 'Từ xa';
      case JobType.internship:
        return 'Thực tập';
      case JobType.contract:
        return 'Hợp đồng';
    }
  }

  Color get bgColor {
    switch (this) {
      case JobType.fullTime:
        return AppColors.tagFullTime;
      case JobType.partTime:
        return AppColors.tagPartTime;
      case JobType.remote:
        return AppColors.tagRemote;
      case JobType.internship:
        return AppColors.primaryLight;
      case JobType.contract:
        return const Color(0xFFF3E8FF);
    }
  }

  Color get textColor {
    switch (this) {
      case JobType.fullTime:
        return AppColors.tagFullTimeText;
      case JobType.partTime:
        return AppColors.tagPartTimeText;
      case JobType.remote:
        return AppColors.tagRemoteText;
      case JobType.internship:
        return AppColors.primary;
      case JobType.contract:
        return AppColors.purpleLight;
    }
  }
}

class CGJobCard extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final String companyInitials;
  final Color? companyColor;
  final String location;
  final String salary;
  final String postedAgo;
  final JobType jobType;
  final bool isUrgent;
  final bool isSaved;
  final VoidCallback? onTap;
  final VoidCallback? onSave;

  const CGJobCard({
    super.key,
    required this.jobTitle,
    required this.companyName,
    required this.companyInitials,
    this.companyColor,
    required this.location,
    required this.salary,
    required this.postedAgo,
    this.jobType = JobType.fullTime,
    this.isUrgent = false,
    this.isSaved = false,
    this.onTap,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppDimensions.cardPaddingH),
        margin: EdgeInsets.only(bottom: AppDimensions.cardSpacing),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header: logo + tên công ty + Bookmark ──────────────────
            Row(
              children: [
                // Logo công ty (avatar với chữ viết tắt)
                CGAvatar(
                  name: companyName,
                  size: AppDimensions.avatarMD,
                  backgroundColor: companyColor,
                ),
                SizedBox(width: 12.w),

                // Thông tin tên công ty + urgent badge
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobTitle,
                        style: AppTextStyles.jobTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        companyName,
                        style: AppTextStyles.companyName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Bookmark icon
                GestureDetector(
                  onTap: onSave,
                  child: Icon(
                    isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                    color: isSaved ? AppColors.primary : AppColors.textHint,
                    size: AppDimensions.iconLG,
                  ),
                ),
              ],
            ),

            // Urgent badge (nếu có)
            if (isUrgent) ...[
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.tagUrgent,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🔥 ', style: TextStyle(fontSize: 11.sp)),
                    Text(
                      'Tuyển gấp',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.tagUrgentText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: 10.h),

            // ─── Location + Salary + Time ────────────────────────────────
            Row(
              children: [
                Icon(Icons.location_on_outlined,
                    size: AppDimensions.iconSM, color: AppColors.textHint),
                SizedBox(width: 3.w),
                Text(location, style: AppTextStyles.caption),
                SizedBox(width: 8.w),
                Text('\$', style: AppTextStyles.caption.copyWith(
                  color: AppColors.textPrimary,
                )),
                Text(' $salary', style: AppTextStyles.salary),
                const Spacer(),
                Icon(Icons.access_time_rounded,
                    size: AppDimensions.iconSM, color: AppColors.textHint),
                SizedBox(width: 3.w),
                Text(postedAgo, style: AppTextStyles.caption),
              ],
            ),

            SizedBox(height: 8.h),

            // ─── Job Type Tag ────────────────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: jobType.bgColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
              ),
              child: Text(
                jobType.label,
                style: AppTextStyles.caption.copyWith(
                  color: jobType.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
