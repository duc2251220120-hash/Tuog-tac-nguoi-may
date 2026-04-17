/// job_search_screen.dart
/// Màn hình Tìm việc làm - Pixel-perfect theo "TÌM VIỆC LÀM.pdf"
/// Search bar + Filter tags + Job List
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../common/widgets/cg_text_field.dart';
import '../../../../common/widgets/cg_button.dart';
import '../../../../common/widgets/cg_job_card.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['Tất cả', 'TP.HCM', 'Hà Nội', 'Remote', 'Full-time'];

  static final List<Map<String, dynamic>> _jobs = [
    {
      'title': 'Senior Frontend Developer',
      'company': 'FPT Software',
      'color': const Color(0xFFFF6B35),
      'location': 'TP.HCM',
      'salary': '\$3,000 - \$5,000',
      'time': '2 ngày trước',
      'type': JobType.fullTime,
      'urgent': true,
      'saved': false,
    },
    {
      'title': 'Product Manager',
      'company': 'VNG Corporation',
      'color': AppColors.avatarBlue,
      'location': 'TP.HCM',
      'salary': '\$4,000 - \$7,000',
      'time': '1 ngày trước',
      'type': JobType.fullTime,
      'urgent': true,
      'saved': true,
    },
    {
      'title': 'Data Engineer',
      'company': 'Momo',
      'color': AppColors.avatarPink,
      'location': 'Remote',
      'salary': '\$2,500 - \$4,000',
      'time': '3 ngày trước',
      'type': JobType.remote,
      'urgent': false,
      'saved': false,
    },
    {
      'title': 'UI/UX Designer',
      'company': 'Zalo',
      'color': AppColors.avatarTeal,
      'location': 'TP.HCM',
      'salary': '\$2,000 - \$3,500',
      'time': 'Hôm nay',
      'type': JobType.fullTime,
      'urgent': false,
      'saved': false,
    },
    {
      'title': 'Java Backend Developer',
      'company': 'Techcombank',
      'color': AppColors.error,
      'location': 'Hà Nội',
      'salary': '\$2,000 - \$3,500',
      'time': '5 ngày trước',
      'type': JobType.fullTime,
      'urgent': false,
      'saved': false,
    },
    {
      'title': 'DevOps Engineer',
      'company': 'Grab Vietnam',
      'color': AppColors.success,
      'location': 'TP.HCM',
      'salary': '\$3,500 - \$6,000',
      'time': 'Hôm nay',
      'type': JobType.fullTime,
      'urgent': true,
      'saved': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimensions.screenPaddingH,
                16.h,
                AppDimensions.screenPaddingH,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Title ────────────────────────────────────────────
                  Text('Tìm việc làm', style: AppTextStyles.h2),
                  SizedBox(height: 14.h),

                  // ─── Search bar + Filter icon ──────────────────────────
                  CGSearchField(
                    hint: 'Chức danh, kỹ năng...',
                    onFilterTap: () => context.push(AppRoutePaths.jobFilter),
                  ),

                  SizedBox(height: 14.h),

                  // ─── Filter tab chips ──────────────────────────────────
                  SizedBox(
                    height: 36.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (_, __) => SizedBox(width: 8.w),
                      itemBuilder: (_, i) => CGTagButton(
                        label: _filters[i],
                        isSelected: _selectedFilter == i,
                        onTap: () => setState(() => _selectedFilter = i),
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // ─── Count + Sort ──────────────────────────────────────
                  Row(
                    children: [
                      Text(
                        '${_jobs.length} việc làm phù hợp',
                        style: AppTextStyles.bodySmall,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text('Sắp xếp', style: AppTextStyles.link),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),
                ],
              ),
            ),

            // ─── Job List ────────────────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.screenPaddingH,
                  vertical: 8.h,
                ),
                itemCount: _jobs.length,
                itemBuilder: (_, i) {
                  final job = _jobs[i];
                  return CGJobCard(
                    jobTitle: job['title'] as String,
                    companyName: job['company'] as String,
                    companyInitials: job['company'].toString().substring(0, 2),
                    companyColor: job['color'] as Color,
                    location: job['location'] as String,
                    salary: job['salary'] as String,
                    postedAgo: job['time'] as String,
                    jobType: job['type'] as JobType,
                    isUrgent: job['urgent'] as bool,
                    isSaved: job['saved'] as bool,
                    onTap: () => context.push(AppRoutePaths.jobDetail),
                    onSave: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
