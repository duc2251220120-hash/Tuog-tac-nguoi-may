/// edit_profile_screen.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';
import '../../../../common/widgets/cg_button.dart';
import '../../../../common/widgets/cg_text_field.dart';
import '../../../../common/widgets/cg_avatar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CGAppBar(title: 'Chỉnh sửa hồ sơ'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CGAvatar(
                      name: 'Nguyễn Huy Đức',
                      size: 88.r,
                      backgroundColor: AppColors.avatarBlue),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28.r,
                      height: 28.r,
                      decoration: const BoxDecoration(
                          color: AppColors.primary, shape: BoxShape.circle),
                      child: Icon(Icons.camera_alt_rounded,
                          color: AppColors.white, size: 16.r),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.h),
            Row(
              children: [
                Expanded(child: CGTextField(label: 'Họ', hint: 'Nguyễn')),
                SizedBox(width: 12.w),
                Expanded(child: CGTextField(label: 'Tên', hint: 'Huy Đức')),
              ],
            ),
            SizedBox(height: 16.h),
            CGTextField(label: 'Chức danh', hint: 'Flutter Developer'),
            SizedBox(height: 16.h),
            CGTextField(label: 'Công ty hiện tại', hint: 'Career Global Inc.'),
            SizedBox(height: 16.h),
            CGTextField(label: 'Địa điểm', hint: 'TP.Đà Nẵng, Việt Nam'),
            SizedBox(height: 16.h),
            CGTextField(
                label: 'Giới thiệu bản thân',
                hint: 'Mô tả ngắn về bản thân...',
                maxLines: 3),
            SizedBox(height: 16.h),
            CGTextField(
                label: 'Website / LinkedIn',
                hint: 'https://linkedin.com/in/...'),
            SizedBox(height: 32.h),
            CGButton(label: 'Lưu thay đổi', onPressed: () => context.pop()),
          ],
        ),
      ),
    );
  }
}
