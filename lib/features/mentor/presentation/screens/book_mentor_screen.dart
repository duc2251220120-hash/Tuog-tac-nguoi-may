/// book_mentor_screen.dart
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';
import '../../../../common/widgets/cg_button.dart';

class BookMentorScreen extends StatefulWidget {
  const BookMentorScreen({super.key});

  @override
  State<BookMentorScreen> createState() => _BookMentorScreenState();
}

class _BookMentorScreenState extends State<BookMentorScreen> {
  int _selectedDate = 15;
  int _selectedTime = -1;
  final List<String> _times = ['09:00', '10:00', '14:00', '15:30', '16:00', '20:00'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Đặt lịch 1:1'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(AppDimensions.screenPaddingH),
              children: [
                // Mentor brief info
                Row(
                  children: [
                    Container(
                      width: 60.r, height: 60.r,
                      decoration: const BoxDecoration(color: Color(0xFF3B82F6), shape: BoxShape.circle),
                      child: Center(child: Text('MT', style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700))),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mentor Khoa Trần', style: AppTextStyles.h3),
                          SizedBox(height: 4.h),
                          Text('Senior UX/UI Designer', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                Text('Chọn ngày', style: AppTextStyles.h4),
                SizedBox(height: 12.h),
                // Horizontal date picker
                SizedBox(
                  height: 70.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 14,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (_, i) {
                      final day = 15 + i;
                      final isSelected = day == _selectedDate;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDate = day),
                        child: Container(
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('T${(day % 7) + 2}', style: AppTextStyles.caption.copyWith(color: isSelected ? Colors.white : AppColors.textSecondary)),
                              Text('$day', style: AppTextStyles.bodyMediumBold.copyWith(color: isSelected ? Colors.white : AppColors.textPrimary)),
                            ],
                          ),
                        ),
                      );
                    }),
                ),
                SizedBox(height: 24.h),

                Text('Chọn thời gian', style: AppTextStyles.h4),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: List.generate(_times.length, (i) {
                    final isSelected = i == _selectedTime;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTime = i),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - AppDimensions.screenPaddingH * 2 - 24.w) / 3,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryLight.withValues(alpha: 0.3) : AppColors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                        ),
                        child: Center(
                          child: Text(_times[i], style: AppTextStyles.bodyMediumBold.copyWith(color: isSelected ? AppColors.primary : AppColors.textPrimary)),
                        ),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 24.h),
                Text('Chủ đề hoặc câu hỏi cho Mentor', style: AppTextStyles.h4),
                SizedBox(height: 12.h),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Nhập nội dung bạn muốn chia sẻ/hỏi đáp...',
                    fillColor: AppColors.white,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusSM), borderSide: BorderSide(color: AppColors.border)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(AppDimensions.screenPaddingH),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: CGButton(
              label: 'Xác nhận Đặt lịch',
              onPressed: _selectedTime != -1 ? () {
                // Success
                Navigator.pop(context);
              } : null,
            ),
          ),
        ],
      ),
    );
  }
}
