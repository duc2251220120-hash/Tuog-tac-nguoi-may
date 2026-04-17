/// analytics_screen.dart - Phân tích hồ sơ
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Phân tích hồ sơ'),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          // Stats row
          Row(
            children: [
              _StatCard(value: '234', label: 'Lượt xem\nhồ sơ', icon: Icons.visibility_outlined, color: AppColors.primary),
              SizedBox(width: 10.w),
              _StatCard(value: '18', label: 'Nhà tuyển dụng\ntìm kiếm', icon: Icons.search_rounded, color: AppColors.success),
              SizedBox(width: 10.w),
              _StatCard(value: '5', label: 'Lời mời\nkết nối', icon: Icons.person_add_outlined, color: AppColors.warning),
            ],
          ),
          SizedBox(height: 20.h),

          // Chart section
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lượt xem hồ sơ (7 ngày)', style: AppTextStyles.h4),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 160.h,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 10), FlSpot(1, 25), FlSpot(2, 18),
                            FlSpot(3, 40), FlSpot(4, 30), FlSpot(5, 50), FlSpot(6, 45),
                          ],
                          isCurved: true,
                          color: AppColors.primary,
                          barWidth: 3,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.primary.withValues(alpha: 0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Điểm mạnh hồ sơ', style: AppTextStyles.h4),
                SizedBox(height: 14.h),
                _ProgressItem(label: 'Kinh nghiệm', value: 0.8),
                _ProgressItem(label: 'Học vấn', value: 0.9),
                _ProgressItem(label: 'Kỹ năng', value: 0.6),
                _ProgressItem(label: 'Hình ảnh & Thông tin', value: 0.7),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatCard({required this.value, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24.r),
            SizedBox(height: 6.h),
            Text(value, style: AppTextStyles.h3.copyWith(color: color)),
            Text(label, style: AppTextStyles.caption, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _ProgressItem extends StatelessWidget {
  final String label;
  final double value;
  const _ProgressItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTextStyles.bodySmall),
              Text('${(value * 100).toInt()}%', style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
            ],
          ),
          SizedBox(height: 6.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: AppColors.primaryLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }
}
