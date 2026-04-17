/// settings_screen.dart
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../common/widgets/cg_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifJob = true;
  bool _notifConnect = true;
  bool _notifMessage = false;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Cài đặt'),
      body: ListView(
        children: [
          _SettingGroup('Thông báo', [
            _SwitchTile('Việc làm mới', _notifJob, (v) => setState(() => _notifJob = v)),
            _SwitchTile('Kết nối mới', _notifConnect, (v) => setState(() => _notifConnect = v)),
            _SwitchTile('Tin nhắn', _notifMessage, (v) => setState(() => _notifMessage = v)),
          ]),
          _SettingGroup('Giao diện', [
            _SwitchTile('Chế độ tối', _darkMode, (v) => setState(() => _darkMode = v)),
          ]),
          _SettingGroup('Tài khoản', [
            _NavTile('Bảo mật & Mật khẩu', Icons.lock_outline_rounded),
            _NavTile('Quyền riêng tư', Icons.privacy_tip_outlined),
            _NavTile('Dữ liệu & Lưu trữ', Icons.storage_outlined),
            _NavTile('Ngôn ngữ', Icons.language_rounded),
          ]),
          _SettingGroup('Hỗ trợ', [
            _NavTile('Trợ giúp & FAQ', Icons.help_outline_rounded),
            _NavTile('Gửi phản hồi', Icons.feedback_outlined),
            _NavTile('Điều khoản dịch vụ', Icons.description_outlined),
          ]),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _SettingGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SettingGroup(this.title, this.children);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
          child: Text(title, style: AppTextStyles.label.copyWith(color: AppColors.textHint, fontWeight: FontWeight.w600)),
        ),
        Container(
          color: AppColors.white,
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SwitchTile(this.label, this.value, this.onChanged);

  @override
  Widget build(BuildContext context) => SwitchListTile(
    title: Text(label, style: AppTextStyles.bodyMedium),
    value: value,
    onChanged: onChanged,
    activeThumbColor: AppColors.primary,
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
  );
}

class _NavTile extends StatelessWidget {
  final String label;
  final IconData icon;
  const _NavTile(this.label, this.icon);

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: AppColors.textSecondary, size: 22.r),
    title: Text(label, style: AppTextStyles.bodyMedium),
    trailing: Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
    onTap: () {},
  );
}
