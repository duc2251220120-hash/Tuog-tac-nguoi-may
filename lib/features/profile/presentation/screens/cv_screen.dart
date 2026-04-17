/// cv_screen.dart - Màn hình xem CV
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../common/widgets/cg_app_bar.dart';
import '../../../../common/widgets/cg_button.dart';

class CvScreen extends StatelessWidget {
  const CvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CGAppBar(title: 'CV của tôi', actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.share_outlined, size: AppDimensions.iconLG)),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.download_rounded, size: AppDimensions.iconLG)),
      ]),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          // CV Preview card
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NGUYỄN HUY ĐỨC', style: AppTextStyles.h2),
                Text('Flutter Developer',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.primary)),
                Text('TP.HCM | nguyenhongduy@email.com | +84 900 000 000',
                    style: AppTextStyles.caption),
                Divider(height: 24.h),
                Text('Kinh nghiệm', style: AppTextStyles.h4),
                SizedBox(height: 8.h),
                Text('Flutter Developer - Career Global Inc.\n2023 - Hiện tại',
                    style: AppTextStyles.bodySmall),
                SizedBox(height: 12.h),
                Text('Học vấn', style: AppTextStyles.h4),
                SizedBox(height: 8.h),
                Text('Đại học Kiến trúc Đà Nẵng\nKỹ thuật Phần mềm - 2022-2026',
                    style: AppTextStyles.bodySmall),
                SizedBox(height: 12.h),
                Text('Kỹ năng', style: AppTextStyles.h4),
                SizedBox(height: 8.h),
                Text('Flutter • Dart • React Native • Firebase • REST API',
                    style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          CGButton(
              label: 'Xem trước CV',
              type: CGButtonType.outline,
              onPressed: () => context.push(AppRoutePaths.cvPreview)),
          SizedBox(height: 12.h),
          CGButton(label: 'Tạo CV mới', onPressed: () {}),
        ],
      ),
    );
  }
}
