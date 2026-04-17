/// comments_screen.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentCtrl = TextEditingController();

  static final List<Map<String, dynamic>> _comments = [
    {
      'name': 'Lê Văn Thành',
      'avatar': 'LT',
      'color': const Color(0xFF3B82F6),
      'time': '1 giờ trước',
      'content': 'Chúc mừng bạn nhé! Dự án tuyệt vời quá 🎉',
      'likes': 12,
      'isLiked': true,
    },
    {
      'name': 'Nguyễn Thị Mai',
      'avatar': 'NM',
      'color': const Color(0xFFEC4899),
      'time': '45 phút trước',
      'content':
          'Tuyệt vời! Team đã làm rất tốt. Chúc dự án tiếp tục gặt hái thành công.',
      'likes': 5,
      'isLiked': false,
    },
    {
      'name': 'Trần Quốc Hùng',
      'avatar': 'TH',
      'color': const Color(0xFFF97316),
      'time': '10 phút trước',
      'content': 'Rất ngưỡng mộ sự cố gắng của bạn và team.',
      'likes': 0,
      'isLiked': false,
    },
  ];

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Bình luận'),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(AppDimensions.screenPaddingH),
              itemCount: _comments.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (_, i) {
                final comment = _comments[i];
                final color = comment['color'] as Color;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.r,
                      height: 40.r,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                      child: Center(
                        child: Text(comment['avatar'] as String,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13.sp)),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.radiusMD),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comment['name'] as String,
                                    style: AppTextStyles.bodyMediumBold),
                                SizedBox(height: 4.h),
                                Text(comment['content'] as String,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Text(comment['time'] as String,
                                  style: AppTextStyles.caption
                                      .copyWith(color: AppColors.textHint)),
                              SizedBox(width: 16.w),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    comment['isLiked'] =
                                        !(comment['isLiked'] as bool);
                                    if (comment['isLiked'] as bool) {
                                      comment['likes'] =
                                          (comment['likes'] as int) + 1;
                                    } else {
                                      comment['likes'] =
                                          (comment['likes'] as int) - 1;
                                    }
                                  });
                                },
                                child: Text('Thích',
                                    style: AppTextStyles.captionBold.copyWith(
                                      color: (comment['isLiked'] as bool)
                                          ? AppColors.primary
                                          : AppColors.textSecondary,
                                    )),
                              ),
                              SizedBox(width: 16.w),
                              Text('Phản hồi',
                                  style: AppTextStyles.captionBold),
                              if ((comment['likes'] as int) > 0) ...[
                                const Spacer(),
                                Icon(Icons.thumb_up_rounded,
                                    size: 12.r, color: AppColors.primary),
                                SizedBox(width: 4.w),
                                Text('${comment['likes']}',
                                    style: AppTextStyles.caption),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(AppDimensions.screenPaddingH, 12.h,
                AppDimensions.screenPaddingH, 24.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentCtrl,
                    decoration: InputDecoration(
                      hintText: 'Viết bình luận...',
                      hintStyle: AppTextStyles.hint,
                      filled: true,
                      fillColor: AppColors.surfaceLight,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: BorderSide.none),
                      isDense: true,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // ✅ Nút gửi đã được bọc sự kiện nhấn
                GestureDetector(
                  onTap: () {
                    if (_commentCtrl.text.trim().isNotEmpty) {
                      // Xử lý gửi bình luận
                      print("Đã gửi: ${_commentCtrl.text}");

                      // Xóa chữ và ẩn bàn phím
                      _commentCtrl.clear();
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: const BoxDecoration(
                        color: AppColors.primary, shape: BoxShape.circle),
                    child: Icon(Icons.send_rounded,
                        color: Colors.white, size: 18.r),
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
