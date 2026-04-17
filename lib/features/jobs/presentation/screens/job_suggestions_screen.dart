/// job_suggestions_screen.dart
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';
import '../../../../common/widgets/cg_job_card.dart';

class JobSuggestionsScreen extends StatelessWidget {
  const JobSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Việc làm gợi ý'),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            ),
            child: Row(
              children: [
                Icon(Icons.auto_awesome_rounded, color: AppColors.white, size: 24.r),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'Dựa trên hồ sơ của bạn, chúng tôi tìm thấy 12 việc phù hợp',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          CGJobCard(
            jobTitle: 'Flutter Developer',
            companyName: 'Shopee Vietnam',
            companyInitials: 'SH',
            companyColor: AppColors.warning,
            location: 'TP.HCM',
            salary: '\$2,500 - \$4,500',
            postedAgo: 'Hôm nay',
            jobType: JobType.fullTime,
            isUrgent: true,
            onTap: () {},
          ),
          CGJobCard(
            jobTitle: 'Mobile Developer',
            companyName: 'Tiki Corporation',
            companyInitials: 'TK',
            companyColor: AppColors.avatarBlue,
            location: 'TP.HCM',
            salary: '\$2,000 - \$3,500',
            postedAgo: '1 ngày trước',
            jobType: JobType.fullTime,
            onTap: () {},
          ),
          CGJobCard(
            jobTitle: 'React Native Developer',
            companyName: 'Got It Vietnam',
            companyInitials: 'GI',
            companyColor: AppColors.avatarPurple,
            location: 'Remote',
            salary: '\$3,000 - \$5,000',
            postedAgo: '2 ngày trước',
            jobType: JobType.remote,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
