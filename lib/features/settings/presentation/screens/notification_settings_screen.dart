import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../widgets/settings_card.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // Push
  bool _pushEnabled = true;

  // Social
  bool _connectInvite = true;
  bool _newMessage = true;
  bool _postLike = true;
  bool _postComment = false;
  bool _mentions = true;

  // Jobs
  bool _jobSuggestions = true;

  // Email
  bool _emailJobSuggest = true;
  bool _emailConnectUpdate = false;
  bool _newsletter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cài đặt thông báo'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          SettingsCard(
            title: 'Thông báo đẩy',
            children: [
              _buildSwitchTile(
                icon: Icons.notifications_active_outlined,
                title: 'Bật thông báo đẩy',
                value: _pushEnabled,
                onChanged: (v) => setState(() => _pushEnabled = v),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            title: 'Hoạt động mạng xã hội',
            children: [
              _buildSwitchTile(
                icon: Icons.person_add_outlined,
                title: 'Lời mời kết nối',
                value: _connectInvite,
                onChanged: (v) => setState(() => _connectInvite = v),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Tin nhắn mới',
                value: _newMessage,
                onChanged: (v) => setState(() => _newMessage = v),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.favorite_border_rounded,
                title: 'Lượt thích bài viết',
                value: _postLike,
                onChanged: (v) => setState(() => _postLike = v),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.comment_outlined,
                title: 'Bình luận bài viết',
                value: _postComment,
                onChanged: (v) => setState(() => _postComment = v),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.star_outline_rounded,
                title: 'Nhắc đến (@mention)',
                value: _mentions,
                onChanged: (v) => setState(() => _mentions = v),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            title: 'Việc làm',
            children: [
              _buildSwitchTile(
                icon: Icons.work_outline_rounded,
                title: 'Gợi ý việc làm mới',
                value: _jobSuggestions,
                onChanged: (v) => setState(() => _jobSuggestions = v),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            title: 'Email',
            children: [
              _buildSwitchTile(
                icon: Icons.email_outlined,
                title: 'Gợi ý việc làm qua email',
                value: _emailJobSuggest,
                onChanged: (v) => setState(() => _emailJobSuggest = v),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.person_outline_rounded,
                title: 'Cập nhật kết nối qua email',
                value: _emailConnectUpdate,
                onChanged: (v) => setState(() => _emailConnectUpdate = v),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.info_outline_rounded,
                title: 'Bản tin Career Global',
                value: _newsletter,
                onChanged: (v) => setState(() => _newsletter = v),
              ),
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      secondary: Icon(icon, color: AppColors.textSecondary, size: 22.r),
      title: Text(title, style: AppTextStyles.bodyMedium),
    );
  }
}
