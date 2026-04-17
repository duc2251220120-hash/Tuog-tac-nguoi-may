/// notifications_screen.dart
/// Bổ sung: nhóm thông báo (Hôm nay / Tuần này), 10 thông báo, tương tác Đánh dấu đọc
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> _notifications = [
    // Hôm nay
    {
      'name': 'FPT Software',
      'msg': 'đã xem hồ sơ của bạn · Họ đang tìm Senior Frontend Developer',
      'time': '2 phút trước',
      'type': 'view',
      'group': 'Hôm nay',
      'unread': true,
      'avatar': 'FS',
      'color': const Color(0xFFF97316),
    },
    {
      'name': 'Trần Minh Khoa',
      'msg': 'đã chấp nhận lời mời kết nối của bạn 🎉',
      'time': '15 phút trước',
      'type': 'connect',
      'group': 'Hôm nay',
      'unread': true,
      'avatar': 'TK',
      'color': const Color(0xFF06B6D4),
    },
    {
      'name': 'VNG Corporation',
      'msg': 'mời bạn ứng tuyển vị trí Product Manager · Lương \$3,000-5,000',
      'time': '1 giờ trước',
      'type': 'job',
      'group': 'Hôm nay',
      'unread': true,
      'avatar': 'VN',
      'color': const Color(0xFF10B981),
    },
    {
      'name': 'Nguyễn Như Ý',
      'msg': 'đã thích bài viết của bạn: "Vừa hoàn thành dự án lớn..."',
      'time': '2 giờ trước',
      'type': 'like',
      'group': 'Hôm nay',
      'unread': true,
      'avatar': 'NÝ',
      'color': const Color(0xFF9333EA),
    },
    {
      'name': 'Phạm Duy',
      'msg': 'đã bình luận bài viết của bạn: "Bài viết rất hay, cảm ơn!"',
      'time': '4 giờ trước',
      'type': 'comment',
      'group': 'Hôm nay',
      'unread': false,
      'avatar': 'PD',
      'color': const Color(0xFF3B82F6),
    },
    // Tuần này
    {
      'name': 'Career Global',
      'msg': 'Hồ sơ của bạn đã được 23 nhà tuyển dụng xem trong tuần này! 📈',
      'time': 'Hôm qua',
      'type': 'system',
      'group': 'Tuần này',
      'unread': false,
      'avatar': 'CG',
      'color': AppColors.primary,
    },
    {
      'name': 'Trần Thị Lan',
      'msg': 'đã gửi lời mời kết nối · 12 kết nối chung',
      'time': 'Hôm qua',
      'type': 'connect',
      'group': 'Tuần này',
      'unread': false,
      'avatar': 'TL',
      'color': const Color(0xFFEC4899),
    },
    {
      'name': 'Shopee Vietnam',
      'msg': 'đã đăng 3 việc làm phù hợp với hồ sơ của bạn',
      'time': '2 ngày trước',
      'type': 'job',
      'group': 'Tuần này',
      'unread': false,
      'avatar': 'SH',
      'color': const Color(0xFFEF4444),
    },
    {
      'name': 'Lê Văn Thành',
      'msg': 'đã chia sẻ bài viết của bạn · 24 người đã xem',
      'time': '3 ngày trước',
      'type': 'share',
      'group': 'Tuần này',
      'unread': false,
      'avatar': 'LT',
      'color': const Color(0xFF8B5CF6),
    },
    {
      'name': 'Tech Career Fair 2026',
      'msg': 'Sự kiện bắt đầu sau 6 ngày · Đừng quên đăng ký tham dự!',
      'time': '4 ngày trước',
      'type': 'event',
      'group': 'Tuần này',
      'unread': false,
      'avatar': 'TC',
      'color': AppColors.warning,
    },
  ];

  int get _unreadCount => _notifications.where((n) => n['unread'] as bool).length;

  void _markAllRead() {
    setState(() {
      _notifications = _notifications
          .map((n) => {...n, 'unread': false})
          .toList();
    });
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'view': return Icons.visibility_outlined;
      case 'like': return Icons.favorite_rounded;
      case 'job': return Icons.work_rounded;
      case 'comment': return Icons.chat_bubble_rounded;
      case 'connect': return Icons.person_add_rounded;
      case 'share': return Icons.share_rounded;
      case 'event': return Icons.event_rounded;
      case 'system': return Icons.bar_chart_rounded;
      default: return Icons.notifications_rounded;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'like': return AppColors.error;
      case 'job': return AppColors.success;
      case 'connect': return AppColors.primary;
      case 'view': return AppColors.warning;
      case 'share': return const Color(0xFF06B6D4);
      case 'event': return AppColors.warning;
      case 'system': return AppColors.primary;
      default: return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final groups = ['Hôm nay', 'Tuần này'];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(
        title: 'Thông báo${_unreadCount > 0 ? " ($_unreadCount)" : ""}',
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: Text('Đọc tất cả', style: AppTextStyles.linkSmall),
            ),
        ],
      ),
      body: ListView(
        children: groups.map((group) {
          final items = _notifications.where((n) => n['group'] == group).toList();
          if (items.isEmpty) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group header
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.screenPaddingH, 14.h,
                  AppDimensions.screenPaddingH, 6.h,
                ),
                child: Text(group,
                    style: AppTextStyles.h4.copyWith(fontSize: 13.sp)),
              ),
              // Items
              Container(
                color: AppColors.white,
                child: Column(
                  children: items.asMap().entries.map((entry) {
                    final i = entry.key;
                    final n = entry.value;
                    final iconColor = _getIconColor(n['type'] as String);
                    final avatarColor = n['color'] as Color;
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (n['unread'] as bool) {
                              setState(() {
                                final idx = _notifications.indexOf(n);
                                _notifications[idx] = {...n, 'unread': false};
                              });
                            }
                          },
                          child: Container(
                            color: (n['unread'] as bool)
                                ? AppColors.primaryLight.withValues(alpha: 0.35)
                                : AppColors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Avatar with badge
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 48.r, height: 48.r,
                                        decoration: BoxDecoration(
                                          color: avatarColor.withValues(alpha: 0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            n['avatar'] as String,
                                            style: TextStyle(
                                              color: avatarColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -2, right: -2,
                                        child: Container(
                                          width: 20.r, height: 20.r,
                                          decoration: BoxDecoration(
                                            color: iconColor,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
                                          child: Icon(_getIcon(n['type'] as String),
                                              size: 10.r, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 12.w),
                                  // Content
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: AppTextStyles.bodyMedium.copyWith(height: 1.4),
                                            children: [
                                              TextSpan(
                                                text: '${n['name']} ',
                                                style: const TextStyle(fontWeight: FontWeight.w700),
                                              ),
                                              TextSpan(text: n['msg'] as String),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(n['time'] as String,
                                            style: AppTextStyles.caption.copyWith(
                                              color: (n['unread'] as bool)
                                                  ? AppColors.primary
                                                  : AppColors.textHint,
                                              fontWeight: (n['unread'] as bool)
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  // Unread dot
                                  if (n['unread'] as bool)
                                    Container(
                                      width: 9.r, height: 9.r,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (i < items.length - 1)
                          const Divider(height: 1, indent: 76),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 8.h),
            ],
          );
        }).toList(),
      ),
    );
  }
}
