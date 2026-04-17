/// cg_avatar.dart
/// Widget Avatar tái sử dụng: hiển thị chữ viết tắt hoặc ảnh
/// Được dùng ở: post, story, profile, chat, job card
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class CGAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;               // Dùng để tạo chữ viết tắt
  final double size;
  final Color? backgroundColor;
  final bool showBorder;           // Viền cho story
  final Color borderColor;

  const CGAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    required this.size,
    this.backgroundColor,
    this.showBorder = false,
    this.borderColor = AppColors.primary,
  });

  /// Trích xuất 2 ký tự đầu từ tên (VD: "Nguyễn Văn Bảo" → "NV")
  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  /// Chọn màu nền ngẫu nhiên dựa trên tên (nhất quán)
  Color get _backgroundColor {
    if (backgroundColor != null) return backgroundColor!;
    final colors = [
      AppColors.avatarBlue,
      AppColors.avatarPurple,
      AppColors.avatarGreen,
      AppColors.avatarPink,
      AppColors.avatarYellow,
      AppColors.avatarOrange,
      AppColors.avatarTeal,
      AppColors.avatarRed,
    ];
    final index = name.codeUnits.fold(0, (a, b) => a + b) % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    final avatarWidget = imageUrl != null && imageUrl!.isNotEmpty
        ? CircleAvatar(
            radius: size / 2,
            backgroundImage: NetworkImage(imageUrl!),
            backgroundColor: _backgroundColor,
          )
        : CircleAvatar(
            radius: size / 2,
            backgroundColor: _backgroundColor,
            child: Text(
              _initials,
              style: TextStyle(
                color: AppColors.white,
                fontSize: (size * 0.35).sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          );

    if (showBorder) {
      return Container(
        width: size + 4.r,
        height: size + 4.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 2.5.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(2.r),
          child: avatarWidget,
        ),
      );
    }

    return avatarWidget;
  }
}

// ─── Story Avatar (với label tên bên dưới) ────────────────────────────────────
class CGStoryAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final bool isAdd;           // "+" để thêm story
  final VoidCallback? onTap;

  const CGStoryAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.isAdd = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64.w,
        child: Column(
          children: [
            // Avatar circle
            isAdd
                ? Container(
                    width: 52.r,
                    height: 52.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.border,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: AppColors.primary,
                      size: 24.r,
                    ),
                  )
                : CGAvatar(
                    imageUrl: imageUrl,
                    name: name,
                    size: 52.r,
                    showBorder: true,
                  ),

            SizedBox(height: 4.h),

            // Tên (truncate nếu dài)
            Text(
              isAdd ? 'Của bạn' : name.split(' ').last,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontSize: 11.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
