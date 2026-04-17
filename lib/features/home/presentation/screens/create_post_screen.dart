/// create_post_screen.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _contentCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<String> _suggestedHashtags = ['#AI', '#Technology', '#Career'];

  @override
  void dispose() {
    _contentCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CGAppBar(
        title: 'Tạo bài viết',
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.close_rounded,
              size: 24.r, color: AppColors.textPrimary),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                // 🔥 2 DÒNG NÀY SẼ CỨU SỐNG APPBAR CỦA BẠN 🔥
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r)),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              ),
              child: Text('Đăng', style: AppTextStyles.buttonSmall),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1. VÙNG CUỘN CHỨA NỘI DUNG (Tự động co rút khi có bàn phím)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (!_focusNode.hasFocus) {
                    FocusScope.of(context).requestFocus(_focusNode);
                  }
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thông tin User
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.screenPaddingH,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 46.r,
                              height: 46.r,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  'HD',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nguyễn Huy Đức',
                                    style: AppTextStyles.bodyMediumBold),
                                SizedBox(height: 4.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceLight,
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.public_rounded,
                                          size: 12.r,
                                          color: AppColors.textSecondary),
                                      SizedBox(width: 4.w),
                                      Text('Công khai',
                                          style: AppTextStyles.caption),
                                      Icon(Icons.arrow_drop_down_rounded,
                                          size: 16.r,
                                          color: AppColors.textSecondary),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Text Field
                      Container(
                        constraints: BoxConstraints(minHeight: 200.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.screenPaddingH,
                        ),
                        child: TextField(
                          controller: _contentCtrl,
                          focusNode: _focusNode,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          style: AppTextStyles.bodyLarge,
                          decoration: InputDecoration(
                            hintText:
                                'Bạn đang nghĩ gì? Chia sẻ kiến thức, kinh nghiệm h...',
                            hintStyle: AppTextStyles.hint,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. VÙNG CÔNG CỤ CỐ ĐỊNH ĐÁY (Tự trượt lên theo bàn phím)
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hashtags
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.screenPaddingH,
                    vertical: 12.h,
                  ),
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: _suggestedHashtags.map((tag) {
                      return GestureDetector(
                        onTap: () {
                          final current = _contentCtrl.text;
                          final appendText =
                              current.isEmpty ? tag : '$current $tag';
                          _contentCtrl.text = appendText;
                          _contentCtrl.selection = TextSelection.fromPosition(
                            TextPosition(offset: _contentCtrl.text.length),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            tag,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const Divider(height: 1),

                // Thanh công cụ bên dưới
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.screenPaddingH,
                    vertical: 12.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ToolIcon(
                          icon: Icons.image_outlined,
                          color: AppColors.success,
                          label: 'Ảnh'),
                      _ToolIcon(
                          icon: Icons.videocam_outlined,
                          color: AppColors.error,
                          label: 'Video'),
                      _ToolIcon(
                          icon: Icons.bar_chart_rounded,
                          color: AppColors.primary,
                          label: 'Khảo sát'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _ToolIcon(
      {required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24.r),
        ),
        SizedBox(height: 6.h),
        Text(label,
            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
