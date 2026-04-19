import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_avatar.dart';

class EditSettingsProfileScreen extends StatelessWidget {
  const EditSettingsProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Chỉnh sửa hồ sơ'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Lưu', style: AppTextStyles.linkSmall),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        child: Column(
          children: [
            // Avatar with edit button
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CGAvatar(
                    name: 'Nguyễn Văn Bảo',
                    size: 100.r,
                    backgroundColor: AppColors.primary,
                  ),
                  Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt_rounded, color: AppColors.white, size: 20.r),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            _buildInputField('Tên đầy đủ', 'Nguyễn Văn Bảo'),
            SizedBox(height: 20.h),
            _buildInputField('Tiêu đề nghề nghiệp', 'Senior Frontend Developer tại FPT Software'),
            SizedBox(height: 20.h),
            _buildInputField('Công ty hiện tại', 'FPT Software'),
            SizedBox(height: 20.h),
            _buildInputField('Địa chỉ', 'TP. Hồ Chí Minh, Việt Nam'),
            SizedBox(height: 20.h),
            _buildInputField('Website / LinkedIn', 'github.com/nvbao'),
            SizedBox(height: 20.h),
            _buildInputField(
              'Giới thiệu bản thân',
              'Nhập một vài dòng giới thiệu về bạn...',
              isMultiline: true,
            ),
            
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã cập nhật hồ sơ thành công!')),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                ),
                child: Text('Lưu thay đổi', style: AppTextStyles.bodyMediumBold),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String value, {bool isMultiline = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.captionBold.copyWith(color: AppColors.textSecondary),
        ),
        SizedBox(height: 8.h),
        TextField(
          maxLines: isMultiline ? 4 : 1,
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
