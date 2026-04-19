import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../widgets/settings_card.dart';

class InterviewGuideScreen extends StatelessWidget {
  const InterviewGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cẩm nang phỏng vấn'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          // Banner
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.info, Color(0xFF2196F3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                image: const NetworkImage('https://placeholder.com/rocket'),
                alignment: Alignment.centerRight,
                colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
                fit: BoxFit.none,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.rocket_launch_rounded, color: AppColors.white, size: 24.r),
                          SizedBox(width: 8.w),
                          Text(
                            'Chuẩn bị phỏng vấn thành công',
                            style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Hướng dẫn từng bước để tự tin trong mọi buổi phỏng vấn',
                        style: AppTextStyles.caption.copyWith(color: AppColors.white.withOpacity(0.9)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          SettingsCard(
            children: [
              _buildGuideItem(Icons.edit_note_rounded, 'Chuẩn bị trước phỏng vấn'),
              const Divider(height: 1),
              _buildGuideItem(Icons.laptop_mac_rounded, 'Kỹ năng kỹ thuật'),
              const Divider(height: 1),
              _buildGuideItem(Icons.groups_rounded, 'Trong buổi phỏng vấn'),
              const Divider(height: 1),
              _buildGuideItem(Icons.mail_outline_rounded, 'Sau phỏng vấn'),
            ],
          ),
          SizedBox(height: 24.h),

          Text('Câu hỏi thường gặp', style: AppTextStyles.bodyMediumBold),
          SizedBox(height: 12.h),
          ...List.generate(5, (index) => _buildFaqItem(index + 1)),
          
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildGuideItem(IconData icon, String title) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 24.r),
      ),
      title: Text(title, style: AppTextStyles.bodyMediumBold),
      trailing: Icon(Icons.chevron_right_rounded, color: AppColors.textHint, size: 20.r),
      onTap: () {},
    );
  }

  Widget _buildFaqItem(int number) {
    final questions = [
      'Hãy kể về bản thân bạn',
      'Điểm mạnh và điểm yếu của bạn là gì?',
      'Tại sao bạn muốn làm ở đây?',
      'Bạn kỳ vọng mức lương bao nhiêu?',
      'Bạn thấy mình ở đâu sau 5 năm?'
    ];
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 28.r, height: 28.r,
            decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(number.toString(), style: AppTextStyles.captionBold.copyWith(color: AppColors.primary)),
          ),
          SizedBox(width: 12.w),
          Expanded(child: Text(questions[number - 1], style: AppTextStyles.bodySmall)),
          Icon(Icons.chevron_right_rounded, color: AppColors.textHint, size: 20.r),
        ],
      ),
    );
  }
}
