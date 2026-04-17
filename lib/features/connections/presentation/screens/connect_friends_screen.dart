/// connect_friends_screen.dart
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';
import '../../../../common/widgets/cg_avatar.dart';

class ConnectFriendsScreen extends StatelessWidget {
  const ConnectFriendsScreen({super.key});

  static const List<String> _people = ['Hoàng Anh Tuấn', 'Bùi Thị Hường', 'Đặng Văn Khánh', 'Lý Mỹ Nhung', 'Phúc Nguyên'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Kết nối bạn bè'),
      body: ListView.separated(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        itemCount: _people.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (_, i) => _ConnectCard(name: _people[i]),
      ),
    );
  }
}

class _ConnectCard extends StatefulWidget {
  final String name;
  const _ConnectCard({required this.name});
  @override
  State<_ConnectCard> createState() => _ConnectCardState();
}
class _ConnectCardState extends State<_ConnectCard> {
  bool _sent = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppDimensions.radiusMD), border: Border.all(color: AppColors.border)),
      child: Row(children: [
        CGAvatar(name: widget.name, size: 44.r),
        SizedBox(width: 12.w),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.name, style: AppTextStyles.bodyMediumBold),
          Text('Bạn có thể biết người này', style: AppTextStyles.caption),
        ])),
        GestureDetector(
          onTap: () => setState(() => _sent = !_sent),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: _sent ? AppColors.surfaceLight : AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: _sent ? AppColors.border : AppColors.primary),
            ),
            child: Text(_sent ? 'Đã gửi' : 'Kết nối',
                style: AppTextStyles.caption.copyWith(color: _sent ? AppColors.textSecondary : AppColors.primary, fontWeight: FontWeight.w600)),
          ),
        ),
      ]),
    );
  }
}
