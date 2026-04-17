/// applied_jobs_screen.dart - Danh sách việc đã ứng tuyển
/// Bổ sung: 5 đơn ứng tuyển, progress tracker, filter tabs
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';

class AppliedJobsScreen extends StatefulWidget {
  const AppliedJobsScreen({super.key});
  @override
  State<AppliedJobsScreen> createState() => _AppliedJobsScreenState();
}

class _AppliedJobsScreenState extends State<AppliedJobsScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Tất cả', 'Đang xem xét', 'Phỏng vấn', 'Kết quả'];

  static final List<Map<String, dynamic>> _applied = [
    {
      'title': 'Senior Frontend Developer',
      'company': 'FPT Software',
      'date': '10/04/2026',
      'status': 'Phỏng vấn',
      'statusColor': AppColors.success,
      'statusIcon': Icons.calendar_today_rounded,
      'initials': 'FS',
      'color': const Color(0xFFF97316),
      'salary': '\$3,000 - \$5,000',
      'note': 'Technical Interview ngày 22/04 lúc 14:00',
      'steps': ['Nộp hồ sơ', 'Screening', 'Technical Test', 'Final Interview', 'Offer'],
      'currentStep': 3,
    },
    {
      'title': 'Product Manager',
      'company': 'VNG Corporation',
      'date': '08/04/2026',
      'status': 'Đang xem xét',
      'statusColor': AppColors.warning,
      'statusIcon': Icons.hourglass_bottom_rounded,
      'initials': 'VN',
      'color': const Color(0xFF10B981),
      'salary': '\$2,500 - \$4,000',
      'note': 'HR đang review hồ sơ của bạn',
      'steps': ['Nộp hồ sơ', 'HR Review', 'Phỏng vấn', 'Offer'],
      'currentStep': 1,
    },
    {
      'title': 'Flutter Developer',
      'company': 'Shopee Vietnam',
      'date': '05/04/2026',
      'status': 'Screening',
      'statusColor': AppColors.primary,
      'statusIcon': Icons.phone_in_talk_rounded,
      'initials': 'SH',
      'color': const Color(0xFFEF4444),
      'salary': '\$2,000 - \$3,500',
      'note': 'Screening call ngày 18/04 lúc 10:00',
      'steps': ['Nộp hồ sơ', 'Screening', 'Phỏng vấn', 'Offer'],
      'currentStep': 1,
    },
    {
      'title': 'Mobile Developer',
      'company': 'Tiki Corporation',
      'date': '01/04/2026',
      'status': 'Từ chối',
      'statusColor': AppColors.error,
      'statusIcon': Icons.cancel_rounded,
      'initials': 'TK',
      'color': const Color(0xFF3B82F6),
      'salary': '\$1,800 - \$3,000',
      'note': 'Hồ sơ không phù hợp với yêu cầu hiện tại',
      'steps': ['Nộp hồ sơ', 'HR Review', 'Kết quả'],
      'currentStep': 2,
    },
    {
      'title': 'React Native Developer',
      'company': 'Got It Vietnam',
      'date': '28/03/2026',
      'status': 'Offer nhận',
      'statusColor': const Color(0xFF059669),
      'statusIcon': Icons.celebration_rounded,
      'initials': 'GI',
      'color': const Color(0xFF8B5CF6),
      'salary': '\$3,000 - \$5,000',
      'note': 'Chúc mừng! Offer đã được chấp nhận',
      'steps': ['Nộp hồ sơ', 'Screening', 'Technical', 'Final', 'Offer ✓'],
      'currentStep': 4,
    },
  ];

  List<Map<String, dynamic>> get _filteredJobs {
    if (_selectedTab == 0) return _applied;
    final statusMap = ['', 'Đang xem xét', 'Phỏng vấn', ''];
    if (_selectedTab == 3) {
      return _applied.where((j) =>
        (j['status'] as String) == 'Từ chối' ||
        (j['status'] as String) == 'Offer nhận'
      ).toList();
    }
    return _applied.where((j) => j['status'] == statusMap[_selectedTab]).toList();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = _filteredJobs;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Đã ứng tuyển (${_applied.length})'),
      body: Column(
        children: [
          // Summary stats
          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenPaddingH, vertical: 14.h),
            child: Row(
              children: [
                _StatChip(count: _applied.length, label: 'Tổng', color: AppColors.textSecondary),
                _StatChip(count: _applied.where((j) => j['status'] == 'Phỏng vấn' || j['status'] == 'Screening').length, label: 'Phỏng vấn', color: AppColors.success),
                _StatChip(count: _applied.where((j) => j['status'] == 'Đang xem xét').length, label: 'Đang xét', color: AppColors.warning),
                _StatChip(count: _applied.where((j) => j['status'] == 'Từ chối').length, label: 'Từ chối', color: AppColors.error),
              ],
            ),
          ),
          // Tabs
          Container(
            color: AppColors.white,
            padding: EdgeInsets.fromLTRB(AppDimensions.screenPaddingH, 0, AppDimensions.screenPaddingH, 10.h),
            child: SizedBox(
              height: 34.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _tabs.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (_, i) => GestureDetector(
                  onTap: () => setState(() => _selectedTab = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      color: _selectedTab == i ? AppColors.primary : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: _selectedTab == i ? AppColors.primary : AppColors.border),
                    ),
                    alignment: Alignment.center,
                    child: Text(_tabs[i], style: AppTextStyles.caption.copyWith(
                      color: _selectedTab == i ? Colors.white : AppColors.textSecondary,
                      fontWeight: _selectedTab == i ? FontWeight.w600 : FontWeight.w400,
                    )),
                  ),
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          // List
          Expanded(
            child: jobs.isEmpty
                ? Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off_rounded, size: 48.r, color: AppColors.textHint),
                      SizedBox(height: 12.h),
                      Text('Không có đơn ứng tuyển', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint)),
                    ],
                  ))
                : ListView.separated(
                    padding: EdgeInsets.all(AppDimensions.screenPaddingH),
                    itemCount: jobs.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (_, i) => _AppliedCard(job: jobs[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _AppliedCard extends StatefulWidget {
  final Map<String, dynamic> job;
  const _AppliedCard({required this.job});
  @override
  State<_AppliedCard> createState() => _AppliedCardState();
}

class _AppliedCardState extends State<_AppliedCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final job = widget.job;
    final color = job['color'] as Color;
    final statusColor = job['statusColor'] as Color;
    final steps = job['steps'] as List<String>;
    final currentStep = job['currentStep'] as int;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.border),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: EdgeInsets.all(14.r),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44.r, height: 44.r,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(child: Text(job['initials'] as String,
                            style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 13.sp))),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(job['title'] as String, style: AppTextStyles.bodyMediumBold, maxLines: 1, overflow: TextOverflow.ellipsis),
                            SizedBox(height: 2.h),
                            Text(job['company'] as String, style: AppTextStyles.caption),
                            SizedBox(height: 2.h),
                            Text(job['salary'] as String, style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(job['statusIcon'] as IconData, size: 11.r, color: statusColor),
                                SizedBox(width: 3.w),
                                Text(job['status'] as String,
                                    style: AppTextStyles.caption.copyWith(color: statusColor, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(job['date'] as String, style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
                        ],
                      ),
                    ],
                  ),
                  // Note
                  SizedBox(height: 10.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline_rounded, size: 13.r, color: AppColors.textHint),
                        SizedBox(width: 6.w),
                        Expanded(child: Text(job['note'] as String,
                            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary))),
                      ],
                    ),
                  ),
                  // Expand indicator
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_expanded ? 'Thu gọn' : 'Xem tiến trình',
                          style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                      Icon(_expanded ? Icons.expand_less : Icons.expand_more,
                          size: 16.r, color: AppColors.primary),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Progress tracker (expandable)
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: EdgeInsets.all(14.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tiến trình ứng tuyển', style: AppTextStyles.label.copyWith(color: AppColors.textHint)),
                  SizedBox(height: 14.h),
                  Row(
                    children: steps.asMap().entries.map((e) {
                      final i = e.key;
                      final step = e.value;
                      final isDone = i < currentStep;
                      final isActive = i == currentStep;
                      return Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: 28.r, height: 28.r,
                                    decoration: BoxDecoration(
                                      color: isDone || isActive
                                          ? (isDone ? AppColors.success : AppColors.primary)
                                          : AppColors.border,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: isDone
                                          ? Icon(Icons.check_rounded, size: 14.r, color: Colors.white)
                                          : Text('${i + 1}', style: TextStyle(
                                              color: isActive ? Colors.white : AppColors.textHint,
                                              fontSize: 11.sp, fontWeight: FontWeight.w700,
                                            )),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(step, style: AppTextStyles.caption.copyWith(
                                    fontSize: 9.sp,
                                    color: isActive ? AppColors.primary
                                        : isDone ? AppColors.success
                                        : AppColors.textHint,
                                    fontWeight: isActive || isDone ? FontWeight.w600 : FontWeight.w400,
                                  ), textAlign: TextAlign.center, maxLines: 2),
                                ],
                              ),
                            ),
                            if (i < steps.length - 1)
                              Expanded(
                                child: Container(
                                  height: 2,
                                  margin: EdgeInsets.only(bottom: 24.h),
                                  color: i < currentStep ? AppColors.success : AppColors.border,
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final int count;
  final String label;
  final Color color;
  const _StatChip({required this.count, required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text('$count', style: AppTextStyles.h3.copyWith(color: color)),
        Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
      ],
    ),
  );
}
