/// job_filter_screen.dart
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';
import '../../../../common/widgets/cg_button.dart';

class JobFilterScreen extends StatefulWidget {
  const JobFilterScreen({super.key});
  @override
  State<JobFilterScreen> createState() => _JobFilterScreenState();
}

class _JobFilterScreenState extends State<JobFilterScreen> {
  final List<String> _selectedLocations = ['TP.HCM'];
  final List<String> _selectedTypes = ['Toàn thời gian'];
  RangeValues _salaryRange = const RangeValues(1000, 8000);

  final List<String> _locations = ['TP.HCM', 'Hà Nội', 'Đà Nẵng', 'Remote', 'Quốc tế'];
  final List<String> _jobTypes = ['Toàn thời gian', 'Bán thời gian', 'Từ xa', 'Thực tập', 'Hợp đồng'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CGAppBar(title: 'Lọc việc làm'),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          Text('Địa điểm', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w, runSpacing: 8.h,
            children: _locations.map((l) => CGTagButton(
              label: l,
              isSelected: _selectedLocations.contains(l),
              onTap: () => setState(() {
                _selectedLocations.contains(l) ? _selectedLocations.remove(l) : _selectedLocations.add(l);
              }),
            )).toList(),
          ),
          SizedBox(height: 24.h),

          Text('Loại hình', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w, runSpacing: 8.h,
            children: _jobTypes.map((t) => CGTagButton(
              label: t,
              isSelected: _selectedTypes.contains(t),
              onTap: () => setState(() {
                _selectedTypes.contains(t) ? _selectedTypes.remove(t) : _selectedTypes.add(t);
              }),
            )).toList(),
          ),
          SizedBox(height: 24.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mức lương (USD)', style: AppTextStyles.h4),
              Text(
                '\$${_salaryRange.start.toInt()} - \$${_salaryRange.end.toInt()}',
                style: AppTextStyles.link,
              ),
            ],
          ),
          RangeSlider(
            values: _salaryRange,
            min: 0, max: 20000, divisions: 40,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _salaryRange = v),
          ),
          SizedBox(height: 40.h),

          CGButton(label: 'Áp dụng bộ lọc', onPressed: () => context.pop()),
          SizedBox(height: 12.h),
          CGButton(
            label: 'Xóa bộ lọc',
            type: CGButtonType.outline,
            onPressed: () => setState(() {
              _selectedLocations.clear();
              _selectedTypes.clear();
              _salaryRange = const RangeValues(1000, 8000);
            }),
          ),
        ],
      ),
    );
  }
}
