import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../widgets/settings_card.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Giới thiệu bạn bè'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          // Banner
          Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.info, AppColors.purpleDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              children: [
                Icon(Icons.card_giftcard_rounded, color: AppColors.white, size: 64.r),
                SizedBox(height: 16.h),
                Text(
                  'Giới thiệu & Nhận thưởng',
                  style: AppTextStyles.h3.copyWith(color: AppColors.white),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Mỗi người bạn giới thiệu thành công, bạn và bạn bè đều nhận được 30 ngày Premium miễn phí!',
                  style: AppTextStyles.caption.copyWith(color: AppColors.white.withOpacity(0.9)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            title: 'Mã giới thiệu của bạn',
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'NVBAO2026',
                            style: AppTextStyles.h2.copyWith(color: AppColors.primary, letterSpacing: 2),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.copy_rounded, size: 18.r),
                            label: const Text('Sao chép'),
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.share_outlined, size: 18.r),
                            label: const Text('Chia sẻ link'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.send_rounded, size: 18.r),
                            label: const Text('Gửi cho bạn'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                              foregroundColor: AppColors.white,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            title: 'Cách thức hoạt động',
            children: [
              _buildStepTile('1', 'Chia sẻ mã của bạn', 'Gửi mã giới thiệu cho bạn bè'),
              const Divider(height: 1),
              _buildStepTile('2', 'Bạn bè đăng ký', 'Bạn bè tạo tài khoản với mã của bạn'),
              const Divider(height: 1),
              _buildStepTile('3', 'Cả hai nhận thưởng', 'Mỗi người nhận 30 ngày Premium miễn phí'),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              _buildStatCard('12', 'Đã giới thiệu'),
              SizedBox(width: 12.w),
              _buildStatCard('8', 'Đã xác nhận'),
              SizedBox(width: 12.w),
              _buildStatCard('240', 'Ngày thưởng'),
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildStepTile(String step, String title, String subtitle) {
    return ListTile(
      leading: Container(
        width: 32.r,
        height: 32.r,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(step, style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.primary)),
      ),
      title: Text(title, style: AppTextStyles.bodyMediumBold),
      subtitle: Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Text(value, style: AppTextStyles.h3.copyWith(color: AppColors.primary)),
            SizedBox(height: 4.h),
            Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
