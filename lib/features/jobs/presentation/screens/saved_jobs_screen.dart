/// saved_jobs_screen.dart
library;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';
import '../../../../common/widgets/cg_job_card.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Việc đã lưu'),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          CGJobCard(
            jobTitle: 'Product Manager',
            companyName: 'VNG Corporation',
            companyInitials: 'VN',
            companyColor: AppColors.avatarBlue,
            location: 'TP.HCM',
            salary: '\$4,000 - \$7,000',
            postedAgo: '1 ngày trước',
            jobType: JobType.fullTime,
            isSaved: true,
            isUrgent: true,
            onTap: () {},
          ),
          CGJobCard(
            jobTitle: 'Business Analyst',
            companyName: 'KPMG Vietnam',
            companyInitials: 'KP',
            companyColor: AppColors.avatarTeal,
            location: 'Hà Nội',
            salary: '\$1,500 - \$2,500',
            postedAgo: '3 ngày trước',
            jobType: JobType.fullTime,
            isSaved: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
