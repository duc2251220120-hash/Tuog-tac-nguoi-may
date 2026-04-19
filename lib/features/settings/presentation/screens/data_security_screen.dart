import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_tile.dart';

class DataSecurityScreen extends StatelessWidget {
  const DataSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Dữ liệu & Bảo mật'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          SettingsCard(
            children: [
              SettingsTile(
                icon: Icons.download_rounded,
                title: 'Tải dữ liệu của bạn',
                subtitle: 'Xuất toàn bộ dữ liệu tài khoản',
                onTap: () {},
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.visibility_outlined,
                title: 'Xem dữ liệu đã chia sẻ',
                subtitle: 'Xem những gì bạn đã chia sẻ',
                onTap: () {},
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.history_rounded,
                iconColor: AppColors.success,
                iconBgColor: AppColors.successLight,
                title: 'Nhật ký bảo mật',
                subtitle: 'Lịch sử đăng nhập và hoạt động',
                onTap: () {},
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.delete_outline_rounded,
                title: 'Xóa tài khoản',
                subtitle: 'Xóa vĩnh viễn tài khoản của bạn',
                isDestructive: true,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.info.withOpacity(0.1)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.verified_user_rounded, color: AppColors.info, size: 24.r),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cam kết bảo mật', style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.info)),
                      SizedBox(height: 4.h),
                      Text(
                        'Career Global cam kết bảo vệ dữ liệu cá nhân của bạn theo đúng quy định GDPR và Luật An toàn thông tin mạng của Việt Nam.',
                        style: AppTextStyles.caption.copyWith(color: AppColors.info.withOpacity(0.8), height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
