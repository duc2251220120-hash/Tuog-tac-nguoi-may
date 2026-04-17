/// chat_screen.dart - Danh sách cuộc trò chuyện
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static final List<Map<String, dynamic>> _chats = [
    {
      'name': 'FPT Software HR',
      'last': '🎉 Chúng tôi muốn mời bạn phỏng vấn vào thứ 5 tuần này',
      'time': '5 phút',
      'unread': 1,
      'isOnline': true,
      'isPinned': true,
      'isTyping': false,
      'color': const Color(0xFFF97316),
    },
    {
      'name': 'Nguyễn Như Ý',
      'last': 'Bạn có thể review code cho tôi không? 🙏',
      'time': '12 phút',
      'unread': 2,
      'isOnline': true,
      'isPinned': false,
      'isTyping': false,
      'color': const Color(0xFF9333EA),
    },
    {
      'name': 'Trần Minh Khoa • Mentor',
      'last': 'Buổi mentor tiếp theo của chúng ta là thứ 6 nhé!',
      'time': '1 giờ',
      'unread': 0,
      'isOnline': false,
      'isPinned': true,
      'isTyping': true,
      'color': const Color(0xFF06B6D4),
    },
    {
      'name': 'Phạm Duy',
      'last': 'Meeting lúc 3h chiều nhé, đừng quên 😄',
      'time': '2 giờ',
      'unread': 0,
      'isOnline': true,
      'isPinned': false,
      'isTyping': false,
      'color': const Color(0xFF3B82F6),
    },
    {
      'name': 'Trần Thị Lan',
      'last': 'Bạn có CV tiếng Anh không? Mình sẽ refer cho công ty',
      'time': 'Hôm qua',
      'unread': 0,
      'isOnline': false,
      'isPinned': false,
      'isTyping': false,
      'color': const Color(0xFFEC4899),
    },
    {
      'name': 'VNG Recruitment',
      'last': 'Cảm ơn bạn đã ứng tuyển vị trí Product Manager',
      'time': '2 ngày',
      'unread': 0,
      'isOnline': false,
      'isPinned': false,
      'isTyping': false,
      'color': const Color(0xFF10B981),
    },
    {
      'name': 'Lê Văn Thành',
      'last': 'Bài viết của bạn rất hay, tôi đã share rồi!',
      'time': '3 ngày',
      'unread': 0,
      'isOnline': false,
      'isPinned': false,
      'isTyping': false,
      'color': const Color(0xFF8B5CF6),
    },
    {
      'name': 'Shopee Vietnam HR',
      'last': 'Hồ sơ của bạn đang được xem xét. Chúng tôi sẽ liên hệ',
      'time': '5 ngày',
      'unread': 0,
      'isOnline': false,
      'isPinned': false,
      'isTyping': false,
      'color': const Color(0xFFEF4444),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
              child: Row(
                children: [
                  Text('Tin nhắn', style: AppTextStyles.h2),
                  const Spacer(),
                  Icon(Icons.edit_outlined, size: 22.r, color: AppColors.primary),
                ],
              ),
            ),

            // Search
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 42.h,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFullPill),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 12.w),
                    Icon(Icons.search_rounded, color: AppColors.textHint, size: 20.r),
                    SizedBox(width: 8.w),
                    Text('Tìm kiếm tin nhắn...', style: AppTextStyles.hint),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12.h),
            const Divider(height: 1),

            Expanded(
              child: ListView(
                children: [
                  // Pinned conversations header
                  if (_chats.any((c) => c['isPinned'] as bool)) ...[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 6.h),
                      child: Text('📌 Ghim', style: AppTextStyles.label.copyWith(color: AppColors.textHint)),
                    ),
                    ..._chats.where((c) => c['isPinned'] as bool).map((c) => _ChatTile(chat: c)),
                    const Divider(height: 1),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 6.h),
                      child: Text('Tất cả tin nhắn', style: AppTextStyles.label.copyWith(color: AppColors.textHint)),
                    ),
                  ],
                  ..._chats.where((c) => !(c['isPinned'] as bool)).map((c) => _ChatTile(chat: c)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final Map<String, dynamic> chat;
  const _ChatTile({required this.chat});

  @override
  Widget build(BuildContext context) {
    final unread = chat['unread'] as int;
    final isOnline = chat['isOnline'] as bool;
    final isTyping = chat['isTyping'] as bool;
    final color = chat['color'] as Color;

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
          leading: Stack(
            children: [
              // Avatar with person's color
              Container(
                width: 50.r, height: 50.r,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _initials(chat['name'] as String),
                    style: TextStyle(
                      color: color,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // Online dot
              if (isOnline)
                Positioned(
                  bottom: 1, right: 1,
                  child: Container(
                    width: 13.r, height: 13.r,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  chat['name'] as String,
                  style: AppTextStyles.bodyMediumBold.copyWith(
                    fontWeight: unread > 0 ? FontWeight.w700 : FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          subtitle: isTyping
              ? Row(children: [
                  Text('Đang nhập ', style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary, fontStyle: FontStyle.italic,
                  )),
                  _TypingDots(),
                ])
              : Text(
                  chat['last'] as String,
                  style: AppTextStyles.caption.copyWith(
                    color: unread > 0 ? AppColors.textPrimary : AppColors.textSecondary,
                    fontWeight: unread > 0 ? FontWeight.w500 : FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(chat['time'] as String,
                  style: AppTextStyles.caption.copyWith(
                    color: unread > 0 ? AppColors.primary : AppColors.textHint,
                    fontWeight: unread > 0 ? FontWeight.w600 : FontWeight.w400,
                  )),
              if (unread > 0) ...[
                SizedBox(height: 4.h),
                Container(
                  width: 20.r, height: 20.r,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  child: Center(
                    child: Text('$unread', style: TextStyle(
                      color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w700,
                    )),
                  ),
                ),
              ],
            ],
          ),
          onTap: () {},
        ),
        const Divider(height: 1, indent: 76),
      ],
    );
  }

  String _initials(String name) {
    final parts = name.replaceAll(RegExp(r'•.*'), '').trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

class _TypingDots extends StatefulWidget {
  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final t = _controller.value;
        return Row(
          children: List.generate(3, (i) {
            final opacity = ((t - i * 0.2) % 1.0).clamp(0.2, 1.0);
            return Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Opacity(
                opacity: opacity,
                child: Container(
                  width: 4.r, height: 4.r,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
