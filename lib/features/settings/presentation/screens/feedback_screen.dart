import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _rating = 0;
  final Set<String> _selectedCategories = {};
  final List<String> _categories = [
    'Giao diện', 'Tìm việc làm', 'Kết nối', 'Tin nhắn', 'Hiệu suất', 'Khác'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Gửi phản hồi'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.h),
            Text('Bạn đánh giá Career App thế nào?', style: AppTextStyles.bodyMediumBold),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => IconButton(
                onPressed: () => setState(() => _rating = index + 1),
                icon: Icon(
                  index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: index < _rating ? Colors.amber : AppColors.textHint,
                  size: 40.r,
                ),
              )),
            ),
            SizedBox(height: 32.h),
            
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Thuộc về', style: AppTextStyles.captionBold.copyWith(color: AppColors.textSecondary)),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _categories.map((cat) {
                bool isSelected = _selectedCategories.contains(cat);
                return FilterChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (v) {
                    setState(() {
                      if (v) _selectedCategories.add(cat);
                      else _selectedCategories.remove(cat);
                    });
                  },
                  selectedColor: AppColors.primaryLight,
                  checkmarkColor: AppColors.primary,
                  labelStyle: AppTextStyles.caption.copyWith(
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 32.h),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Chi tiết phản hồi', style: AppTextStyles.captionBold.copyWith(color: AppColors.textSecondary)),
            ),
            SizedBox(height: 8.h),
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Chia sẻ ý kiến, góp ý hoặc báo cáo lỗi của bạn...',
                hintStyle: AppTextStyles.caption.copyWith(color: AppColors.textHint),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
                counterText: '0/500',
              ),
            ),
            SizedBox(height: 24.h),
            
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.attachment_rounded, size: 20.r),
              label: const Text('Đính kèm ảnh chụp màn hình (tùy chọn)'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            
            SizedBox(height: 48.h),
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cảm ơn bạn đã gửi phản hồi!')),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                ),
                child: Text('Gửi phản hồi', style: AppTextStyles.bodyMediumBold),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
