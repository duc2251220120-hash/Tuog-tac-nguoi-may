/// cg_post_card.dart
/// Widget card bài viết mạng xã hội nghề nghiệp
/// Pixel-perfect theo thiết kế "TRANG CHỦ & FEEDS.pdf"
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';
import 'cg_avatar.dart';

class CGPostCard extends StatefulWidget {
  final String authorName;
  final String authorTitle;       // Chức danh + công ty
  final String timeAgo;
  final String content;
  final String? imageUrl;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final bool isLiked;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final VoidCallback? onMore;

  const CGPostCard({
    super.key,
    required this.authorName,
    required this.authorTitle,
    required this.timeAgo,
    required this.content,
    this.imageUrl,
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.isLiked = false,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onSave,
    this.onMore,
  });

  @override
  State<CGPostCard> createState() => _CGPostCardState();
}

class _CGPostCardState extends State<CGPostCard> {
  late bool _isLiked;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _likeCount = widget.likeCount;
  }

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
    widget.onLike?.call();
  }

  /// Format số (142 → "142", 1200 → "1,2k")
  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return '$count';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.screenPaddingH,
              vertical: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Header: Avatar + tên + thời gian + menu ────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CGAvatar(
                      name: widget.authorName,
                      size: AppDimensions.avatarMD,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.authorName,
                            style: AppTextStyles.bodyMediumBold,
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            widget.authorTitle,
                            style: AppTextStyles.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            widget.timeAgo,
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 11.sp,
                              color: AppColors.textHint,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onMore,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Icon(
                          Icons.more_horiz,
                          color: AppColors.textHint,
                          size: AppDimensions.iconLG,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // ─── Nội dung bài viết ───────────────────────────────────
                Text(
                  widget.content,
                  style: AppTextStyles.bodyMedium.copyWith(height: 1.5),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // ─── Ảnh bài viết ────────────────────────────────────────────
          if (widget.imageUrl != null) ...[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                widget.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.border,
                  child: Icon(
                    Icons.image_outlined,
                    color: AppColors.textHint,
                    size: 40.r,
                  ),
                ),
              ),
            ),
          ],

          // ─── Stats + Actions ─────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.screenPaddingH,
              vertical: 8.h,
            ),
            child: Column(
              children: [
                // Like + Comment + Share count row
                Row(
                  children: [
                    // Thumbs up icon + count
                    Icon(
                      Icons.thumb_up_rounded,
                      size: 14.r,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _formatCount(_likeCount),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_formatCount(widget.commentCount)} bình luận · ${_formatCount(widget.shareCount)} chia sẻ',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),

                SizedBox(height: 8.h),
                Divider(height: 1, color: AppColors.border),
                SizedBox(height: 4.h),

                // ─── Action buttons ──────────────────────────────────────
                Row(
                  children: [
                    _ActionBtn(
                      icon: _isLiked
                          ? Icons.thumb_up_rounded
                          : Icons.thumb_up_outlined,
                      label: 'Thích',
                      color: _isLiked ? AppColors.primary : AppColors.textSecondary,
                      onTap: _handleLike,
                    ),
                    _ActionBtn(
                      icon: Icons.chat_bubble_outline_rounded,
                      label: 'Bình luận',
                      onTap: widget.onComment,
                    ),
                    _ActionBtn(
                      icon: Icons.share_outlined,
                      label: 'Chia sẻ',
                      onTap: widget.onShare,
                    ),
                    _ActionBtn(
                      icon: Icons.bookmark_outline_rounded,
                      label: 'Lưu',
                      onTap: widget.onSave,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Nút action nhỏ trong post (thích, bình luận, chia sẻ, lưu)
class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    this.color = AppColors.textSecondary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18.r),
              SizedBox(width: 4.w),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
